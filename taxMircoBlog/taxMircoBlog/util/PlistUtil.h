//
//  PlistUtil.h
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-23.
//
//

#import <Foundation/Foundation.h>
#import "ConstantUtil.h"

#define PLIST_NAME          @"logonUsers"
#define PLIST_EXTEND_NAME   @"plist"
#define PLIST_KEY           @"users"
#define PLIST_FULL_NAME     [PLIST_NAME stringByAppendingFormat:@".%@",PLIST_EXTEND_NAME]

@interface PlistUtil : NSObject

+(void)writeToPlist:(NSString *)userName;

+(NSArray *)arrayFromPlist;

+(void) deleteFromPlist:(int)index;

@end
