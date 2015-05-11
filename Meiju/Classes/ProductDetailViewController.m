//
//  ProductDetailViewController.m
//  Meiju
//
//  Created by brustar on 12-5-1.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailViewController.h"


@implementation ProductDetailViewController
@synthesize pic,proTitle,proDetail,markPrice,mallPrice,collect,purchase,productData,proScrollView,virtualSalesVolume,invenStatus,receivedData,collectConn,productConn;

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
	if ([connection isEqual:self.productConn]) {
        self.productData=[self.productData fetchWithProduct:json];
        [self createUI];
    }else if([connection isEqual:self.collectConn]){
        NSString *message=[DataSource fetchJSONValueFormServer:json forKey:RETURN_MESSAGE];
        [UIMakerUtil alert:message title:self.title];
    }
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark quicklook view datasources methods
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    
    return [self.productData.picAddr count];
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller 
                     previewItemAtIndex:(NSInteger)index {
    NSString *path = [ConstantUtil createPreviewImagePath];
    return [NSURL fileURLWithPath:path];
}

- (void)showPreview:(id)sender {
    [self presentModalViewController:quicklook animated:YES];
}


#pragma mark UIinit methods
-(void)createProImageview
{
	CGRect rect=CGRectMake(0,0, self.view.frame.size.width, PRO_IMAGE_SIZE+15);
    UIView *view=[[[UIView alloc] initWithFrame:rect] autorelease];
    view.backgroundColor=GRAY_BG;
    CGRect proImageViewRect = CGRectMake((self.view.frame.size.width-PRO_IMAGE_SIZE)/2, 10, PRO_IMAGE_SIZE, PRO_IMAGE_SIZE);
	ProDetailImageScrollView *proImageView=[[[ProDetailImageScrollView alloc] initWithFrame:proImageViewRect withArray:self.productData.picAddr] autorelease];
	[view addSubview:proImageView];
	if ([self.productData.picAddr count]>1) {
        [view addSubview:proImageView.pageControl];
    }
    if ([self.productData.picAddr count]>0) {
        UIButton *button=[UIMakerUtil createHiddenButton:rect];
        [button addTarget:self action:@selector(showPreview:) forControlEvents:UIControlEventTouchUpInside];
        [self.proScrollView addSubview:view];
        [self.proScrollView addSubview:button];
    }
}

-(void) segmentAction:(UISegmentedControl *)sender
{
	[self ChangeSegmentFont:sender];
    UITextView *textArea=(UITextView *)[self.view viewWithTag:101];
	if (sender.selectedSegmentIndex==0) {
		[textArea setText:self.productData.detail];
	}else {
		[textArea setText:self.productData.saleRemark];
	}
}

-(void)ChangeSegmentFont:(UIView *)aView
{
    if ([aView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)aView;
        [label setTextAlignment:UITextAlignmentCenter];
        label.shadowColor=[UIColor clearColor];
        label.textColor=[UIColor blackColor];
    }
    NSArray *array = [aView subviews];
    NSEnumerator *enumerator = [array objectEnumerator];
    UIView *subView;
    while (subView = [enumerator nextObject]) {
        [self ChangeSegmentFont:subView];
    }
}

-(void) createUI
{
	quicklook = [[QLPreviewController alloc] init];
    quicklook.dataSource = self;
    
    proScrollView.frame=CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height);
	[self createProImageview];
	CGRect titleRect=CGRectMake(10,PRO_IMAGE_SIZE+15,self.view.frame.size.width,TITLE_HEIGHT*2);
    if ([self.productData.picAddr count]==0) {
        titleRect.origin.y=15;
    }
	self.proTitle=[UIMakerUtil createTitleLabel:[self.productData.name insertBreakLine] frame:titleRect];
    self.proTitle.numberOfLines=2;
	
	titleRect.origin.y+=TITLE_HEIGHT*1.5;
	NSString *mall=@"商城价:";
	self.mallPrice=[UIMakerUtil createLabel:[mall stringByAppendingString:[self.productData.mallPrice RMBFormat]] frame:titleRect];
	
	titleRect.origin.y+=TITLE_HEIGHT;
	NSString *mark=@"市场价:";
	self.markPrice=[UIMakerUtil createLabel:[mark stringByAppendingString:[self.productData.markPrice RMBFormat]] frame:titleRect];
	
	[self.proScrollView addSubview:self.proTitle];
	[self.proScrollView addSubview:self.mallPrice];
	[self.proScrollView addSubview:self.markPrice];
	
	[self.proScrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0, titleRect.origin.y+35)]];
	
	titleRect.origin.y+=TITLE_HEIGHT+10;
	NSString *sale=@"销量:";
	self.virtualSalesVolume=[UIMakerUtil createLabel:[sale stringByAppendingString:self.productData.virtualSalesVolume] frame:titleRect];
	titleRect.origin.y+=TITLE_HEIGHT;
	NSString *inven=@"库存状况:";
	self.invenStatus=[UIMakerUtil createLabel:[inven stringByAppendingString:self.productData.invenStatus] frame:titleRect];
	
	[self.proScrollView addSubview:self.virtualSalesVolume];
	[self.proScrollView addSubview:self.invenStatus];
	[self.proScrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0, titleRect.origin.y+35)]];
	
	titleRect.origin.y+=TITLE_HEIGHT+20;
	self.collect=[UIMakerUtil createImageButton:@"收藏" point:CGPointMake(80, titleRect.origin.y+10)];
    [self.collect addTarget:self action:@selector(collectProduct:) forControlEvents:UIControlEventTouchUpInside];
	self.purchase=[UIMakerUtil createImageButton:@"加入购物车" point:CGPointMake(180+60, titleRect.origin.y+10)];
	[self.purchase addTarget:self action:@selector(purchaseProduct:) forControlEvents:UIControlEventTouchUpInside];
    [self.proScrollView addSubview:self.purchase];
	[self.proScrollView addSubview:self.collect];
    
    [self.proScrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0, titleRect.origin.y+25)]];
	
	//Tab
	titleRect.origin.y+=TITLE_HEIGHT+20;
	titleRect.size.height=30;
	titleRect.size.width-=20;//让两边居中
	UISegmentedControl *segment=[UIMakerUtil createSegmentedControl:[NSArray arrayWithObjects:@"商品介绍",@"售后说明",nil] frame:titleRect];
	[segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self ChangeSegmentFont:segment];
	[self.proScrollView addSubview:segment];
	
	//textArea
	titleRect.origin.y+=30;
	titleRect.size.height=200;
	UITextView *proContent=[UIMakerUtil createTextAreaView:self.productData.detail frame:titleRect];
	proContent.tag=101;
	[self.proScrollView addSubview:proContent];
}

-(void) collectProduct:(id) sender
{
    if ([SessionUtil sharedInstance].isLogined) {
        NSString *param=[NSString stringWithFormat:@"goodsId=%@&cusId=%@",self.productData.pid,[SessionUtil sharedInstance].userInformation.cusId];
        NSString *url=[ConstantUtil createRequestURL:COLLECT_URL];
        receivedData=[[NSMutableData alloc] initWithData:nil];
        self.collectConn=[DataSource createPostConn:url param:param delegate:self];
    } else {
        UserViewController *userView=[[[UserViewController alloc] init] autorelease];
		[self.navigationController pushViewController:userView animated:YES]; 
    }
}

-(void) purchaseProduct:(id) sender
{
    //coreData
    ShopCartViewController *cartView=[[[ShopCartViewController alloc] init] autorelease];
    [cartView initCoreData];
    if ([cartView addObject:self.productData]) {
        [UIMakerUtil alert:@"商品已成功加入购物车" title:self.title];
    }
}

-(void)shopCartAction:(id)sender {
    ShopCartViewController *cartView=[[[ShopCartViewController alloc] init] autorelease];
    
    [self.navigationController pushViewController:cartView animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
	self.view.backgroundColor = SYS_BG;
    
	//设置滚动范围
    proScrollView=[UIMakerUtil createScrollView];
	proScrollView.contentSize= CGSizeMake(1,PRO_IMAGE_SIZE+4*TITLE_HEIGHT+200+40+100);
	proScrollView.backgroundColor = SYS_BG;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"购物车" andTarget:self andSelector:@selector(shopCartAction:)];
	[self.view addSubview:proScrollView];
	NSString *param=[NSString stringWithFormat:@"isFromAD=1&%@=%@",DETAIL_PARAM_KEY,self.productData.pid];
	NSString *prosUrl=[ConstantUtil createRequestURL:DETAIL_URL withParam:param];
	receivedData=[[NSMutableData alloc] initWithData:nil];
	self.productConn=[DataSource createConn:prosUrl delegate:self];
}

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
    [pic release];
    [proTitle release];
    [proDetail release];
    [markPrice release];
    [mallPrice release];
    [collect release];
    [purchase release];
    [productData release];
    [proScrollView release];
    [virtualSalesVolume release];
    [invenStatus release];
    [receivedData release];
    [collectConn release];
    [productConn release];
}


@end
