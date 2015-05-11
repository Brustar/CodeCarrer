//
//  StoreViewController.m
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreViewController.h"


@implementation StoreViewController

@synthesize areaConn,listConn,moreConn,filteConn,storeArray,categoryBox,pageNo,serverPages,parentID,param,areaByParentIdConn,storeByParentIdConn,search,searchConn,disableViewOverlay;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[[NSString alloc] 
                       initWithBytes:[receivedData bytes] 
                       length:[receivedData length] 
                       encoding:NSUTF8StringEncoding] autorelease];
    if ([connection isEqual:self.listConn]) {
        self.storeArray=[self fetchStoreArrayFromJSON:json];
        self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
        [self.tableView reloadData];
    }else if ([connection isEqual:self.moreConn]) {
        self.storeArray=[self fetchStoreArrayFromJSON:json];
        self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
        [self.tableView reloadData];
    }else if ([connection isEqual:self.filteConn]) {
        self.storeArray=[self fetchStoreArrayFromJSON:json];
        self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
        [self.tableView reloadData];
    }else if ([connection isEqual:self.areaConn]) {
        NSArray *categoryBoxData = [self fetchClassificatoryFormJsonArray:json];
        ((PopUpBox*)self.categoryBox).popUpBoxDatasource = categoryBoxData;
        [((PopUpBox*)self.categoryBox) reloadData];
        [((PopUpBox*)self.categoryBox).alertView show];
    }else if ([connection isEqual:self.areaByParentIdConn]) {
        NSArray *categoryBoxData = [self fetchClassificatoryFormJsonArray:json parentId:self.parentID];
		((PopUpBox*)self.categoryBox).popUpBoxDatasource = categoryBoxData;
		[((PopUpBox*)self.categoryBox) reloadData];
    }else if([connection isEqual:self.storeByParentIdConn]){
		NSMutableArray *results= [self fetchStoreArrayFromJSON:json];
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
		[self.storeArray removeAllObjects];   
		[self.storeArray addObjectsFromArray:results]; 
		[self searchBar:self.search activate:NO];
		[self.tableView reloadData];
	}else if ([connection isEqual:self.searchConn]) {
		NSMutableArray *results= [self fetchStoreArrayFromJSON:json];
		self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
		[self.storeArray removeAllObjects];   
		[self.storeArray addObjectsFromArray:results];   
		[self.tableView reloadData];
	}
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(IBAction)selectArea:(id)sender
{
    self.categoryBox =[[[PopUpBox alloc] initWithFrame: CGRectMake(10,44, 140, 30) withTitle:BOX_TITLE withButton:nil controller:self] autorelease];
    [self.view addSubview: self.categoryBox];
    
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:AREA_URL];
    self.areaConn=[DataSource createConn:url delegate:self];
}

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

-(id)fetchStoreArrayFromJSON:(NSString *) data
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
			NSString *storeId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"shopId"]];
			Store *store=[[[Store alloc] initWithID:storeId withName:[dic objectForKey:@"shopName"]] autorelease];
            store.shopNum=[dic objectForKey:@"shopNum"];
            store.phoneNum=[dic objectForKey:@"phoneNum"];
            store.address=[dic objectForKey:@"address"];
            store.picAddr=[dic objectForKey:@"picAddr"];

			[retArray addObject:store];
		}
	}
	return [retArray autorelease];
}

-(void) searchClassificatory:(NSString *) typeId
{
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:AREA_URL];
	self.parentID=typeId;
	self.areaByParentIdConn=[DataSource createConn:url delegate:self];
}

-(void) searchByClassificatory:(NSString *) typeId isParent:(BOOL) parent
{
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *para=[NSString stringWithFormat:@"areaId=%@",typeId];
    if (parent) {
        para=[NSString stringWithFormat:@"parentId=%@",typeId];
    }
	NSString *url=[ConstantUtil createRequestURL:STORE_URL withParam:para];
	self.storeByParentIdConn=[DataSource createConn:url delegate:self];
}

-(void) loadMore
{
	self.pageNo++;
    NSString *key;
	if (self.param) {
		key=[NSString stringWithFormat:@"pageNo=%d&%@",self.pageNo,self.param];//有param代表搜索后的分页
	}else {
		key=[NSString stringWithFormat:@"pageNo=%d",self.pageNo];  
	}
	
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:STORE_URL withParam:key];
	self.moreConn=[DataSource createConn:url delegate:self];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=CONTRACT_STORE;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"选择地区" andTarget:self andSelector:@selector(selectArea:)];
    
    [self.tableView setRowHeight:LINE_HEIGHT];
	self.pageNo=1;
    self.disableViewOverlay=[UIMakerUtil createMaskView:CGRectMake(0.0f,BAR_HEIGHT,self.view.frame.size.width,SCREEN_HEIGHT-BAR_HEIGHT)];
    self.search=[UIMakerUtil createSearchBar:CGRectMake(0, 0, self.view.frame.size.width, BAR_HEIGHT)];
	self.search.delegate=self;
    //if (!unshowSearch) {
        self.tableView.tableHeaderView=self.search;
    //}
    
    receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:STORE_URL withParam:[NSString stringWithFormat:@"pageNo=%d",self.pageNo]];
	self.listConn=[DataSource createConn:url delegate:self];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [areaConn release];
    [listConn release];
    [moreConn release];
    [filteConn release];
    [storeArray release];
    [categoryBox release];

    [parentID release];
    [param release];
    [areaByParentIdConn release];
    [storeByParentIdConn release];
    [search release];
    [searchConn release];
    [disableViewOverlay release];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
	
	int count = [self.storeArray count]; 
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
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
	if([indexPath row] == [self.storeArray count]) { 
		if (self.pageNo < self.serverPages) {   //创建loadMoreCell 
			cell.textLabel.text=MORE;
			cell.imageView.image=nil;
			cell.detailTextLabel.text=@"";
		}
	}else{
		Store *store = [self.storeArray objectAtIndex:indexPath.row];
        
        cell.textLabel.numberOfLines=2;
		cell.textLabel.text = store.shopName;
        
        [NSThread detachNewThreadSelector:@selector(updateImageForCellAtIndexPath:) toTarget:self withObject:indexPath];
        
        cell.detailTextLabel.numberOfLines=2;
		cell.detailTextLabel.text=[NSString stringWithFormat:@"商户地址: %@", store.address];
	}
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == [self.storeArray count] && self.pageNo<self.serverPages) {
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath]; 
        loadMoreCell.textLabel.text=@"loading more …";
        [self loadMore];
		//[self performSelectorInBackground:@selector(loadMore) withObject:nil];
		[tableView deselectRowAtIndexPath:indexPath animated:YES]; 
        return; 
    }	

	self.navigationController.navigationBar.tintColor=ORANGE_BG;
	Store *store= [self.storeArray objectAtIndex:indexPath.row];
    StoreDetailViewController *storeDetailView=[[[StoreDetailViewController alloc] init] autorelease];
	storeDetailView.title = @"商户详情";
	storeDetailView.storeData=store;
    [[self navigationController] pushViewController:storeDetailView animated:YES];
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
    Store *store = [self.storeArray objectAtIndex:indexPath.row];
    NSString *path =store.picAddr;
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
    [self searchBar:searchBar activate:NO];   
}   

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {   
    [self searchBar:searchBar activate:NO];
    [self doSearch:searchBar.text];
} 

-(void) doSearch: (NSString *)text
{
	self.param=[NSString stringWithFormat:@"keyword=%@",text];
	receivedData=[[NSMutableData alloc] initWithData:nil];
	
	NSString *url=[ConstantUtil createRequestURL:STORE_URL withParam:param];
	self.searchConn=[DataSource createConn:url delegate:self];
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
        [searchBar resignFirstResponder];  
    } else {   
        self.disableViewOverlay.alpha = 0;   
        [self.view addSubview:self.disableViewOverlay];    
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


@end
