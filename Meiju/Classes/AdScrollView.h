//
//  AdScrollView.h
//  Meiju
//
//  Created by brustar on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "DataSource.h"
#import "TopViewController.h"
#import "HttpContent.h"

#define ADSURL	@"/adListFromFront.do"		//滚动广告地址

@interface AdScrollView : UIScrollView <UIScrollViewDelegate>{
	UIPageControl *pageControl;
	NSMutableArray *adArray;
}

-(id) initWithArray: (NSMutableArray *) array frame:(CGRect)frame;
- (void)loadScrollViewWithPage:(UIView *)page;

@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) NSMutableArray *adArray;

@end

