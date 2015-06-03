//
//  PinHitLayer.m
//  iBowling
//
//  Created by liu zifeng on 13-5-3.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PinHitLayer.h"
#import "visionAnalysis.h"
#import "BallSprite.h"
#import "GLES-Render.h"
#import "Box2D.h"
#import "BodyNode.h"
#import "ContactListener.h"
#import "GB2ShapeCache.h"
#import "Constants.h"
#import "Helper.h"
#import "PinSprite.h"

@implementation PinHitLayer
@synthesize videoCamera=_videoCamera;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PinHitLayer *layer = [PinHitLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        
        // load physics definitions
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"bowling.plist"];
        // init the box2d world
		[self initBox2dWorld];
        
        //[self initCamera];
        [self createExitMenu];
        [self createBowlingTable];
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) initBox2dWorld
{
	// Construct a world object, which will hold and simulate the rigid bodies.
	b2Vec2 gravity = b2Vec2(0.0f, 2.0f);
	bool allowBodiesToSleep = true;
	_world = new b2World(gravity);
    _world->SetAllowSleeping(allowBodiesToSleep);
	
	_contactListener = new ContactListener();
	_world->SetContactListener(_contactListener);
	
	// Define the static container body, which will provide the collisions at screen borders.
	b2BodyDef containerBodyDef;
	b2Body* containerBody = _world->CreateBody(&containerBodyDef);
    
	// for the ground body we'll need these values
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	float widthInMeters = screenSize.width / PTM_RATIO;
	float heightInMeters = screenSize.height / PTM_RATIO;
	b2Vec2 lowerLeftCorner = b2Vec2(0, 0);
	b2Vec2 lowerRightCorner = b2Vec2(widthInMeters, 0);
	b2Vec2 upperLeftCorner = b2Vec2(0, heightInMeters);
	b2Vec2 upperRightCorner = b2Vec2(widthInMeters, heightInMeters);
	
	// Create the screen box' sides by using a polygon assigning each side individually.
	b2PolygonShape screenBoxShape;
	float density = 0.0;
    
	// We only need the sides for the table:
	// left side
	//screenBoxShape.SetAsEdge(upperLeftCorner, lowerLeftCorner);
	b2Fixture *left = containerBody->CreateFixture(&screenBoxShape, density);
	
	// right side
	//screenBoxShape.SetAsEdge(upperRightCorner, lowerRightCorner);
	b2Fixture *right = containerBody->CreateFixture(&screenBoxShape, density);
    
    // set the collision flags: category and mask
    b2Filter collisonFilter;
    collisonFilter.groupIndex = 0;
    collisonFilter.categoryBits = 0x0010; // category = Wall
    collisonFilter.maskBits = 0x0001;     // mask = Ball
    
    left->SetFilterData(collisonFilter);
    right->SetFilterData(collisonFilter);
}

-(void) update:(ccTime)delta
{
	// The number of iterations influence the accuracy of the physics simulation. With higher values the
	// body's velocity and position are more accurately tracked but at the cost of speed.
	// Usually for games only 1 position iteration is necessary to achieve good results.
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	_world->Step(delta, velocityIterations, positionIterations);
    
	// for each body, get its assigned BodyNode and update the sprite's position
	for (b2Body* body = _world->GetBodyList(); body != nil; body = body->GetNext())
	{
		BodyNode* bodyNode = (BodyNode*)body->GetUserData();
		if (bodyNode != nil)
		{
			// update the sprite's position to where their physics bodies are
			bodyNode.position = [Helper toPixels:body->GetPosition()];
			float angle = body->GetAngle();
			bodyNode.rotation = -(CC_RADIANS_TO_DEGREES(angle));
		}
	}
}

-(void) createBowlingTable
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    int laneWidth=120;
    int pinWidth=30;
    CCSprite *lane=[CCSprite spriteWithFile:@"lane.png"];
    if(isDeviceIPad()){
        lane.position = ccp(size.width/2,(size.height-425)/2);
    }else{
        lane.position = ccp(size.width/2,size.height/2);
    }
    for (int i=0; i<10; i++) {
        int col=i==0?0:(i==9?3:i/3+1);
        int start=i-col;
        if (col==2) {
            start=i-1-col;
        }
        if (col==3) {
            start=i-3-col;
        }
        
        CGPoint pinPosition = ccp((size.width-laneWidth+(1-col+start*2)*pinWidth)/2,(size.height+laneWidth+col*pinWidth)/2);
        CCSprite *pin=[PinSprite pinWithWorld:_world position:pinPosition];
        [lane addChild:pin z:10-i];
    }
    
    //在层上添加精灵；
    BallSprite *ball = [BallSprite ballWithWorld:_world];
    [lane addChild:ball z:100];
    
    //ball.position = ccp(size.width/2, 0);
    
    //id move = [CCMoveTo actionWithDuration:5 position:ccp(size.width/2-45,size.height*2)];
    
    //[ball runAction:move];
    
    [self addChild: lane];
}

-(void) createExitMenu
{
	// Default font size will be 22 points.
	[CCMenuItemFont setFontSize:isDeviceIPad()?36:22];
	
	// Reset Button
	CCMenuItemLabel *play = [CCMenuItemFont itemWithString:@"exit" block:^(id sender){
		exit(1);
	}];
    play.anchorPoint=ccp(1,1);
	CCMenu *menu = [CCMenu menuWithItems: play, nil];
	
	CGSize size = [[CCDirector sharedDirector] winSize];
    
	[menu setPosition:ccp( size.width, size.height)];
	menu.color=ccGRAY;
	
	[self addChild: menu z:-1];
}

-(void) initCamera
{
    // Do any additional setup after loading the view, typically from a nib.
    _videoCamera = [[CvVideoCamera alloc] initWithParentView:nil];
    _videoCamera.delegate = self;
    _videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    _videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    //self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeLeft;
    _videoCamera.defaultFPS = 10;
    _videoCamera.grayscaleMode = NO;
    //cameraState = NO;
    //invState = NO;
    [_videoCamera start];
    //cameraState = YES;
    
    //initialize the vision analysis module
    initSystem(640, 480, 640*4, 4);
}

#pragma mark - Protocol CvVideoCameraDelegate
#ifdef __cplusplus
- (void)processImage:(Mat&)image
{
    int widthStep, cn;
    cv::Mat grayFrame, output;
    
    widthStep = image.cols * image.channels();
    cn = image.channels();
    
    // Do some OpenCV stuff with the image
    Mat image_copy;
    cvtColor(image, image_copy, CV_BGRA2BGR);
    
    
    /*
     cvtColor(image, grayFrame, COLOR_RGB2GRAY);
     cv::Canny(grayFrame, image,
     0.8 * 7 * 7,
     0.8 * 7 * 7,
     7); */
    
    uint8_t* pixelPtr = (uint8_t*)image.data;
    
    //perform the core vision analysis here
    visionAnalysis((unsigned char *)pixelPtr);
    
    //display results
    ccShowResults(image);
    
    
    //self.imageView.image = [UIImage imageWithCVMat:output];
    
}
#endif


void ccShowResults(Mat& frame)
{
    
	int r, c, width, height, maskWidth, maskHeight, sC, sR, widthStep, lbVal;
	unsigned char *ptr;
	int superPixMapW, superPixMapH, nChannels;
	int colorArray[6][3] = {{0, 0, 0}, {255, 255, 255}, {255, 0, 0}, {255, 255, 0}, {0, 0, 255}, {255, 0, 255}};
    
	maskWidth = ccGst->maskWidth;
	maskHeight = ccGst->maskHeight;
	width = gst->width;
	height = gst->height;
    
	superPixMapW	= ccGst->superPixMapW;
	superPixMapH	= ccGst->superPixMapH;
	widthStep = gst->widthStep;
    nChannels = gst->nChannels;
    
    
#if 0
    //show the color mask map
    
	for(r=0; r<height; r++)
        for(c=0; c<width; c++)
        {
            
            ptr = (unsigned char *)(frame.data + r * widthStep + c * nChannels);
            if(*(gst->colorMask + (r/BLK_SIZE) * (width/BLK_SIZE) + (c/BLK_SIZE)) == 1)
            {
                ptr[0] = 0;
                ptr[1] = 255;
                ptr[2] = 255;
            }
            else
            {
                ptr[0] = 0;
                ptr[1] = 0;
                ptr[2] = 0;
            }
            
        }
#endif
    
    
#if 1
    //show the connect component
    
	for(r=0; r<height; r++)
        for(c=0; c<width; c++)
        {
            sR = r / BLK_SIZE /  CC_SUPER_PIXEL_H;
            sC = c / BLK_SIZE / CC_SUPER_PIXEL_W;
            
            lbVal = *(ccGst->dataSuperPixMap + (sR * superPixMapW) + sC);
            if(lbVal > 0) lbVal = (lbVal - 1) % 5 + 1;
            
            ptr = (unsigned char *)(frame.data + r * widthStep + c * nChannels);
            ptr[0] = colorArray[lbVal][2];
            //ptr[1] = colorArray[lbVal][1];
            ptr[2] = colorArray[lbVal][0];
            
        }
#endif
    
#if 1
    
    //plot the bounding boxes;
    
	int R0, R1, C0, C1, k, boxW, boxH;
    double whRatio;
    
	//plot the bounding boxes
	for(k=0; k<ccGst->numObjects; k++)
	{
		R0 = ccGst->boundingBoxes[5*k+1] * BLK_SIZE *  CC_SUPER_PIXEL_H;
		C0 = ccGst->boundingBoxes[5*k+2] * BLK_SIZE *  CC_SUPER_PIXEL_W;
		R1 = ccGst->boundingBoxes[5*k+3] * BLK_SIZE *  CC_SUPER_PIXEL_H;
		C1 = ccGst->boundingBoxes[5*k+4] * BLK_SIZE *  CC_SUPER_PIXEL_W;
        
        boxW = C1 - C0;
        boxH = R1 - R0;
        whRatio = boxW / (boxH + 1);
        
        //if((boxW > 10) && (boxH > 10) && (whRatio > 0.5) && (whRatio < 2))
        cv::rectangle(frame, cvPoint(C0, R0), cvPoint(C1, R1), CV_RGB(255, 128, 0), 3, 8, 0);
		
	}
    
#endif
    
}


@end
