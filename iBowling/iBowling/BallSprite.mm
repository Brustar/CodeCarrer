//
//  BallSprite.m
//  iBowling
//
//  Created by yeals Brustar on 13-5-4.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BallSprite.h"

@implementation BallSprite

+(id)ball
{
    return [[self alloc]initWithImage];
}

-(id)initWithImage
{
    if ((self=[super initWithFile:@"Green_ballframes1.png"])) {
        NSMutableArray* frames = [NSMutableArray arrayWithCapacity:13];
        //生成一个18的Array；
        
        for (int i = 1; i < 14; i++)
        {
            NSString *pngFile = [NSString stringWithFormat:@"Green_ballframes%d.png",i];
            
            //利用已知图片名生成纹理；
            CCTexture2D *texture = [[CCTextureCache sharedTextureCache]addImage:pngFile];
            
            //利用纹理生成组成动画的帧；
            CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
            
            //将生成的帧添加到数组中，共18个,之后我们要用这18个frame来构成动画；
            [frames addObject:frame];
            
        }
        
        //利用帧数组生成一个动画，设定帧与帧之间的切换频率为0.05；
        CCAnimation *animation =[CCAnimation animationWithSpriteFrames:frames delay:0.05];
        
        //用CCAnimate将生成的CCAnimation转成可以用精灵操作的动作action:
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
        
        //设置为repeat
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        
        //执行
        [self runAction:repeat];
        //这样，如果该精灵一被实例化成功，就会动起来；
        
    }
    return self;
}

-(id) initWithWorld:(b2World*)world
{
	if ((self = [super initWithImage:@"Green_ballframes1.png" inWord:world]))
	{
        // set the parameters
        body->SetType(b2_dynamicBody);
        body->SetAngularDamping(0.9f);
        
        // enable continuous collision detection
        body->SetBullet(true);
        
        // set random starting point
        [self setBallStartPosition];
        
        // enable handling touches
		//[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
        
        // schedule updates
		[self scheduleUpdate];
	}
	return [self initWithImage];
}

+(id) ballWithWorld:(b2World*)world
{
	return [[[self alloc] initWithWorld:world] autorelease];
}

-(void) setBallStartPosition
{
    // set the ball's position
    float randomOffset = CCRANDOM_0_1() * 10.0f - 5.0f;
    CGPoint startPos = CGPointMake(205 + randomOffset, 80);
    
    body->SetTransform([Helper toMeters:startPos], 0.0f);
    body->SetLinearVelocity(b2Vec2_zero);
    body->SetAngularVelocity(0.0f);
}

-(void) update:(ccTime)delta
{
	/*
    if (moveToFinger == YES)
	{
		// disabled: no longer needed
		// [self applyForceTowardsFinger];
	}
	
	if (self.position.y < -(self.contentSize.height * 10))
	{
		// restart at a random position
		//[self setBallStartPosition];
	}
    */
    // limit speed of the ball
    const float32 maxSpeed = 6.0f;
    b2Vec2 velocity = body->GetLinearVelocity();
    float32 speed = velocity.Length();
    if (speed > maxSpeed)
    {
        body->SetLinearVelocity((maxSpeed / speed) * velocity);
    }
    
    // reset rotation of the ball to keep
    // highlight and shadow in the same place
    body->SetTransform(body->GetWorldCenter(), 0.0f);
}

@end
