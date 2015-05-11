    //
//  AdScrollView.m
//  Meiju
//
//  Created by brustar on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ProDetailImageScrollView.h"

@implementation ProDetailImageScrollView

@synthesize pageControl,proImageArray;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (void)createPages
{
	for (NSString *url in self.proImageArray) 
	{	
		UIImageView *imageView=[UIMakerUtil saveImageViewFromURL:url];
		//add to scrollview
		[self loadScrollViewWithPage:imageView];	
	}
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

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)array{
	self.backgroundColor = SYS_BG;
	self.proImageArray=[NSArray arrayWithArray:array];
	float pageControlHeight = 10;
	int pageCount = [self.proImageArray count];
	frame.size.height -= pageControlHeight;
	
	self = [super initWithFrame:frame];
	if(self){
		//create scrollview
		self.pagingEnabled = YES;
		self.contentSize = CGSizeMake(frame.size.width * pageCount,1);
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		//self.delegate = self;
	
		//create pageview
		CGRect pageViewRect = [self bounds];
		pageViewRect.size.height = pageControlHeight;
		pageViewRect.origin.y = frame.size.height+15;
		pageViewRect.origin.x=(frame.size.width+PRO_IMAGE_SIZE-pageViewRect.size.width)/2;
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
    [proImageArray release];
}

#pragma mark scrolldelegate methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	//UITouch *touch = [touches anyObject];
	//ProDetailImageScrollView *view=(ProDetailImageScrollView *)[touch view];
	//CGFloat pageWidth = self.frame.size.width;
    //int index = floor((view.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	//Product *product=[self.proImageArray objectAtIndex:index];
//	ProductDetailViewController *productDetailView=[UIMakerUtil createProductDetailView:product];
//	[[self firstViewController] pushViewController:productDetailView animated:YES];
}


@end
