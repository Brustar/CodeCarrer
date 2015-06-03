//
//  PlistUtil.m
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-23.
//
//

#import "PlistUtil.h"

@implementation PlistUtil

+(void)writeToPlist:(NSString *)userName
{
    NSString *plistPathOfSand = [ConstantUtil createSandTempPath:PLIST_FULL_NAME];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:PLIST_NAME ofType:PLIST_EXTEND_NAME];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *data =nil;
    if ([fileManager fileExistsAtPath:plistPathOfSand]) {
        data = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPathOfSand] autorelease];
    }else{
        data = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] autorelease];
    }
    NSArray *userArray=[data objectForKey:PLIST_KEY];
    NSMutableArray *writeData=[[userArray mutableCopy] autorelease];
    if (![writeData containsObject:userName]) {
        [writeData insertObject:userName atIndex:0];
        [data setObject:writeData forKey:PLIST_KEY];
        [data writeToFile:plistPathOfSand atomically:YES];
    }
}

+(NSArray *)arrayFromPlist
{
    NSString *plistPathOfSand = [ConstantUtil createSandTempPath:PLIST_FULL_NAME];
    NSMutableDictionary *data = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPathOfSand] autorelease];
    return [data objectForKey:PLIST_KEY];
}

+(void) deleteFromPlist:(int)index
{
    NSString *plistPathOfSand = [ConstantUtil createSandTempPath:PLIST_FULL_NAME];
    NSMutableDictionary *data = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPathOfSand] autorelease];
    NSMutableArray *userArray=[[[data objectForKey:PLIST_KEY] mutableCopy] autorelease];
    [userArray removeObjectAtIndex:index];
    [data setObject:userArray forKey:PLIST_KEY];
    [data writeToFile:plistPathOfSand atomically:YES];
}

@end
