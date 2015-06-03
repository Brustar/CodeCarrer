//
//  Md5Util.h
//  Meiju
//
//  Created by Simon Zhou on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Md5Util : NSObject

//通过字符串获得MD5码
+(NSString *)md5:(NSString *)str;

@end
