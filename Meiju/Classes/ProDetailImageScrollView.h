//
//  AdScrollView.h
//  Meiju
//
//  Created by brustar on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "DataSource.h"
#import "TopViewController.h"

@interface ProDetailImageScrollView : UIScrollView{
	UIPageControl *pageControl;
	NSArray *proImageArray;
}

- (void)loadScrollViewWithPage:(UIView *)page;
- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)array;

@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) NSArray *proImageArray;

@end

