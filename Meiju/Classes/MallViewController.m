//
//  MallViewController.m
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MallViewController.h"


@implementation MallViewController

@synthesize categoryButton,sortButton,disableViewOverlay,listContent,MJPara,pageNo,serverPages,parentID,categoryBox,classByTypeIdConn;
@synthesize receivedData,loadConn,searchConn,moreConn,titleConn,popButtonsView,popConn,sortConn,search,classificatoryConn,unshowSearch;
#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[[NSString alloc] 
					   initWithBytes:[receivedData bytes] 
					   length:[receivedData length] 
					   encoding:NSUTF8StringEncoding] autorelease];
	if ([connection isEqual:self.loadConn]) {
		NSMutableArray *prosArray= [self fetchProductsFormJson:json];
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
		self.listContent=[NSMutableArray arrayWithArray:prosArray];
		[self.tableView reloadData];
	}else if ([connection isEqual:self.moreConn]) {
		NSMutableArray *results= [self fetchProductsFormJson:json];  
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
        //[self performSelectorOnMainThread:@selector(appendTableWith:) withObject:results waitUntilDone:NO];
        [self.listContent addObjectsFromArray:results];
		[self.tableView reloadData];
	}else if ([connection isEqual:self.searchConn]) {
		NSMutableArray *results= [self fetchProductsFormJson:json];
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
		[self.listContent removeAllObjects];   
		[self.listContent addObjectsFromArray:results];   
		[self.tableView reloadData];
	}else if ([connection isEqual:self.titleConn]) {
		NSMutableArray *results= [self fetchProductsFormJson:json];
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
		[self.listContent removeAllObjects];   
		[self.listContent addObjectsFromArray:results];   
		[self.tableView reloadData];
	}else if ([connection isEqual:self.sortConn]) {
		NSMutableArray *results= [self fetchProductsFormJson:json];
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
		[self.listContent removeAllObjects];   
		[self.listContent addObjectsFromArray:results]; 
		[self searchBar:self.search activate:NO];
		[self.tableView reloadData];
	}else if ([connection isEqual:self.popConn]) {
		NSArray *categoryBoxData = [self fetchClassificatoryFormJsonArray:json];
        ((PopUpBox*)self.categoryBox).popUpBoxDatasource = categoryBoxData;
        [((PopUpBox*)self.categoryBox) reloadData];
	}else if ([connection isEqual:self.classificatoryConn]) {
		NSArray *categoryBoxData = [self fetchClassificatoryFormJsonArray:json parentId:self.parentID];
		((PopUpBox*)self.categoryBox).popUpBoxDatasource = categoryBoxData;
		[((PopUpBox*)self.categoryBox) reloadData];
	}else if ([connection isEqual:self.classByTypeIdConn]) {
		NSMutableArray *results= [self fetchProductsFormJson:json];
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
		[self.listContent removeAllObjects];   
		[self.listContent addObjectsFromArray:results]; 
		[self searchBar:self.search activate:NO];
		[self.tableView reloadData];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark init methods 
-(id)fetchClassificatoryFormJsonArray:(NSString *)data
{	
	NSDictionary *json= [DataSource fetchDictionaryFromURL:data];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(![dic objectForKey:@"parentId"])
		{
			//initWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *typeId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
			NSString *parentId=[dic objectForKey:@"parentId"]?[NSString stringWithFormat:@"%@",[dic objectForKey:@"parentId"]]:nil;
			Classificatory *cate=[Classificatory categoryWithId:typeId name:[dic objectForKey:CLASS_KEY] parentId:parentId];
			[retArray addObject:cate];
		}
	}
	return [retArray autorelease];
}

-(id)fetchClassificatoryFormJsonArray:(NSString *)data parentId:(NSString *)cateId
{
	NSDictionary *json= [DataSource fetchDictionaryFromURL:data];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
    
    Classificatory *bigCate=[[[Classificatory alloc] init] autorelease];
    bigCate.parentId=cateId;
    bigCate.typeName=@"所有";
    [retArray addObject:bigCate];
    
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
			//initWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *parentId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"parentId"]];
			if([parentId isEqualToString:cateId]){
				NSString *typeId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"typeId"]];
				Classificatory *cate=[Classificatory categoryWithId:typeId name:[dic objectForKey:CLASS_KEY] parentId:parentId];
				[retArray addObject:cate];
			}
		}
	}
	return [retArray autorelease];
}

-(void) popButtonClick
{
    receivedData=[[NSMutableData alloc] initWithData:nil];
	
	NSString *url=[ConstantUtil createRequestURL:MALL_TYPE_URL];
	self.popConn=[DataSource createConn:url delegate:self];
}

-(void) sort:(int) index
{
	receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *para=[NSString stringWithFormat:@"equence=%d&%@",index,MJPara];
    self.MJPara=para;
	NSString *url=[ConstantUtil createRequestURL:MALL_URL withParam:para];
	self.sortConn=[DataSource createConn:url delegate:self];
   
}

-(void) searchClassificatory:(NSString *) typeId
{
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:MALL_TYPE_URL];
	self.parentID=typeId;
	self.classificatoryConn=[DataSource createConn:url delegate:self];
}

-(void) searchByClassificatory:(NSString *) typeId isParent:(BOOL) parent
{
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *para=[NSString stringWithFormat:@"typeId=%@",typeId];
    if (parent) {
        para=[NSString stringWithFormat:@"parentId=%@",typeId];
    }
    self.MJPara=para;
	NSString *url=[ConstantUtil createRequestURL:MALL_URL withParam:para];
	self.classByTypeIdConn=[DataSource createConn:url delegate:self];
}

-(void) loadMore
{
	self.pageNo++;
    NSString *key;
	if (self.MJPara) {
		key=[NSString stringWithFormat:@"pageNo=%d&%@",self.pageNo,self.MJPara];//有param代表搜索后的分页
	}else {
		key=[NSString stringWithFormat:@"pageNo=%d",self.pageNo];  
	}
	
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:MALL_URL withParam:key];
	self.moreConn=[DataSource createConn:url delegate:self];
}

-(id)fetchProductsFormJson:(NSString *) data
{
	
	NSDictionary *json= [DataSource fetchDictionaryFromURL:data];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
			//initWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *proId=[NSString stringWithFormat:@"%@",[dic objectForKey:PRO_ID]];
			NSString *proPrice=[NSString stringWithFormat:@"%@",[dic objectForKey:@"mallPrice"]];
			Product *pro=[Product productWithId:proId name:[dic objectForKey:PRO_NAME_KEY] url:[dic objectForKey:PIC_KEY] price:proPrice];	
			[retArray addObject:pro];
		}
	}
	return [retArray autorelease];
}

-(void)shopCartAction:(id)sender {
    ShopCartViewController *cartView=[[[ShopCartViewController alloc] init] autorelease];
    
    [self.navigationController pushViewController:cartView animated:YES];
}

-(void) createLoadConn
{
    receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:MALL_URL withParam:[NSString stringWithFormat:@"pageNo=%d",self.pageNo]];
	self.loadConn=[DataSource createConn:url delegate:self];
}

-(void) initSearchButton
{
    [self.categoryButton setTitle:@"所有大类 | 所有小类" forState:UIControlStateNormal];
    [self.sortButton setTitle:@"排序" forState:UIControlStateNormal];
}

-(void) reload
{
    self.pageNo=1;
    [self initSearchButton];
    [self createLoadConn];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.title=@"商城";
    self.navigationController.navigationBar.tintColor=ORANGE_BG;
	//self.view.backgroundColor = SYS_BG;
    [self.tableView setRowHeight:LINE_HEIGHT];
	self.pageNo=1;
	
	self.disableViewOverlay=[UIMakerUtil createMaskView:CGRectMake(0.0f,BAR_HEIGHT*2,self.view.frame.size.width,SCREEN_HEIGHT-BAR_HEIGHT)];
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"购物车" andTarget:self andSelector:@selector(shopCartAction:)];
	self.search=[UIMakerUtil createSearchBar:CGRectMake(0, 0, self.view.frame.size.width, BAR_HEIGHT)];
	self.search.delegate=self;
    if (!unshowSearch) {
        self.tableView.tableHeaderView=self.search;
    }    
    //[self.view addSubview:self.search];
     //控制首页进入时searchBar不出现，另两种情况无此功能
	//[self.tableView.tableHeaderView addSubview:self.search]; 
	self.popButtonsView=[[[UIView alloc] initWithFrame:CGRectMake(0,BAR_HEIGHT,self.view.frame.size.width,BAR_HEIGHT)] autorelease]; 
	popButtonsView.backgroundColor=ORANGE_BG;
	[self createPopSearchBox];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
	
	[self createLoadConn];
}

-(void) createPopSearchBox
{
	self.categoryButton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
	CGRect categoryButtonRect=CGRectMake(0, 0, 140, 30);
	[self.categoryButton setFrame:categoryButtonRect];
    
    sortButton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
	CGRect sortButtonRect=CGRectMake(0, 0, 140, 30);
	[sortButton setFrame:sortButtonRect];
    [self initSearchButton];
	
    self.categoryBox =[[[PopUpBox alloc] initWithFrame: CGRectMake(10, 7, 140, 30) withTitle:BOX_TITLE withButton:self.categoryButton controller:self] autorelease];
    [self.popButtonsView addSubview: self.categoryBox];
	
	PopUpBox *sortBox = [[PopUpBox alloc] initWithFrame: CGRectMake(160, 7, sortButtonRect.size.width, sortButtonRect.size.height) withTitle:@"请选择一个排序方式" withButton:sortButton controller:self];
	NSArray *sortBoxData = [NSArray arrayWithObjects:@"按上架时间从新到旧",@"按上架时间从旧到新",@"按价格从低到高",@"按价格从高到低",nil];
	sortBox.popUpBoxDatasource = sortBoxData;
	[self.popButtonsView addSubview: sortBox];
	
	[sortBox release];

}

- (void)viewDidUnload {
    //[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
}


- (void)dealloc {
    [super dealloc];
	[listContent release];
	[categoryBox release];
    [popButtonsView release];
    [MJPara release];
    [parentID release];
    [disableViewOverlay release];
    [classByTypeIdConn release];
    [categoryButton release];
    [sortButton release];
    [receivedData release];
    [loadConn release];
    [searchConn release];
    [moreConn release];
    [titleConn release];
    [popConn release];
    [sortConn release];
    [search release];
    [classificatoryConn release];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
	
	int count = [self.listContent count]; 
	if (count<PAGE_LENGTH || self.pageNo==self.serverPages) { //不足一页时或者最后一页
		return count;
	}
    return  count + 1; 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kCellID]; 
    if (cell==nil) { //cell要重用
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellID] autorelease];
    } 
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
	if([indexPath row] == [self.listContent count]) { 
		if (self.pageNo < self.serverPages) {   //创建loadMoreCell 
			cell.textLabel.text=MORE;
			cell.imageView.image=nil;
			cell.detailTextLabel.text=@"";
		}
	}else{
		Product *product = [self.listContent objectAtIndex:indexPath.row];
        
        cell.textLabel.numberOfLines=2;
		cell.textLabel.text = product.name;
        
        //cell.imageView.frame=CGRectMake(5, 5,75, 75);
		//cell.imageView.image=[UIMakerUtil createImageViewFromURL:product.picURL].image;
        
        [NSThread detachNewThreadSelector:@selector(updateImageForCellAtIndexPath:) toTarget:self withObject:indexPath];
        
        cell.textLabel.textAlignment= UITextAlignmentLeft;
        cell.detailTextLabel.numberOfLines=1;
        cell.detailTextLabel.textColor=[UIColor redColor];
		cell.detailTextLabel.text=[[product.mallPrice fillZeroAtStart] RMBFormat];
	}

	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == [self.listContent count] && self.pageNo<self.serverPages) {
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath]; 
        loadMoreCell.textLabel.text=@"loading more …";
        [self loadMore];
		//[self performSelectorInBackground:@selector(loadMore) withObject:nil];
		[tableView deselectRowAtIndexPath:indexPath animated:YES]; 
        return; 
    }	
	self.navigationController.navigationBar.tintColor=ORANGE_BG;
	Product *product= [self.listContent objectAtIndex:indexPath.row];
	//productDetailView.title = @"商品详情";
	//productDetailView.productData=[product fetchWithProduct];
    [[self navigationController] pushViewController:[UIMakerUtil createProductDetailView:product] animated:YES];
}

- (void)updateImageForCellAtIndexPath:(NSIndexPath *)indexPath{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    UIImage *image = [self getImageForCellAtIndexPath:indexPath];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.frame=CGRectMake(5, 5,75, 75);
    if (image) {
        image=[ImageHelper image:image fitInView:cell.imageView];
        [cell.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    }
    [pool release];
}

-(UIImage *)getImageForCellAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product = [self.listContent objectAtIndex:indexPath.row];
    /*写文件会闪退
    NSString *localPath=[ConstantUtil createImagePath:[product.pid stringByAppendingString:@".png"]];

    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:localPath];	
    UIImage *image=nil;

    if (exists)
    {
        image=[UIImage imageWithContentsOfFile:localPath];
    }
    else 
    {
        NSString *path =product.picURL;
        NSString *tempPath=[ConstantUtil createImagePath:[product.pid stringByAppendingString:@".png"]];
        NSURL *url = [NSURL URLWithString:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:tempPath atomically:YES];
        image = [UIImage imageWithContentsOfFile:tempPath];
    }
    */
    NSString *path =product.picURL;
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image=[UIImage imageWithData:data];
    if (image==nil) {
        image=[UIImage imageNamed:@"noImage"];
    }
    return image;
}

#pragma mark -   
#pragma mark UISearchBarDelegate Methods   

- (void)searchBar:(UISearchBar *)searchBar   
    textDidChange:(NSString *)searchText {   
	// We don't want to do anything until the user clicks    
	// the 'Search' button.   
	// If you wanted to display results as the user types    
	// you would do that here.   
}   

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {   

    [self searchBar:searchBar activate:YES];   

}   

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {   
    // searchBarTextDidEndEditing is fired whenever the    
    // UISearchBar loses focus   
    // We don't need to do anything here.
}   

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {   
 
    // Deactivate the UISearchBar 
    searchBar.text=@"";
    self.MJPara=@"";
    [self initSearchButton];
    [self searchBar:searchBar activate:NO];   
}   

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {   
    [self searchBar:searchBar activate:NO];
    [self doSearch:searchBar.text];
} 

-(void) doSearch: (NSString *)text
{
	self.MJPara=[NSString stringWithFormat:@"keyword=%@",text];
	receivedData=[[NSMutableData alloc] initWithData:nil];
	
	NSString *url=[ConstantUtil createRequestURL:MALL_URL withParam:MJPara];
	self.searchConn=[DataSource createConn:url delegate:self];
}

-(void)titleClickAction: (NSString *)text
{
	self.pageNo=1;
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:MALL_URL withParam:text];
	self.titleConn=[DataSource createConn:url delegate:self];
}

// We call this when we want to activate/deactivate the UISearchBar   
// Depending on active (YES/NO) we disable/enable selection and    
// scrolling on the UITableView   
// Show/Hide the UISearchBar Cancel button   
// Fade the screen In/Out with the disableViewOverlay and    
// simple Animations   
- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active{     
    self.tableView.allowsSelection = !active;   
    self.tableView.scrollEnabled = !active;   
    if (!active) {   
        [self.disableViewOverlay removeFromSuperview]; 
		[self.popButtonsView removeFromSuperview];
        [searchBar resignFirstResponder];  
    } else {   
        self.disableViewOverlay.alpha = 0;   
        [self.view addSubview:self.disableViewOverlay];   
		[self.view addSubview:self.popButtonsView]; 
        [UIView beginAnimations:@"FadeIn" context:nil];   
        [UIView setAnimationDuration:0.5];   
        self.disableViewOverlay.alpha = 0.6;   
        [UIView commitAnimations];   
		
        // probably not needed if you have a details view since you    
        // will go there on selection   
        NSIndexPath *selected = [self.tableView    
								 indexPathForSelectedRow];   
        if (selected) {   
            [self.tableView deselectRowAtIndexPath:selected    
											 animated:NO];   
        }   
    } 
    [searchBar setShowsCancelButton:active animated:YES];   
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
    [self reload];
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

@end
