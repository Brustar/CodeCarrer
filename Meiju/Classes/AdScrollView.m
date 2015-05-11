    //
//  AdScrollView.m
//  Meiju
//
//  Created by brustar on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AdScrollView.h"

@implementation AdScrollView

@synthesize pageControl,adArray;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (void)createPages
{
	for (Advertisement *ad in self.adArray) 
	{	
		//UIImageView *imageView=[UIMakerUtil createImageViewFromURL:ad.picAddr frame:self.frame];
        [NSThread detachNewThreadSelector:@selector(updateImageForAD:) toTarget:self withObject:ad];
	}
}

- (void)updateImageForAD:(Advertisement *)ad{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    UIImage *image = [self getImageForAD:ad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
    imageView.backgroundColor = [UIColor clearColor];
    //imageView.image=image;
    [imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    //add to scrollview
    [self loadScrollViewWithPage:imageView];
    [imageView release];
    [pool release];
}

-(UIImage *)getImageForAD:(Advertisement *)ad
{
    NSString *path =ad.picAddr;
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
  /*
    NSString *fileName=[NSString stringWithFormat:@"ad%@.png",ad.adId];
    NSString *localPath=[ConstantUtil createImagePath:fileName];
    
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:localPath];	
    UIImage *presentImage=nil;
    
    if (exists)
    {
        presentImage=[UIImage imageWithContentsOfFile:localPath];
    }
    else 
    {
        NSString *path =ad.picAddr;
        NSURL *url = [NSURL URLWithString:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:localPath atomically:YES];
        presentImage = [UIImage imageWithContentsOfFile:localPath];
    }
    return presentImage;
   */ 
}

- (void)changePage:(id)sender
{
	int page = pageControl.currentPage;	
	// update the scroll view to the appropriate page
    CGRect frame = self.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self scrollRectToVisible:frame animated:YES];
}

- (void)loadScrollViewWithPage:(UIView *)page 
{
	int pageCount = [[self subviews] count];	
	CGRect bounds = self.bounds;
    bounds.origin.x = bounds.size.width * pageCount;
    bounds.origin.y = 0;
    page.frame = bounds;
    [self addSubview:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender 
{
	CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

-(id) initWithArray: (NSMutableArray *) array frame:(CGRect)frame
{
	[super init];
	self.adArray=array;
	return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	float pageControlHeight = 10;
	int pageCount = [self.adArray count];
	frame.size.height -= pageControlHeight;
	if(self){
		//create scrollview
		self.pagingEnabled = YES;
		self.contentSize = CGSizeMake(self.frame.size.width * pageCount,1);
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.delegate=self;
		
		//create pageview
		CGRect pageViewRect = [self bounds];
		pageViewRect.size.height = pageControlHeight;
		pageViewRect.origin.y = self.frame.size.height-10;
		
		pageControl = [[UIPageControl alloc] initWithFrame:pageViewRect];
		pageControl.numberOfPages = pageCount;
		pageControl.currentPage = 0;
		[pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
		
		//create pages
		[self createPages];
	}
	return self;
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
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
   // [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[pageControl release];
    [adArray release];
}

#pragma mark scrollDelegate methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(!self.dragging){
		UITouch *touch = [touches anyObject];
		AdScrollView *view=(AdScrollView *)[touch view];
		CGFloat pageWidth = self.frame.size.width;
		int index = floor((view.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		if ([self.adArray count]>index) {
			Advertisement *ad=[self.adArray objectAtIndex:index];
			int flag=[ad forwardNumber];
			Product *product;
			News *news;
			switch (flag) {
				case 1:	//http
					[[UIApplication sharedApplication]openURL:[[[NSURL alloc] initWithString:ad.link] autorelease]]; 
					break;
				case 2:	//商品
					product=[Product productWithId:[[ad.link componentsSeparatedByString:@":"] lastObject]];
					ProductDetailViewController *productDetailView=[UIMakerUtil createProductDetailView:product];
					[[[self firstViewController] navigationController] pushViewController:productDetailView animated:YES];
					break;
				case 3:	//news
					news=[News newsWithId:[[ad.link componentsSeparatedByString:@":"] lastObject]];
					[[[self firstViewController] navigationController] pushViewController:[UIMakerUtil createNewsDetailView:news] animated:YES];
					break;
				default:
					break;
			}
		}
	}

}


@end
