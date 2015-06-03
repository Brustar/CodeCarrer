//
//  AppDelegate.h
//  iBowling
//
//  Created by liu zifeng on 13-5-3.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
	
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
