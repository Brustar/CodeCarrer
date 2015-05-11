//
//  MallScrollView.m
//  Meiju
//
//  Created by brustar on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MallScrollView.h"


@implementation MallScrollView

@synthesize proArray;

- (void)createPages
{
	for (Product *pro in self.proArray) 
	{
		//NSLog(@"mallscrollViewRect: %@", NSStringFromCGRect(self.frame));
		//UIImageView *imageView=[UIMakerUtil createImageViewFromURL:pro.picURL frame:self.frame];
		//add to scrollview
		//[self loadScrollViewWithPage:imageView];	
        [NSThread detachNewThreadSelector:@selector(updateImageForScroll:) toTarget:self withObject:pro];
	}
}

- (void)updateImageForScroll:(Product *)product{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    UIImage *image = [self getImageForScroll:product.picURL];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.backgroundColor = [UIColor clearColor];
    //imageView.image=image;
    [imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    [self loadScrollViewWithPage:imageView];
    [imageView release];

    [pool release];
}

-(UIImage *)getImageForScroll:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    if (image==nil) {
        image=[UIImage imageNamed:@"noImage"];
    }
    return image;
    /*
    NSString *fileName=[NSString stringWithFormat:@"%@.png",pid];
    NSString *localPath=[ConstantUtil createImagePath:fileName];
    
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:localPath];	
    UIImage *presentImage=nil;
    
    if (exists)
    {
        presentImage=[UIImage imageWithContentsOfFile:localPath];
    }
    else 
    {
        NSURL *url = [NSURL URLWithString:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:localPath atomically:YES];
        presentImage = [UIImage imageWithContentsOfFile:localPath];
    }
    
    if (presentImage==nil) {
        presentImage=[UIImage imageNamed:@"noImage"];
    }
    return presentImage;
    */
}

- (void)loadScrollViewWithPage:(UIView *)page 
{
	int pageCount = [[self subviews] count];
	CGRect bounds = CGRectMake(10, 120, SCROLL_IMAGE_WIDTH-10, SCROLL_IMAGE_WIDTH-10);
    bounds.origin.x = (SCROLL_IMAGE_WIDTH) * pageCount/2+3;
    bounds.origin.y = 7;
    page.frame = bounds;
	CGRect backgroundRect=CGRectMake(bounds.origin.x-3,bounds.origin.y-3,86,86);
	UIImageView *background= [UIMakerUtil createImageView:@"bgPicture" frame:backgroundRect];
	
	[self addSubview:background];
    [self addSubview:page];
	
}

-(id) initWithArray: (NSMutableArray *) array frame:(CGRect)frame
{
	[super init];
	self.proArray=array;
	return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	float pageControlHeight = 10;
	int pageCount = [self.proArray count];
	frame.size.height -= pageControlHeight;
	frame.size.width-=20;			//scroll width
	frame.origin.x+=10;				//scroll padding
	self = [super initWithFrame:frame];
	if(self){
		self.contentSize = CGSizeMake(SCROLL_IMAGE_WIDTH * pageCount,1); //120图片宽度
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		//create pages
		[self createPages];
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
    [proArray release];
}

#pragma mark scrolldelegate methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if(!self.dragging){
		UITouch *touch = [touches anyObject];
		MallScrollView *view=(MallScrollView *)[touch view];
		CGPoint pos=[touch locationInView:view];
		int index = floor(pos.x/ SCROLL_IMAGE_WIDTH);
		if ([self.proArray count]>index) {
			Product *product=[self.proArray objectAtIndex:index];
			ProductDetailViewController *productDetailView=[UIMakerUtil createProductDetailView:product];
			[[[self firstViewController] navigationController] pushViewController:productDetailView animated:YES];
		}
	}
}

@end
