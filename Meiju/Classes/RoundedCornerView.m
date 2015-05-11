//
//  roundedCornerView.m
//  UITest
//

#import "RoundedCornerView.h"


@implementation RoundedCornerView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) 
	{
		self.opaque = TRUE;
    }
    return self;
}


void CGContextStrokeCorners(CGContextRef ctx, CGRect rect) {
	
	int radius = 12;
	
	CGFloat xOrigin = rect.origin.x;
	CGFloat yOrigin = rect.origin.y;
	
	CGFloat xMiddle = CGRectGetMidX(rect);
	CGFloat yMiddle = CGRectGetMidY(rect); 
	
	CGFloat width  = rect.size.width;
	CGFloat height = rect.size.height;	
	
    CGContextBeginPath(ctx);  
	
	CGContextMoveToPoint(ctx, xOrigin, yMiddle);
	CGContextAddArcToPoint(ctx, xOrigin, yOrigin, xMiddle, yOrigin, radius);
	CGContextAddArcToPoint(ctx, width, yOrigin, width, yMiddle, radius);
	CGContextAddArcToPoint(ctx, width, height, xMiddle, height, radius);
	CGContextAddArcToPoint(ctx, xOrigin, height, xOrigin, yMiddle, radius);
	
	CGContextClosePath(ctx);
	CGContextStrokePath(ctx);
}

- (void)drawRect:(CGRect)rect {
	
	float lineWidth = 10.0;
	UIColor *parentColor = [[self superview] backgroundColor];
	
	CGContextRef ctx = UIGraphicsGetCurrentContext(); 
	CGContextSetStrokeColorWithColor(ctx, parentColor.CGColor);
	CGContextSetLineWidth(ctx, lineWidth);
	
	//draw corners
	CGContextStrokeCorners(ctx,rect);
}


- (void)dealloc {
    [super dealloc];
}


@end
