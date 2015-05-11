//
//  MallScrollView.h
//  Meiju
//
//  Created by brustar on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "DataSource.h"
#import "TopViewController.h"

#define SCROLL_IMAGE_WIDTH	90		//滚动图片宽度

@interface MallScrollView : UIScrollView {
	NSMutableArray *proArray;
	
}

-(id) initWithArray: (NSMutableArray *)array frame:(CGRect)frame;
- (void)loadScrollViewWithPage:(UIView *)page;

@property (nonatomic,retain) NSMutableArray *proArray;

@end
