//
//  JSONTableTestViewController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CollectionTableViewController.h"

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

@synthesize messages,preImage;

- (void)viewDidLoad {
    self.title=@"我的收藏";
    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];

    [self loadData:[NSString stringWithFormat: @"cusId=%@",[[[SessionUtil sharedInstance] userInformation] cusId]]];
}

-(void)loadMore 
{ 
    isReload=NO;
    [indicator startAnimating];
    NSString *lastId=[[messages lastObject] msgID];
    [self loadData:[NSString stringWithFormat:@"lastId=%@&cusId=%@",lastId,[[[SessionUtil sharedInstance] userInformation] cusId]]];
}

-(void) loadData:(NSString *)param
{
    NSString *url=[ConstantUtil createRequestURL:COLLECTION_ADDR withParam:param];
    [DataSource fetchJSON:url delegate:self];
}

-(CustomCell *) createCell:(Message *)mess reuseIdentifier:(NSString *)reuseIdentifier
{
    CustomCell *cell=[[[CustomCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:reuseIdentifier] autorelease];
    UIView *view=[[[UIView alloc] init] autorelease];
    
    UIImageView *icon=[UIMakerUtil createImageView:[mess fetchIcon] frame:CGRectMake(8, 10, 24, 27)];
    
    CGFloat contentWidth = self.tableView.frame.size.width-55;
    
    UILabel *title=[UIMakerUtil createLabel:mess.msgTitle frame:CGRectMake(40, 10, contentWidth, ICON_HEIGHT)];
    title.font=[UIFont systemFontOfSize:16];
    
    // 用何種字體進行顯示
    UIFont *font = CONTENT_FONT;
    // 該行要顯示的內容
    NSString *contentTxt = mess.content;
    // 計算出顯示完內容需要的最小尺寸
    CGSize size = [contentTxt sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
    CGRect rect = CGRectMake(40, 40, 0, 0);//[cell.textLabel textRectForBounds:cell.textLabel.frame limitedToNumberOfLines:0];
    // 設置顯示榘形大小
    rect.size = size;
    UILabel *content=[UIMakerUtil createLabel:contentTxt frame:rect];
    content.font=font;
    content.numberOfLines=0;
    
    int topHeight=50;
    if (mess.picAddr!=NULL) {
        CGRect picRect=CGRectMake(40, topHeight+size.height, IMAGE_HEIGHT, IMAGE_HEIGHT);
        UIImageView *pic=[[[UIImageView alloc] initWithFrame:picRect] autorelease];
        
        topHeight+=IMAGE_HEIGHT;
        [view addSubview:pic];
        [pic setImageWithURL:[NSURL URLWithString:mess.picAddr] placeholderImage:[UIImage imageNamed:@"icon_gray"]];
        
        PropertyButton *hiddenBtn=[UIMakerUtil createHiddenButton:picRect data:[mess.picAddr stringByReplacingOccurrencesOfString:@"small" withString:@"source"]];
        [hiddenBtn addTarget:self action:@selector(zoomImage:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:hiddenBtn];
    }
    
    UILabel *time=[UIMakerUtil createLabel:mess.issueTime frame:CGRectMake(40, topHeight+size.height+5, 150, TITLE_HEIGHT)];
    time.textColor=[UIColor grayColor];
    time.font=[UIFont systemFontOfSize:10];
    
    UIButton *btnCollted=[UIMakerUtil createButton:mess.collectCount image:@"collected" frame:CGRectMake(210, topHeight+size.height, 45, 21)];
    btnCollted.enabled=NO;
    PropertyButton *btnReply=[UIMakerUtil createPropertyButton:mess.commentCount image:@"reply" frame:CGRectMake(260, topHeight+size.height, 45, 21)];
    btnReply.data=mess;
    [btnReply addTarget:self action:@selector(replyMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *line=[UIMakerUtil createImageView:@"timeline" frame:CGRectMake(20, 0, 1, topHeight+40+size.height)];
    
    [view addSubview:line];
    [view addSubview:icon];
    [view addSubview:title];
    [view addSubview:content];
    [view addSubview:time];
    [view addSubview:btnCollted];
    [view addSubview:btnReply];
    [cell setView:view];
    
    return cell;
}

-(IBAction)zoomImage:(PropertyButton *) sender
{
    self.preImage=[MWPhoto photoWithURL:[NSURL URLWithString:sender.data]];
	
	// Create browser
	MWPhotoBrowser *browser = [[[MWPhotoBrowser alloc] initWithDelegate:self] autorelease];
    //browser.displayActionButton = YES;
    
    // Modal
    UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:browser] autorelease];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:nc animated:YES];
}

-(IBAction)replyMessage:(PropertyButton *)sender
{
    ReplyInputViewController *inputViewControl=[[[ReplyInputViewController alloc] init] autorelease];
    inputViewControl.mess=sender.data;
    [self.navigationController pushViewController:inputViewControl animated:YES];
}

- (void)dealloc {
    //[self.messages release];
    [super dealloc];
}

#pragma mark - Table View datasources delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = [self.messages count];
	if (!isLastPage) { //不足一页时或者最后一页
		return count+1;
	}
    return  count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }else{
        //重要，释放cell,防止闪退方法，其他CustomCell 均可沿用
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if([indexPath row] == [self.messages count]) { 
		if (!isLastPage && [self.messages count]>0) {   //创建loadMoreCell
			cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.textLabel.text=MORE;
            cell.textLabel.font=[UIFont systemFontOfSize:12];
            cell.textLabel.textAlignment=UITextAlignmentCenter;
            indicator=[UIMakerUtil createActivityView:CGRectMake(190, 15, 10, 10)];
            [cell addSubview:indicator];
		}
	}else{
        cell = [self createCell:[self.messages objectAtIndex:indexPath.row] reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<[self.messages count]) {
        Message *mess=[self.messages objectAtIndex:indexPath.row];
        // 列寬
        CGFloat contentWidth = self.tableView.frame.size.width-55;
        // 用何種字體進行顯示
        UIFont *font = CONTENT_FONT;
        // 該行要顯示的內容
        NSString *content = [mess content];
        // 計算出顯示完內容需要的最小尺寸
        CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
        
        int topHeight=50;
        if (mess.picAddr!=NULL) {
            topHeight+=IMAGE_HEIGHT;
        }
        // 這裏返回需要的高度
        return size.height+topHeight+40; 
    }else {
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[messages count]) {
        [self loadMore];
    }else {
        DetailViewController *detail=[[[DetailViewController alloc] init] autorelease];
        detail.mess=[self.messages objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// delete item
    delMessNo=indexPath.row;
    if (editingStyle == UITableViewCellEditingStyleDelete) { 
        Message *mess=[self.messages objectAtIndex:indexPath.row];
        NSString *url=[ConstantUtil createRequestURL:DEL_COLLECTION_ADDR];
        ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
        [request addPostValue:mess.msgID forKey:@"msgId"];
        [request addPostValue:[[[SessionUtil sharedInstance] userInformation] cusId] forKey:@"cusId"];
    }
}

-(void)enterEditMode
{
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	[self.tableView setEditing:YES animated:YES];
}

-(void)leaveEditMode
{
	[self.tableView setEditing:NO animated:YES];
    //[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *jsonString = [request responseString];
    id jsonValue = [jsonString JSONValue];
    
    NSString *code = [jsonValue valueForKey:RETURN_CODE];
    if ([code isEqualToString:@"0"]) {
        if ([request.requestMethod isEqualToString:@"GET"]) {
            NSArray *array = [jsonValue valueForKey:ARRAY_NAME];
            isLastPage=[[jsonValue valueForKey:LAST_PAGE] isEqualToNumber:[NSNumber numberWithInt:1]] ? YES : NO;
            if (self.messages!=nil && !isReload) {
                [self.messages addObjectsFromArray:[Message fetchMessagesFormJson:array]];
                [self.tableView reloadData];
            }else {
                self.messages=[Message fetchMessagesFormJson:array];
            }
        }else {
            //注意:如果不删除数据，表格不会即时刷新
            [self.messages removeObjectAtIndex:delMessNo];
            [self.tableView reloadData];
        }
    }else {
        [UIMakerUtil alert:[jsonValue valueForKey:RETURN_MESSAGE] title:REQUEST_FAIL];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [UIMakerUtil alert:SERVER_ERROR title:[error localizedDescription]];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return 1;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return self.preImage;
}

@end