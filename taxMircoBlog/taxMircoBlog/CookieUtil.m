//
//  CookieUtil.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CookieUtil.h"

@implementation CookieUtil

+(void) processCookie:(NSMutableDictionary *)cookieProperties
{
    [cookieProperties setObject:APP_HOST forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:APP_HOST forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:[NSDate dateWithTimeIntervalSinceNow:15*24*60*60] forKey:NSHTTPCookieExpires];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

+(void) clearCookies
{
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

+(void) autoLoginFromCookie
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.domain isEqualToString:APP_HOST]) {
            [dic setObject:cookie.value forKey:cookie.name];
        }
    }
    //视注册情况而定此时等于几(myabe 2)
    if ([dic count]>=2) {
        [self loginWithCookie:dic];
    }
    
}

+(void) loginWithCookie:(NSDictionary *) dic
{
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"cusId"] forKey:@"cusId"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"sex"] forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"nickName"] forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"phone"] forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"email"] forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SessionUtil sharedInstance].isLogined=YES;
    
    UserInfo *userInformation=[[[UserInfo alloc] init] autorelease];
    userInformation.cusId=[[NSUserDefaults standardUserDefaults] stringForKey:@"cusId"];
    userInformation.sex=[[NSUserDefaults standardUserDefaults] stringForKey:@"sex"];
    userInformation.nickName=[[NSUserDefaults standardUserDefaults] stringForKey:@"nickName"];
    userInformation.phone=[[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
    userInformation.email=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    [SessionUtil sharedInstance].userInformation=userInformation; 
}

@end
