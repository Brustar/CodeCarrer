//
//  PinSprite.m
//  iBowling
//
//  Created by yeals Brustar on 13-5-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PinSprite.h"


@implementation PinSprite

-(id) initWithWorld:(b2World*)world position:(CGPoint)pos
{
	if ((self = [super initWithImage:@"pin.png" inWord:world]))
	{
        // set the body position
        body->SetTransform([Helper toMeters:pos], 0.0f);
	}
	return self;
}

+(id) pinWithWorld:(b2World*)world position:(CGPoint)pos
{
	return [[[self alloc] initWithWorld:world position:pos] autorelease];
}

@end
