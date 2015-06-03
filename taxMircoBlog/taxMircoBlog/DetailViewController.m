//
//  DetailViewController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize mess,tableTop,comments,preImage;

-(void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
    isReload=YES;
	[self loadData:[NSString stringWithFormat:@"msgId=%@",self.mess.msgID]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"详情";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];

    self.tableView.tableHeaderView = [self createDetailView];

    [self loadData:[NSString stringWithFormat:@"msgId=%@",self.mess.msgID]];
}

-(void) loadData:(NSString *)param
{
    NSString *url=[ConstantUtil createRequestURL:COMMET_URL withParam:param];
    [DataSource fetchJSON:url delegate:self];
}

-(void)loadMore 
{ 
    isReload=NO;
    [indicator startAnimating];
    NSString *lastId=[[comments lastObject] commentId];
    [self loadData:[NSString stringWithFormat:@"msgId=%@&lastId=%@",self.mess.msgID,lastId]];
}

-(id)fetchCommentsFormJson:(NSArray *) array
{
    NSMutableArray *retArray=[[[NSMutableArray alloc] init] autorelease];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
			//stringWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *commentId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"comId"]];
            NSString *cusReplyName = [dic objectForKey:@"cusReplyName"];
            NSString *cusId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cusId"]];
            NSString *content = [dic objectForKey:@"content"];
            NSString *picHead = [NSString stringWithFormat:@"%@",[dic objectForKey:@"picHead"]];
            NSString *issueTime = [dic objectForKey:@"issueTime"];
            NSString *nickName = [dic objectForKey:@"nickName"];
			Comment *comment=[[[Comment alloc]init] autorelease];
            comment.commentId=commentId;
            comment.cusReplyName=cusReplyName;
            comment.cusId=cusId;
            comment.content=content;
            comment.issueTime=issueTime;
            comment.nickName=nickName;
            comment.picHead=picHead;
			[retArray addObject:comment];
		}
	}
	return retArray;
}

-(UIView *) createDetailView
{
    UIView *view=[[[UIView alloc] init] autorelease];
    CGFloat contentWidth = self.view.frame.size.width-25;
    
    UIImageView *headImage=[UIMakerUtil createImageView:@"face" frame:CGRectMake(10, 10, 50, 50)];
    
    UILabel *title=[UIMakerUtil createLabel:mess.msgTitle frame:CGRectMake(65, 10, 235, 50)];
    title.font=[UIFont systemFontOfSize:16];
    title.numberOfLines=2;
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:16];
    // 該行要顯示的內容
    NSString *contentTxt = mess.content;
    // 計算出顯示完內容需要的最小尺寸
    CGSize size = [contentTxt sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
    CGRect rect = CGRectMake(10, 70, 0, 0);
    // 設置顯示榘形大小
    rect.size = size;
    UILabel *content=[UIMakerUtil createLabel:contentTxt frame:rect];
    //content.textColor=[UIColor grayColor];
    content.font=font;
    content.numberOfLines=0;
    
    int topHeight=80;
    if (mess.picAddr!=NULL) {
        UIImageView *pic=[[[UIImageView alloc] initWithFrame:CGRectMake(40, topHeight+size.height, 80, 80)] autorelease];
        pic.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = 
        [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomPreview:)] autorelease];
        [pic addGestureRecognizer:singleTap];
        
        topHeight+=80;
        [view addSubview:pic];
        [pic setImageWithURL:[NSURL URLWithString:mess.picAddr] placeholderImage:[UIImage imageNamed:@"icon_gray"]];
    }
    
    UILabel *time=[UIMakerUtil createLabel:mess.issueTime frame:CGRectMake(10, topHeight+size.height, 150, TITLE_HEIGHT)];
    time.textColor=[UIColor grayColor];
    time.font=[UIFont systemFontOfSize:10];
    
    self.tableTop=topHeight+size.height+20;
    
    PropertyButton *btnCollected=[UIMakerUtil createPropertyButton:mess.collectCount image:@"collected" frame:CGRectMake(200, topHeight+size.height-5, 45, 21)];
    btnCollected.data=mess.msgID;
    [btnCollected addTarget:self action:@selector(collectMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnReply=[UIMakerUtil createButton:mess.commentCount image:@"reply" frame:CGRectMake(260, topHeight+size.height-5, 45, 21)];
    [btnReply addTarget:self action:@selector(replyInput:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* myView = [[[UIView alloc] initWithFrame:CGRectMake(0, self.tableTop, 320, 22)] autorelease];
    myView.backgroundColor=[UIColor grayColor];
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)] autorelease];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text=[COMMET_TITLE stringByAppendingFormat:@" (%@)",self.mess.commentCount];
    titleLabel.font=CONTENT_FONT;
    [myView addSubview:titleLabel];
    
    [view addSubview:headImage];
    [view addSubview:title];
    [view addSubview:content];
    [view addSubview:time];
    [view addSubview:btnCollected];
    [view addSubview:btnReply];
    [view addSubview:myView];
    //不设置大小，按钮会失效
    view.frame=CGRectMake(0, 0, 320, self.tableTop+22);
    
    return view;
}

-(IBAction)collectMessage:(PropertyButton *)sender
{
    //先判断是否有登录
    if ([[SessionUtil sharedInstance] isLogined]) {
        NSString *url=[ConstantUtil createRequestURL:COLLECT_URL];
        ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
        [request addPostValue:sender.data forKey:@"msgId"];
        [request addPostValue:[[[SessionUtil sharedInstance] userInformation] cusId] forKey:@"cusId"];
    }else {
        LoginViewController *loginView=[[[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
        [self.navigationController pushViewController:loginView animated:YES];
    }
}

-(IBAction)zoomPreview:(id) sender
{
    self.preImage=[MWPhoto photoWithURL:[NSURL URLWithString:[mess.picAddr stringByReplacingOccurrencesOfString:@"small" withString:@"source"]]];
	
	// Create browser
	MWPhotoBrowser *browser = [[[MWPhotoBrowser alloc] initWithDelegate:self] autorelease];
    //browser.displayActionButton = YES;
    
    // Modal
    UINavigationController *nc = [[[UINavigationController alloc] initWithRootViewController:browser] autorelease];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:nc animated:YES];
}

-(IBAction)replyInput:(id)sender
{
    if ([[SessionUtil sharedInstance] isLogined]) {
        ReplyInputViewController *inputViewControl=[[[ReplyInputViewController alloc] init] autorelease];
        inputViewControl.mess=self.mess;
        [self.navigationController pushViewController:inputViewControl animated:YES];
        if ([sender isKindOfClass:[PropertyButton class]]) {
            Comment *com=(Comment *)((PropertyButton *)sender).data;
            inputViewControl.cusId=com.cusId;
            inputViewControl.title=[NSString stringWithFormat:@"回复 %@",com.nickName];
        }
    }else{
        LoginViewController *loginView=[[[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
        [self.navigationController pushViewController:loginView animated:YES];
    }
}

-(CustomCell *) createCell:(Comment *)comment reuseIdentifier:(NSString *)reuseIdentifier
{
    CustomCell *cell=[[[CustomCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:reuseIdentifier] autorelease];
    UIView *view=[[[UIView alloc] init] autorelease];
    UILabel *nickName=[UIMakerUtil createLabel:comment.nickName frame:CGRectMake(70, 10, 100, 20)];
    UIImageView *icon=[UIMakerUtil createImageView:[NSString stringWithFormat:@"head%@",comment.picHead] frame:CGRectMake(10, 10, 50, 50)];
    PropertyButton *btnReply=[UIMakerUtil createPropertyButton:@"reply_button" frame:CGRectMake(280, 30, 22, 22)];
    btnReply.data=comment;
    [btnReply addTarget:self action:@selector(replyInput:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat contentWidth = self.tableView.frame.size.width-110;
    
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:12];
    // 該行要顯示的內容
    NSString *contentTxt = comment.content;
    // 計算出顯示完內容需要的最小尺寸
    CGSize size = [contentTxt sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
    CGRect rect = CGRectMake(70, 30, 0, 0);
    // 設置顯示榘形大小
    rect.size = size;
    UILabel *content=[UIMakerUtil createLabel:contentTxt frame:rect];
    content.textColor=[UIColor grayColor];
    content.font=font;
    content.numberOfLines=0;
    
    int topHeight=40;
    
    UILabel *time=[UIMakerUtil createLabel:comment.issueTime frame:CGRectMake(70, topHeight+size.height, 150, TITLE_HEIGHT)];
    time.textColor=[UIColor grayColor];
    time.font=[UIFont systemFontOfSize:10];
    if (comment.cusReplyName) {
        UILabel *replyLabel=[UIMakerUtil createLabel:@"回复" frame:CGRectMake(150, 10, 30, 20)];
        replyLabel.textColor=[UIColor redColor];
        replyLabel.font=font;
        UILabel *cusLabel=[UIMakerUtil createLabel:comment.cusReplyName frame:CGRectMake(180, 10, 100, 20)];
        [view addSubview:replyLabel];
        [view addSubview:cusLabel];
    }
    
    [view addSubview:nickName];
    [view addSubview:icon];
    [view addSubview:btnReply];
    [view addSubview:content];
    [view addSubview:time];

    [cell setView:view];
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *jsonString = [request responseString];
    id jsonValue = [jsonString JSONValue];
    NSString *code = [jsonValue valueForKey:RETURN_CODE];
    if ([code isEqualToString:@"0"]) {
        if ([request.requestMethod isEqualToString:@"GET"]) {   //列表请求
            NSArray *array = [jsonValue valueForKey:ARRAY_NAME];
            isLastPage=[[jsonValue valueForKey:LAST_PAGE] isEqualToNumber:[NSNumber numberWithInt:1]] ? YES : NO;
            if (self.comments!=nil && !isReload) {
                [self.comments addObjectsFromArray:[self fetchCommentsFormJson:array]];
            }else {
                self.comments=[self fetchCommentsFormJson:array];
            }
            [self.tableView reloadData];
        }else {
            [UIMakerUtil alert:COLLECT_SUCCESS title:[jsonValue valueForKey:RETURN_MESSAGE]];
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

#pragma mark - Table View datasources delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.comments count]; 
	if (!isLastPage) { //不足一页时或者最后一页
		return count+1;
	}
    return  count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<[self.comments count]) {
        Comment *comment=[self.comments objectAtIndex:indexPath.row];
        // 列寬
        CGFloat contentWidth = self.tableView.frame.size.width-110;
        // 用何種字體進行顯示
        UIFont *font = CONTENT_FONT;
        // 該行要顯示的內容
        NSString *content = [comment content];
        // 計算出顯示完內容需要的最小尺寸
        CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
        
        int topHeight=30;
        // 這裏返回需要的高度
        return size.height+topHeight+30;
    }else {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if([indexPath row] == [self.comments count]) {
		if (!isLastPage && [self.comments count]>0) {   //创建loadMoreCell 
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.textLabel.text=MORE;
            cell.textLabel.font=[UIFont systemFontOfSize:12];
            cell.textLabel.textAlignment=UITextAlignmentCenter;
            indicator=[UIMakerUtil createActivityView:CGRectMake(190, 15, 10, 10)];
            [cell addSubview:indicator];
		}
	}else{
        cell = [self createCell:[self.comments objectAtIndex:indexPath.row] reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[comments count]) {
        [self loadMore];
    }
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return 1;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return self.preImage;
}

@end
