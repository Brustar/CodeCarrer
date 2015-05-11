//
//  MeijuAppDelegate.h
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "AlixPay.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import <sys/utsname.h>
#import "UserViewController.h"

@interface MeijuAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (BOOL)isSingleTask;
- (void)parseURL:(NSURL *)url application:(UIApplication *)application;

@end
