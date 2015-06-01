//
//  Md5Util.h
//  Meiju
//
//  Created by Simon Zhou on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

#define GAME_ID     @"1"
#define BASE_URL    @"http://120.204.196.247/"
#define CARD_CHANGE_URL @"http://cz.lexun.com/vip/"

#define BIND_PHONE_NUMBER_URL  [BASE_URL stringByAppendingString:@"bindphone.aspx"]

@interface Md5Util : NSObject

//通过字符串获得MD5码
+(NSString *)md5:(NSString *)str;

@end
