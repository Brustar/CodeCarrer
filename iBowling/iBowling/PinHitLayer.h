//
//  HitLayer.h
//  iBowling
//
//  Created by liu zifeng on 13-5-3.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/highgui.hpp>
#import <opencv2/core/core.hpp>
#import <opencv2/highgui/cap_ios.h>
#endif
using namespace cv;
#import "ContactListener.h"
#import "b2World.h"

@interface PinHitLayer : CCLayer <CvVideoCameraDelegate> {
    CvVideoCamera *_videoCamera;
    b2World* _world;
	ContactListener* _contactListener;
	
	//GLESDebugDraw* debugDraw;
}
@property (nonatomic, retain) CvVideoCamera *videoCamera;
+(CCScene *) scene;
@end
