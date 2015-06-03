//
//  WhiteboardNodeDetailsView.h
//  WEPopover
//
//  Created by Werner Altewischer on 02/09/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CGRectWithRoundedPointsOfCGRect(a) CGRectMake(round(a.origin.x), round(a.origin.y), round(a.size.width), round(a.size.height))
#define CGSizeWithRoundedPointsOfCGSize(a) CGSizeMake(round(a.width), round(a.height))

@interface WEPopoverContainerViewProperties : NSObject
{
	NSString *bgImageName;
	NSString *upArrowImageName;
	NSString *downArrowImageName;
	NSString *leftArrowImageName;
	NSString *rightArrowImageName;
	CGFloat leftBgMargin;
	CGFloat rightBgMargin;
	CGFloat topBgMargin;
	CGFloat bottomBgMargin;
	NSInteger topBgCapSize;
	NSInteger leftBgCapSize;
}

@property(nonatomic, retain) NSString *bgImageName;
@property(nonatomic, retain) NSString *upArrowImageName;
@property(nonatomic, retain) NSString *downArrowImageName;
@property(nonatomic, retain) NSString *leftArrowImageName;
@property(nonatomic, retain) NSString *rightArrowImageName;
@property(nonatomic, assign) CGFloat leftBgMargin;
@property(nonatomic, assign) CGFloat rightBgMargin;
@property(nonatomic, assign) CGFloat topBgMargin;
@property(nonatomic, assign) CGFloat bottomBgMargin;
@property(nonatomic, assign) CGFloat leftContentMargin;
@property(nonatomic, assign) CGFloat rightContentMargin;
@property(nonatomic, assign) CGFloat topContentMargin;
@property(nonatomic, assign) CGFloat bottomContentMargin;
@property(nonatomic, assign) NSInteger topBgCapSize;
@property(nonatomic, assign) NSInteger leftBgCapSize;

@end


@interface WEPopoverContainerView : UIView {
	UIImage *bgImage;
	UIImage *arrowImage;
	
	WEPopoverContainerViewProperties *properties;
	
	UIPopoverArrowDirection arrowDirection;
	
	CGRect arrowRect;
	CGRect bgRect;
	CGPoint offset;
	
	
	CGSize correctedSize;
	UIView *contentView;
}

@property (nonatomic, readonly) UIPopoverArrowDirection arrowDirection;
@property (nonatomic, retain) UIView *contentView;

- (id)initWithSize:(CGSize)theSize 
		anchorRect:(CGRect)anchorRect 
	   displayArea:(CGRect)displayArea
permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections
		properties:(WEPopoverContainerViewProperties *)properties;	

- (void)updatePositionWithAnchorRect:(CGRect)anchorRect 
						 displayArea:(CGRect)displayArea
			permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections;	


@end
