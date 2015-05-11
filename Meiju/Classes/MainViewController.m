//
//  FirstViewController.m
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
@synthesize mainScrollView,disableViewOverlay,receivedData,adConn,proConn,hotProConn,favorConn,proButton,hotButton,favorButton,isConnected;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    isConnected=NO;
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[[NSString alloc] 
					   initWithBytes:[receivedData bytes] 
					   length:[receivedData length] 
					   encoding:NSUTF8StringEncoding] autorelease];
	if ([connection isEqual:self.adConn]) {
		NSMutableArray *array= (NSMutableArray *)[DataSource fetchAdsFormJson:json];
		CGRect adViewRect = CGRectMake(0, 0, SCREEN_WIDTH, PIC_HEIGHT);
		AdScrollView *adView=[[AdScrollView alloc] initWithArray:array frame:adViewRect];
		[mainScrollView addSubview:adView];
		[mainScrollView addSubview:adView.pageControl];
		isConnected=YES;
        [adView release];
	}else if([connection isEqual:self.proConn]){
		[self addScroll:json];
	}else if([connection isEqual:self.hotProConn]){
		[self addScroll:json];
	}else if([connection isEqual:self.favorConn]){
		[self addScroll:json];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma mark UIinit methods
-(void) addScroll:(NSString *)json
{
	NSMutableArray *array= (NSMutableArray *)[DataSource fetchProductsFormJson:json];
	MallScrollView *scroll=[[MallScrollView alloc] initWithArray:array frame:MallScrollRect];
	scroll.backgroundColor = [UIColor clearColor];
	UIImageView *background= [UIMakerUtil createImageView:@"bgUnder" frame:MallScrollRect];
	background.contentMode=UIViewContentModeCenter;
	[mainScrollView addSubview:background];
	[mainScrollView addSubview:scroll];
	[scroll release];
	MallScrollRect.origin.y+=LABEL_HEIGHT+PIC_HEIGHT+10;
}

-(NSURLConnection *)createAdview
{
	NSString *address=[ConstantUtil createRequestURL:ADSURL];
	receivedData=[[NSMutableData alloc] initWithData:nil];	
	return [DataSource createConn:address delegate:self];
}

-(UIButton *) createTitle:(NSString *) text frame:(CGRect)frame
{
    UIImageView *background= [UIMakerUtil createImageView:@"bgAbove" frame:frame];
    UIButton *button=[UIMakerUtil createHiddenButton:frame];
    frame.origin.x+=10;
	UILabel *label=[UIMakerUtil createLabel:text frame:frame];
    frame.origin.x=self.view.frame.size.width-30;
    frame.origin.y+=15;
    frame.size.width=10;
    frame.size.height=10;
    UIImageView *arrowView=[UIMakerUtil createIcon:ARROW_IMAGE_NAME frame:frame];
	
	[mainScrollView addSubview:background];
    [mainScrollView addSubview:button];
	[mainScrollView addSubview:label];
    [mainScrollView addSubview:arrowView];
	return button;
}

-(NSURLConnection *) createScroll:(CGRect)frame param:(NSString *)param
{
	//if (self.isConnected) {
        NSString *url=[ConstantUtil createRequestURL:MALL_URL withParam:param];
        receivedData=[[NSMutableData alloc] initWithData:nil];
        return [DataSource createConn:url delegate:self];
    //}
    //return nil;
}

-(void) createSearch
{
	UISearchBar *searchBar=[UIMakerUtil createSearchBar:CGRectMake(TITLE_WIDTH, 0, self.view.frame.size.width-TITLE_WIDTH, BAR_HEIGHT)];
	searchBar.delegate=self;
	[self.navigationController.navigationBar addSubview:searchBar];
}

-(void) titleClicked:(UIButton *) sender
{
	MallViewController *mallViewController=[[[MallViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	if ([sender isEqual:self.proButton]) {
		//NEWPROS_PARAM
		[mallViewController titleClickAction:NEWPROS_PARAM];
	}else if ([sender isEqual:self.hotButton]) {
		//HOTSALE_PARAM
		[mallViewController titleClickAction:HOTSALE_PARAM];
	}else if([sender isEqual:self.favorButton]){
		//FAVOURS_PARAM
		[mallViewController titleClickAction:FAVOURS_PARAM];
	}
    mallViewController.unshowSearch=YES;
    [[self navigationController] pushViewController:mallViewController animated:YES];
}

-(void) reload
{
    [self createConn];
}

- (void) viewDidLoad 
{
	[super viewDidLoad];
	//NSLog(@"%s被调用！", __PRETTY_FUNCTION__);
	
	self.view.backgroundColor = SYS_BG;
	self.title=@"首页";
	self.disableViewOverlay=[UIMakerUtil createMaskView:CGRectMake(0.0f,0.0f,self.view.frame.size.width,SCREEN_HEIGHT-BAR_HEIGHT)];
    mainScrollView=[UIMakerUtil createScrollView];
	mainScrollView.contentSize= CGSizeMake(1,(LABEL_HEIGHT+10)*3+PIC_HEIGHT*4+110);
	mainScrollView.backgroundColor = SYS_BG;
    
   //[self.navigationController setNavigationBarHidden:YES animated:NO];
	self.navigationItem.titleView=[UIMakerUtil createMainTitle:[ConstantUtil fetchValueFromPlistFile:APP_NAME_KEY] frame:CGRectMake(0, 0, self.view.frame.size.width, BAR_HEIGHT)];
	self.navigationController.navigationBar.tintColor=ORANGE_BG;
    self.navigationController.navigationBar.delegate=self;     
	[self createSearch];
    
	//CFShow([UIMakerUtil displayViews: self.navigationController.view]);
	
	CGRect titleRect=CGRectMake(5, PIC_HEIGHT+10, MAIN_BANNER_WIDTH, LABEL_HEIGHT);
	self.proButton=[self createTitle:@"新品上架" frame:titleRect];	
	[self.proButton addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	titleRect.origin.y+=LABEL_HEIGHT+PIC_HEIGHT+10;
	self.hotButton=[self createTitle:@"热卖专区" frame:titleRect];
	[self.hotButton addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	titleRect.origin.y+=LABEL_HEIGHT+PIC_HEIGHT+10;
	self.favorButton=[self createTitle:@"特价促销" frame:titleRect];
	[self.favorButton addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_refreshHeaderView == nil) {
		self.mainScrollView.delegate=self;
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mainScrollView.bounds.size.height, self.view.frame.size.width, self.mainScrollView.bounds.size.height)];
		view.delegate = self;
		[self.mainScrollView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    [self.view addSubview:mainScrollView];
    [self createConn];
}

-(void) createConn
{
    self.adConn=[self createAdview];
	MallScrollRect=CGRectMake(5, LABEL_HEIGHT+PIC_HEIGHT+10, MAIN_BANNER_WIDTH, PIC_HEIGHT);
	self.proConn=[self createScroll:MallScrollRect param:NEWPROS_PARAM];
	self.hotProConn=[self createScroll:MallScrollRect param:HOTSALE_PARAM];
	self.favorConn=[self createScroll:MallScrollRect param:FAVOURS_PARAM];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    [disableViewOverlay release];
    [receivedData release];
    [adConn release];
    [proConn release];
    [favorConn release];
    [hotProConn release];
    [hotButton release];
    [favorButton release];
    [proButton release];
    [mainScrollView release];
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
    // searchBarTextDidBeginEditing is called whenever    
    // focus is given to the UISearchBar   
    // call our activate method so that we can do some    
    // additional things when the UISearchBar shows.   
    [self searchBar:searchBar activate:YES];   
}   

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {   
    // searchBarTextDidEndEditing is fired whenever the    
    // UISearchBar loses focus   
    // We don't need to do anything here.   
}   

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {   
    // Clear the search text   
    // Deactivate the UISearchBar   
    searchBar.text=@"";   
    [self searchBar:searchBar activate:NO];   
}   

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {   
    // Do the search and show the results in tableview   
    // Deactivate the UISearchBar   
	
    // You'll probably want to do this on another thread   
    // SomeService is just a dummy class representing some    
    // api that you are using to do the search   
    //NSArray *results = [self doSearch:searchBar.text];   
	
    [self searchBar:searchBar activate:NO];   
	
	MallViewController *mallViewController=[[[MallViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	
	//隐藏导航栏
	mallViewController.unshowSearch=YES;

	[mallViewController searchBarSearchButtonClicked:searchBar];
	[[self navigationController] pushViewController:mallViewController animated:YES];

} 

// We call this when we want to activate/deactivate the UISearchBar   
// Depending on active (YES/NO) we disable/enable selection and    
// scrolling on the UITableView   
// Show/Hide the UISearchBar Cancel button   
// Fade the screen In/Out with the disableViewOverlay and    
// simple Animations   
- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active{     
    //self.mainScrollView.allowsSelection = !active;   
    self.mainScrollView.scrollEnabled = !active;   
    if (!active) {   
        [disableViewOverlay removeFromSuperview];   
        [searchBar resignFirstResponder];   
    } else {   
        self.disableViewOverlay.alpha = 0;   
        [self.view addSubview:self.disableViewOverlay];   
		
        [UIView beginAnimations:@"FadeIn" context:nil];   
        [UIView setAnimationDuration:0.5];   
        self.disableViewOverlay.alpha = 0.6;   
        [UIView commitAnimations];   
		  
    }   

    [searchBar setShowsCancelButton:active animated:YES];   
}

#pragma mark UINavigationBarDelegate Methods 
//防止搜索框上出现字
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item{
    return YES;
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item
{

}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    return YES;
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
    //不能用删除搜索栏，应该使UISearchBar到最前面	
    for(UIView *subview in [self.navigationController.navigationBar subviews]) {
        if([subview isKindOfClass:[UISearchBar class]]) {
            ((UISearchBar *)subview).text=@"";
            [self.navigationController.navigationBar bringSubviewToFront:subview];
        }
    }    
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
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainScrollView];
	
}


@end
