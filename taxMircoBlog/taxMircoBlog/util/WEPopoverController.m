//
//  PopupViewController.m
//  WEPopover
//
//  Created by Werner Altewischer on 02/09/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import "WEPopoverController.h"
#import "WEPopoverParentView.h"

#define FADE_DURATION 0.2

@interface WEPopoverController(Private)

- (void)setView:(UIView *)v;
- (CGRect)displayAreaForView:(UIView *)theView;
- (WEPopoverContainerViewProperties *)defaultContainerViewProperties;

@end


@implementation WEPopoverController

@synthesize contentViewController;
@synthesize popoverContentSize;
@synthesize popoverVisible;
@synthesize popoverArrowDirection;
@synthesize dismiss_delegate;
@synthesize view;
@synthesize containerViewProperties;
@synthesize context;

- (id)initWithContentViewController:(UIViewController *)viewController {
	if ((self = [self init])) {
		self.contentViewController = viewController;
	}
	return self;
}

- (void)dealloc {
	[self dismissPopoverAnimated:NO];
	[contentViewController release];
	[containerViewProperties release];
	self.context = nil;
    
    
    if(parentView) {
        [parentView removeGestureRecognizer:tapGesture];
    }
    [tapGesture release];
    tapGesture = nil;
    parentView = nil;
    
    
	[super dealloc];
}

- (void)setContentViewController:(UIViewController *)vc {
	if (vc != contentViewController) {
		[contentViewController release];
		contentViewController = [vc retain];
		popoverContentSize = [vc contentSizeForViewInPopover];
	}
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	
	if ([animationID isEqual:@"FadeIn"]) {
		self.view.userInteractionEnabled = YES;
		popoverVisible = YES;
		[contentViewController viewDidAppear:YES];
	} else {
        if(dismiss_delegate && [dismiss_delegate respondsToSelector:@selector(popoverControllerDidDismissPopover:)]) {
            [dismiss_delegate popoverControllerDidDismissPopover:self];
        }
		popoverVisible = NO;
		[contentViewController viewDidDisappear:YES];
		[self.view removeFromSuperview];
		self.view = nil;
	}
}

- (void)dismissPopoverAnimated:(BOOL)animated {
	
	if (self.view) {
		[contentViewController viewWillDisappear:animated];
		
        if(tapGesture) {
            [parentView removeGestureRecognizer:tapGesture];
            [tapGesture autorelease];
            tapGesture = nil;
        }
            
		if (animated) {
			
			self.view.userInteractionEnabled = NO;
			[UIView beginAnimations:@"FadeOut" context:nil];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
			
			[UIView setAnimationDuration:FADE_DURATION];
			
			self.view.alpha = 0.0;
			
			[UIView commitAnimations];
		} else {
            if(dismiss_delegate && [dismiss_delegate respondsToSelector:@selector(popoverControllerDidDismissPopover:)]) {
                [dismiss_delegate popoverControllerDidDismissPopover:self];
            }
            
			popoverVisible = NO;
			[contentViewController viewDidDisappear:animated];
			[self.view removeFromSuperview];
			self.view = nil;
		}
	}
}

- (void)parentViewTapped:(UITapGestureRecognizer *)theTapGesture {
     // dismiss the popover if it's visible and conforms to the delegate protocol
    
    if(dismiss_delegate && [dismiss_delegate respondsToSelector:@selector(popoverControllerShouldDismissPopover:)]) {
        CGPoint tap = [theTapGesture locationInView:view];
        if(![view pointInside:tap withEvent:nil]) {
            if([self isPopoverVisible] && [dismiss_delegate popoverControllerShouldDismissPopover:self]) {
                [self dismissPopoverAnimated:YES];
                
                [parentView removeGestureRecognizer:tapGesture];
                [tapGesture autorelease];
                tapGesture = nil;
            }
        } 
    }
}



- (void)presentPopoverFromRect:(CGRect)rect 
						inView:(UIView *)theView 
	  permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections 
					  animated:(BOOL)animated {
	
	
	[self dismissPopoverAnimated:NO];
	
	CGRect displayArea = [self displayAreaForView:theView];
	
	WEPopoverContainerViewProperties *props = self.containerViewProperties ? self.containerViewProperties : [self defaultContainerViewProperties];
	WEPopoverContainerView *containerView = [[[WEPopoverContainerView alloc] initWithSize:self.popoverContentSize anchorRect:rect displayArea:displayArea permittedArrowDirections:arrowDirections properties:props] autorelease];
	popoverArrowDirection = containerView.arrowDirection;
	[theView addSubview:containerView];

	containerView.contentView = contentViewController.view;
	
	self.view = containerView;
	
	[contentViewController viewWillAppear:animated];
    
    // Used to dismiss the popover if it's parent view is touched
    if([dismiss_delegate popoverControllerShouldDismissPopover:self]){
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(parentViewTapped:)];
        tapGesture.cancelsTouchesInView = NO;
        [theView addGestureRecognizer:tapGesture];
    }else{
        tapGesture = nil;
    }
    
    parentView = theView;
   
    //NSLog(@"contentView: %@",NSStringFromCGRect(contentViewController.view.frame));
     
	if (animated) {
		self.view.userInteractionEnabled = NO;
		self.view.alpha = 0.0;
		
		[UIView beginAnimations:@"FadeIn" context:nil];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
		[UIView setAnimationDuration:FADE_DURATION];
		
		self.view.alpha = 1.0;
		
		[UIView commitAnimations];
	} else {
		self.view.userInteractionEnabled = YES;
		popoverVisible = YES;
		[contentViewController viewDidAppear:animated];
	}
}

- (void)repositionPopoverFromRect:(CGRect)rect
	   permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections {
	[(WEPopoverContainerView *)self.view updatePositionWithAnchorRect:rect
														displayArea:[self displayAreaForView:self.view.superview]
										   permittedArrowDirections:arrowDirections];
	popoverArrowDirection = ((WEPopoverContainerView *)self.view).arrowDirection;
}


@end


@implementation WEPopoverController(Private)

- (void)setView:(UIView *)v {
	if (view != v) {
		[view release];
		view = [v retain];
	}
}

- (CGRect)displayAreaForView:(UIView *)theView {
	CGRect displayArea = CGRectZero;
	if ([theView conformsToProtocol:@protocol(WEPopoverParentView)] && [theView respondsToSelector:@selector(displayAreaForPopover)]) {
		displayArea = [(id <WEPopoverParentView>)theView displayAreaForPopover];
	} else if ([theView isKindOfClass:[UIScrollView class]]) {
		CGPoint contentOffset = [(UIScrollView *)theView contentOffset];
		displayArea = CGRectMake(contentOffset.x, contentOffset.y, theView.frame.size.width, theView.frame.size.height);
	} else {
		displayArea = CGRectMake(0, 0, theView.frame.size.width, theView.frame.size.height);
	}
	return displayArea;
}

- (WEPopoverContainerViewProperties *)defaultContainerViewProperties {
	WEPopoverContainerViewProperties *ret = [[WEPopoverContainerViewProperties alloc] autorelease];
	
	NSString *bgImageName = nil;
	CGFloat bgCapSize = 0.0;
    
    bgImageName = @"popoverBg.png";
    
    // These constants are determined by the popoverBg.png image file and are image dependent
    bgCapSize = 34; // ImageSize/2  == 62 / 2 == 31 pixels
    
    UIEdgeInsets backgroundMargins = UIEdgeInsetsMake(14.0, 14.0, 14.0, 14.0); //设置弹出窗边距:上，左，下，右
    UIEdgeInsets contentMargins = UIEdgeInsetsMake(2,2,2,2);
    
	ret.leftBgMargin = backgroundMargins.left;// - 6;
	ret.rightBgMargin = backgroundMargins.right;// - 4.5;
	ret.topBgMargin = backgroundMargins.top;
	ret.bottomBgMargin = backgroundMargins.bottom;

	ret.leftBgCapSize = bgCapSize;
	ret.topBgCapSize = bgCapSize;
	ret.bgImageName = bgImageName;
	
    ret.leftContentMargin = contentMargins.left;
	ret.rightContentMargin = contentMargins.right;
	ret.topContentMargin = contentMargins.top; 
	ret.bottomContentMargin = contentMargins.bottom;
	
	ret.upArrowImageName = @"popoverArrowUp.png";
	ret.downArrowImageName = @"popoverArrowDown.png";
	ret.leftArrowImageName = @"popoverArrowLeft.png";
	ret.rightArrowImageName = @"popoverArrowRight.png";
	return ret;
}


@end
