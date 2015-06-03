//
//  MacAddress.h
//  testMac
//
//  Created by yeals Brustar on 14-4-12.
//  Copyright (c) 2014年 yeals Brustar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthViewController.h"
#import "DataPickerView.h"
#include "CCEAGLView-ios.h"

@interface Device : NSObject

+ (NSString *) imei;
+ (int) kindofNetwork;
+ (NSString *) OSVersion;
+ (BOOL) networkReachable;
+ (NSString *) ip;
+ (NSString *) macAddress;
+ (void) showPage:(NSDictionary *)dict;
+ (void) showDate:(NSDictionary *)dict;

@end