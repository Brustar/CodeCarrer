//
//  LXSDK.m
//  LXSDK
//
//  Created by lexun05 on 14/12/8.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "LXSDK.h"

@implementation LXSDK

+ (void)login:(UIViewController *)delegate
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LexunSDK" bundle:nil];
    UIViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [LoginViewController class];
    [delegate presentViewController:controller animated:YES completion:NULL];
}

+ (void)main:(UIViewController *)delegate
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LexunSDK" bundle:nil];
    UIViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"main"];
    
    [MainMenuViewController class];
    [delegate presentViewController:controller animated:YES completion:NULL];
}

+ (void)charge:(UIViewController *)delegate
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LexunSDK" bundle:nil];
    UIViewController *controller=[storyboard instantiateViewControllerWithIdentifier:@"charge"];
    
    [TopUpMenuViewController class];
    [delegate presentViewController:controller animated:YES completion:NULL];
}

+ (void)login
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LexunSDK" bundle:nil];
    UIViewController *targetController=[storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [LoginViewController class];
    [ResetPWDViewController class];
    [FindPWDViewController class];
    [RegViewController class];
    [ProtoclViewController class];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentModalViewController:targetController animated:YES];
}

+ (void)main
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LexunSDK" bundle:nil];
    UIViewController *targetController=[storyboard instantiateViewControllerWithIdentifier:@"main"];
    
    [MainMenuViewController class];
    [BindMobileViewController class];
    [UnbindingMobileViewController class];
    [UnbindMobileViewController class];
    [ModifyPWDViewController class];
    [PayListViewController class];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentModalViewController:targetController animated:YES];
}

+ (void)charge
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"LexunSDK" bundle:nil];
    UIViewController *targetController=[storyboard instantiateViewControllerWithIdentifier:@"charge"];
    
    [TopUpMenuViewController class];
    [MpayViewController class];
    [JcardViewController class];
    [AlipayViewController class];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController presentModalViewController:targetController animated:YES];
}

@end