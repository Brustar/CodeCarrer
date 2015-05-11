//
//  NewsDetailViewController.m
//  Meiju
//
//  Created by brustar on 12-4-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailViewController.h"

@implementation NewsDetailViewController

@synthesize news,scrollView,receivedData,showRight;

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
	self.news=[self.news createNews:json];
	[self createUI];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(IBAction)showAllNews:(id)sender
{
    StoreNewsViewController *view=[[[StoreNewsViewController alloc] init] autorelease];
    [self.navigationController pushViewController:view animated:YES];
}

-(void) createUI
{	
	UILabel *newstitle=[UIMakerUtil createTitleLabel:self.news.title frame:CGRectMake(10,10, self.view.frame.size.width-20,TITLE_HEIGHT)];
	[self.scrollView addSubview:newstitle];
	
	[self.scrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0, TITLE_HEIGHT+15)]];

	UIImageView *newsImage=[UIMakerUtil createImageViewFromURL:self.news.picAddr frame:CGRectMake(40,20+TITLE_HEIGHT, NEWS_IMAGE_SIZE,NEWS_IMAGE_SIZE)];
	[self.scrollView addSubview:newsImage];
	
	CGRect contentRect=CGRectMake(10,TITLE_HEIGHT+25,self.view.frame.size.width-20,400);
	if(newsImage.image)
	{
		contentRect.origin.y+=NEWS_IMAGE_SIZE;
        //contentRect.size.height=self.view.frame.size.height-TITLE_HEIGHT;
	}
	UITextView *newsContent=[UIMakerUtil createNOBgTextAreaView:self.news.content frame:contentRect];
	[self.scrollView addSubview:newsContent];
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	//设置返回按钮的颜色
	self.navigationController.navigationBar.tintColor=ORANGE_BG;
	//设置滚动范围
    scrollView=[UIMakerUtil createScrollView];
	scrollView.contentSize= CGSizeMake(1,400+TITLE_HEIGHT+NEWS_IMAGE_SIZE);
	scrollView.backgroundColor = SYS_BG;
    
    if(self.showRight)
    {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"所有资讯" andTarget:self andSelector:@selector(showAllNews:)];
    }
    
    [self.view addSubview:scrollView];
	
	if (self.news.title) {
		[self createUI];
	}else {
		NSString *param=[NSString stringWithFormat:@"%@=%@",NEWS_ID,self.news.newsId];
		NSString *newsUrl=[ConstantUtil createRequestURL:NEWS_DETAIL_URL withParam:param];
		receivedData=[[NSMutableData alloc] initWithData:nil];
		[DataSource createConn:newsUrl delegate:self];
	}
	
}

- (void)dealloc {	
	[news release];
    [receivedData release];
    [scrollView release];
    [super dealloc];
}


@end
