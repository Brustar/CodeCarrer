//
//  CookieUtil.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantUtil.h"
#import "SessionUtil.h"

@interface CookieUtil : NSObject

+(void) processCookie:(NSMutableDictionary *)cookieProperties;

+(void) clearCookies;

+(void) autoLoginFromCookie;

+(void) loginWithCookie:(NSDictionary *) dic;

@end
