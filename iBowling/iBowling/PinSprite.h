//
//  PinSprite.h
//  iBowling
//
//  Created by yeals Brustar on 13-5-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#import "BodyNode.h"

@interface PinSprite : BodyNode {
    
}

+(id) pinWithWorld:(b2World*)world position:(CGPoint)pos;

@end
