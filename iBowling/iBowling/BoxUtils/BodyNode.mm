//
//  BodyNode.m
//  PhysicsBox2d
//
//  Created by Steffen Itterheim on 21.09.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//
//  Enhanced to use PhysicsEditor shapes and retina display
//  by Andreas Loew / http://www.physicseditor.de
//

#import "BodyNode.h"

@implementation BodyNode

@synthesize body;

-(id) initWithImage:(NSString*)imageName inWord:(b2World*)world
{
    NSAssert(world != NULL, @"world is null!");
    NSAssert(imageName != nil, @"name is nil!");
    
    // init the sprite itself with the given shape name
    self = [super initWithFile:imageName];
    if (self)
    {
        // create the body
        b2BodyDef bodyDef;
        body = world->CreateBody(&bodyDef);
        body->SetUserData(self);
        
        // set the shape
        [self setBodyShape:nil];
    }
    return self;
}

-(id) initWithShape:(NSString*)shapeName inWord:(b2World*)world
{
    NSAssert(world != NULL, @"world is null!");
    NSAssert(shapeName != nil, @"name is nil!");

    // init the sprite itself with the given shape name
    self = [super initWithSpriteFrameName:shapeName];
    if (self)
    {        
        // create the body
        b2BodyDef bodyDef;
        body = world->CreateBody(&bodyDef);
        body->SetUserData(self);
        
        // set the shape
        [self setBodyShape:shapeName];
    }
    return self;
}

-(void) setBodyShape:(NSString*)shapeName
{
    // remove any existing fixtures from the body
    b2Fixture* fixture;
    while ((fixture = body->GetFixtureList()))
    {
        body->DestroyFixture(fixture);
    }

    // attach a new shape from the shape cache
    if (shapeName)
    {
        GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache];
        [shapeCache addFixturesToBody:body forShapeName:shapeName];
        self.anchorPoint = [shapeCache anchorPointForShape:shapeName];
    }
}

-(void) dealloc
{
    // remove the body from the world
    body->GetWorld()->DestroyBody(body);

	[super dealloc];
}

@end
