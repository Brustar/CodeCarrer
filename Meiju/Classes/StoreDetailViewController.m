//
//  StoreDetailViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StoreDetailViewController.h"

@interface StoreDetailViewController ()

@end

@implementation StoreDetailViewController

@synthesize storeData;

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
    self.storeData=[self.storeData fetchStoreWithJSON:json];
    [self createUI];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(IBAction)callStore:(id)sender
{
    NSString *title=[NSString stringWithFormat:@"确定要拔打 %@ 吗?",self.storeData.phoneNum];
    [UIMakerUtil actionSheet:title delegate:self];
}

-(IBAction)storeNumbers:(id)sender
{
    PhoneCallsViewController *view =[[[PhoneCallsViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    view.phoneCalls=[self.storeData.phoneNum componentsSeparatedByString:@","];
    [self.navigationController pushViewController:view animated:YES];
}

-(void) createUI
{
    scroll=[UIMakerUtil createScrollView];
    scroll.contentSize= CGSizeMake(1,480+[self.storeData.shopInfo count]*44);
	scroll.backgroundColor = SYS_BG;
    [self createTopUI];
    [self createMiddleUI];
    [self createBottomUI];
    [self.view addSubview:scroll];
}

-(void)createTopUI
{
    RoundedCornerView *view=[[[RoundedCornerView alloc] initWithFrame:CGRectMake(5, 20, 310, 190)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    CGRect rect=CGRectMake(15, 15,75, 75);
    [view addSubview:[UIMakerUtil createImageViewFromURL:self.storeData.picAddr frame:rect]];
    rect.origin.x+=80;
    rect.size.width=200;
    UILabel *storeName=[UIMakerUtil createLabel:[self.storeData.shopName insertBreakLine] frame:rect];
    storeName.numberOfLines=2;
    [view addSubview:storeName];
    [view addSubview:[UIMakerUtil createSeparatorLineByWidth:CGRectMake(5,100,300,2)]];
    rect.origin.y+=67;
    rect.origin.x=15;
    rect.size.width=290;
    UILabel *addressLabel=[UIMakerUtil createLabel:[[NSString stringWithFormat:@"商户地址: %@", self.storeData.address] insertBreakLine:24] frame:rect];
    addressLabel.font=[UIFont systemFontOfSize:12];
    addressLabel.numberOfLines=2;
    [view addSubview:addressLabel];
    [view addSubview:[UIMakerUtil createSeparatorLineByWidth:CGRectMake(5,140,300,2)]];
    rect.origin.y+=45;
    rect.size.width=240;
    UILabel *phoneLabel=[UIMakerUtil createLabel:[NSString stringWithFormat:@"商户电话: %@", self.storeData.phoneNum] frame:rect];
    phoneLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:phoneLabel];
    UIButton *button;
    if([[self.storeData.phoneNum componentsSeparatedByString:@","] count]<2){
        button=[UIMakerUtil createImageButton:@"call" light:@"callLight" frame:CGRectMake(260, rect.origin.y+22,34,34)];
        [button addTarget:self action:@selector(callStore:) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        button=[UIMakerUtil createDetailDisclosureButton:CGPointMake(280, rect.origin.y+38)];
        [button addTarget:self action:@selector(storeNumbers:) forControlEvents:UIControlEventTouchUpInside];
    }
    [view addSubview:button]; 
    [scroll addSubview:view];
}

-(void)createMiddleUI
{
    UILabel *title=[UIMakerUtil createLabel:@"特色介绍" frame:CGRectMake(0,205,300,30)];
    title.textAlignment=UITextAlignmentCenter;
    [scroll addSubview:title];
    [scroll addSubview:[UIMakerUtil createTextAreaView:self.storeData.featDesc frame:CGRectMake(10,230,300,100)]];
}

-(void)createBottomUI
{
    UILabel *title=[UIMakerUtil createLabel:@"促销资讯" frame:CGRectMake(0,335,300,30)];
    title.textAlignment=UITextAlignmentCenter;
    [scroll addSubview:title];
    UITableView *tableView=[UIMakerUtil createTableView:CGRectMake(0, 360, self.view.frame.size.width, [self.storeData.shopInfo count]*44) delegateAndSoruce:self];
    //CFShow(NSStringFromCGRect(tableView.frame));
    [scroll addSubview:tableView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=SYS_BG;
    
    NSString *para=[NSString stringWithFormat:@"shopId=%@",self.storeData.shopId];
    receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:STORE_DETAIL_URL withParam:para];
	[DataSource createConn:url delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc {
    [storeData release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL destructiveClicked=actionSheet.destructiveButtonIndex==buttonIndex;
    if (destructiveClicked) {
        [UIMakerUtil sysApplicationCall:self.storeData.phoneNum protocol:TELEPHONE_PROTOCOL];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.storeData.shopInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    News *news=[self.storeData.shopInfo objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = news.title;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController *details = [[[NewsDetailViewController alloc] init] autorelease];
	details.news=[self.storeData.shopInfo objectAtIndex:indexPath.row];
    details.title=STORE_NEWS_DETAIL;
    details.showRight=YES;
	[[self navigationController] pushViewController:details animated:YES];
}

@end
