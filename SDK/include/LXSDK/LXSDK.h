//
//  LXSDK.h
//  LXSDK
//
//  Created by lexun05 on 14/12/8.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TopUpMenuViewController.h"
#import "LoginViewController.h"
#import "MainMenuViewController.h"
#import "MpayViewController.h"
#import "AlipayViewController.h"
#import "JcardViewController.h"
#import "BindMobileViewController.h"
#import "FindPWDViewController.h"
#import "ModifyPWDViewController.h"
#import "PayListViewController.h"
#import "ProtoclViewController.h"
#import "RegViewController.h"
#import "ResetPWDViewController.h"
#import "UnbindingMobileViewController.h"
#import "UnbindMobileViewController.h"

@interface LXSDK : NSObject

+ (void)login:(UIViewController *)delegate;
+ (void)main:(UIViewController *)delegate;
+ (void)charge:(UIViewController *)delegate;

+ (void)login;
+ (void)main;
+ (void)charge;

@end
