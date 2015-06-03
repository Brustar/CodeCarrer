//
//  BallSprite.h
//  iBowling
//
//  Created by yeals Brustar on 13-5-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#import "BodyNode.h"

@interface BallSprite : BodyNode{
    
}

+(id)ball;
+(id) ballWithWorld:(b2World*)world;
@end