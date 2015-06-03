//
//  MasterViewController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController

@synthesize popoverController,messages,preImage;;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=[ConstantUtil fetchValueFromPlistFile:APP_NAME_KEY];
    //only for ios5.0
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem=[UIMakerUtil createBarButtonItem:@"setting" andTarget:self andSelector:@selector(setUp:)];
    self.navigationItem.rightBarButtonItem =[UIMakerUtil createBarButtonItem:@"classify" andTarget:self andSelector:@selector(popOver:)];
    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];
    self.tableView.tableHeaderView = [self createHeaderView];
    
    isLastPage=NO;
    [self cacheLoadData];
    
    if (refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		refreshHeaderView = view;
		[view release];
	}

	//  update the last update date
	[refreshHeaderView refreshLastUpdatedDate];
}

- (IBAction)introAction:(id)sender
{
    UIViewController *forward=[[[AboutTeacherViewController alloc] init] autorelease];
    [self.navigationController pushViewController:forward animated:YES];
}

-(IBAction)setUp:(id)sender
{
    [self dismiss];
    [self.navigationController pushViewController:[[[SetupController alloc] initWithStyle:UITableViewStyleGrouped] autorelease] animated:YES];
}

-(void) initData:(NSString *)param
{
    NSString *url=[ConstantUtil createRequestURL:MASTER_URL];
    if (param) {
        url=[ConstantUtil createRequestURL:MASTER_URL withParam:param]; 
    }
    [DataSource fetchJSON:url delegate:self];
}

//如果有缓存从缓存中读取数据
-(void)  cacheLoadData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:CACHE_JOSN_PATH]) {
        [self initData:nil]; 
    }else {
        NSError *error;
        NSString *jsonString = [NSString stringWithContentsOfFile:CACHE_JOSN_PATH encoding:NSUTF8StringEncoding error:&error];
        if (!jsonString) {
            NSLog(@"Error reading frome file %@ %@",[CACHE_JOSN_PATH lastPathComponent],[error localizedDescription]);
        }else {
            id jsonValue = [jsonString JSONValue];
            NSArray *array = [jsonValue valueForKey:ARRAY_NAME];
            isLastPage=YES;
            self.messages=[Message fetchMessagesFormJson:array];  
        }
    }
}

//刷新页面
-(IBAction)refresh:(id)sender
{
    isReload=YES;
    categoryId=0;
    [self initData:nil];
    [self.tableView reloadData]; //必须reload,否则表格行数，高度等会不变化
}

-(void)loadCatalog:(int) cataId
{
    isReload=YES;
    categoryId=cataId;
    [self dismiss];
    [self initData:[NSString stringWithFormat:@"category=%d",cataId]];
    [self.tableView reloadData]; //必须reload,否则表格行数，高度等会不变化
}

-(void)loadMore 
{ 
    isReload=NO;
    [indicator startAnimating];
    NSString *param=@"";
    //更多时，如果有分类要带入分类
    if (categoryId>0) {
        param=[NSString stringWithFormat:@"category=%d&",categoryId];
    }
    NSString *lastId=[[messages lastObject] msgID];
    [self initData:[param stringByAppendingFormat:@"lastId=%@",lastId]];
}

-(void) dismiss
{
    [self.popoverController dismissPopoverAnimated:YES];
    self.popoverController = nil;
}

-(IBAction)popOver:(id)sender
{
    if (self.popoverController) {
		[self dismiss];
	} else {
        CGRect rect=((UIButton *)sender).frame;
        //弹出框Y坐标
        rect.origin.y+=15;
        
		UIViewController *catalogController = [[[CatalogController alloc] initWithStyle:UITableViewStylePlain] autorelease];
        ((CatalogController *)catalogController).master=self;
		self.popoverController = [[[WEPopoverController alloc] initWithContentViewController:catalogController] autorelease];
		[self.popoverController presentPopoverFromRect:rect 
												inView:self.navigationController.view 
							  permittedArrowDirections:UIPopoverArrowDirectionUp
											  animated:YES];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.messages=nil;
    //[self.messages release];
    [self dismiss];

}

- (void)didReceiveMemoryWarning
{
    //[[CCTextureCache sharedTextureCache] removeAllTextures];
    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    [UIMakerUtil alert:@"lack memory" title:@"invalid operation"];
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIView *) createHeaderView
{
    UIView *view=[[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 97)] autorelease]; //一定要设置frame,否则表头不显示
    UIImageView *imageView=[UIMakerUtil createImageView:@"picturebackground" frame:CGRectMake(0, 0, 320, 97)];
    UILabel *label=[UIMakerUtil createLabel:MASTER_TITLE frame:CGRectMake(80, 30, 100, 30)];
    label.font=[UIFont systemFontOfSize:18];
    
    UILabel *subLabel=[UIMakerUtil createLabel:MASTER_SUB_TITLE frame:CGRectMake(80, 45, 200, 30)];
    subLabel.font=[UIFont systemFontOfSize:12];
    subLabel.textColor=[UIColor darkGrayColor];
    UIImageView *headImage=[UIMakerUtil createImageView:@"The_teacher_head" frame:CGRectMake(20, 20, 55, 56)];
    
    UITapGestureRecognizer *singleTap =
    [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(introAction:)] autorelease];
    headImage.userInteractionEnabled = YES;
    [headImage addGestureRecognizer:singleTap];
    
    UIButton *btnReload=[UIMakerUtil createImageButton:@"refresh" light:nil point:CGPointMake(300, 80)];
    [btnReload addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:imageView];
    [view addSubview:headImage];
    [view addSubview:label];
    [view addSubview:subLabel];
    [view addSubview:btnReload];
    
    return view;
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
    //content.textColor=[UIColor grayColor];
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
    
    PropertyButton *btnCollected=[UIMakerUtil createPropertyButton:mess.collectCount image:@"collected" frame:CGRectMake(210, topHeight+size.height, 45, 21)];
    btnCollected.data=mess.msgID;
    [btnCollected addTarget:self action:@selector(collectMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    PropertyButton *btnReply=[UIMakerUtil createPropertyButton:mess.commentCount image:@"reply" frame:CGRectMake(260, topHeight+size.height, 45, 21)];
    btnReply.data=mess;
    [btnReply addTarget:self action:@selector(replyMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *line=[UIMakerUtil createImageView:@"timeline" frame:CGRectMake(20, 0, 1, topHeight+40+size.height)];
    
    [view addSubview:line];
    [view addSubview:icon];
    [view addSubview:title];
    [view addSubview:content];
    [view addSubview:time];
    [view addSubview:btnCollected];
    [view addSubview:btnReply];
    [cell setView:view];
    cell.opaque=YES;    //不透明的视图可以极大地提高渲染的速度
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

-(IBAction)collectMessage:(PropertyButton *)sender
{
    [self dismiss];
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

-(IBAction)replyMessage:(PropertyButton *)sender
{
    [self dismiss];
    //先判断是否有登录
    if ([[SessionUtil sharedInstance] isLogined]) {
        ReplyInputViewController *inputViewControl=[[[ReplyInputViewController alloc] init] autorelease];
        inputViewControl.mess=sender.data;
        [self.navigationController pushViewController:inputViewControl animated:YES];
    }else {
        LoginViewController *loginView=[[[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
        [self.navigationController pushViewController:loginView animated:YES];
    }
    
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.messages count];
    int count = [self.messages count]; 
	if (!isLastPage) { //不足一页时或者最后一页
		return count+1;
	}
    return  count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
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

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self dismiss];
    if (indexPath.row==[messages count]) {
        [self loadMore];
    }else {
        DetailViewController *detail=[[[DetailViewController alloc] init] autorelease];
        detail.mess=[self.messages objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark -
#pragma mark ASIHTTPRequest delegate
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
            if (self.messages!=nil && !isReload) {              //有数据且不为刷新时,如点更多时
                [self.messages addObjectsFromArray:[Message fetchMessagesFormJson:array]];
                [self.tableView reloadData];
            }else {                                             //分类或刷新时
                //缓存到本地文件
                NSError *error;
                if (![jsonString writeToFile:CACHE_JOSN_PATH atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
                    NSLog(@"Error write to file:%@",[error localizedDescription]);
                }
                self.messages=[Message fetchMessagesFormJson:array];
            }
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

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [self dismiss];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    //下拉更多
    if(scrollView.contentOffset.y>scrollView.contentSize.height-scrollView.frame.size.height+20)
    {
        if (!isLastPage) { //存在第二页时
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[messages count] inSection:0];
            [self performSelectorInBackground:@selector(loadMore) withObject:nil]; 
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self refresh:nil];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark - Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
    [self refresh:nil];
	//  put here just for demo
	reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	reloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return 1;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return self.preImage;
}

@end