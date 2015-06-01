//
//  DialogUtil.m
//  sdkExample
//
//  Created by lexun05 on 14/12/15.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "DialogUtil.h"

@implementation DialogUtil

+ (void) alert: (NSString *) message title:(NSString *) title
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+ (void) alert: (NSString *) message title:(NSString *) title delegate:(id) delegate
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+(void) confirm: (NSString *) message title:(NSString *) title delegate:(id) delegate
{
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:@"cancel", nil];
    
    [confirmDiag show];
}

+(void)showaiting:(UIActivityIndicatorView *)indicator withUI:(UIView *)container
{
    [indicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    container.hidden=NO;
}

+(void)stopwaiting:(UIActivityIndicatorView *)indicator withUI:(UIView *)container
{
    [indicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    container.hidden=YES;
}

+ (NSString *) IMEI
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
    {
        return [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    else
    {
        return @"UNDER IOS 6";
    }
    
}

+ (void) back
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController dismissModalViewControllerAnimated:YES];
}

@end
