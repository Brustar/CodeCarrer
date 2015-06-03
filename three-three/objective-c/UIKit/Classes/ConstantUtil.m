//
//  ConstantUtil.m
//  Meiju
//
//  Created by brustar on 12-4-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ConstantUtil.h"

@implementation ConstantUtil

static BOOL isNetOK;

+(BOOL)instanceNetOK
{  
    return isNetOK;  
}

+(void) isNetOK:(BOOL) ok
{
    isNetOK=ok;
}

+(NSString *) createBaseRequestURL:(NSString *)url
{
	return [[[NSString alloc] initWithFormat:@"%@:%d%@%@",APP_HOST,HOST_PORT,APP_HOST_PATH,url] autorelease];
}

+(NSString *) createRequestURL:(NSString *)url
{
	NSString *param=[[[NSString alloc] initWithFormat:@"?mcId=%@&version=%@",APP_OS,[self fetchValueFromPlistFile:VERSION_KEY]] autorelease];
	return [[self createBaseRequestURL:url] stringByAppendingString: param];
}

+(NSString *) createRequestURL:(NSString *)url withParam:(NSString *)param
{
	return [[self createRequestURL:url] stringByAppendingFormat:@"&%@",param];
}

+(NSString *) parseDate:(NSString *)date
{
    NSTimeInterval sec=[date doubleValue]/1000;
    NSDate *cal=[NSDate dateWithTimeIntervalSince1970:sec];
    //NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //NSInteger interval = [zone secondsFromGMTForDate: cal];
    //NSDate *localeDate = [cal  dateByAddingTimeInterval: interval];  
    NSDateFormatter *formatter=[[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate: cal];
}

+(NSString *) createPreviewImagePath
{
    return [self createImagePath:@"view.png"];
}

+(NSString *) createImagePath:(NSString *) fileName
{
    NSString *temp=NSTemporaryDirectory();
    return [temp stringByAppendingPathComponent:fileName];
}

+(NSString *) createParam:(NSString *)param
{
	return [[[NSString alloc] initWithFormat:@"mcId=%@&version=%@&%@",APP_OS,[self fetchValueFromPlistFile:VERSION_KEY],param] autorelease];
}

+(UIColor *) initSystemBackground
{
	return [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
}

+ (NSDate *) dateFromString: (NSString *) aString
{
	// Return a date from a string
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	formatter.dateFormat = @"MM-dd-yyyy";
	NSDate *date = [formatter dateFromString:aString];
	return date;
}

#pragma mark not tested yet
+(NSString *) fetchValueFromPlistFile:(NSString *)key
{
	return [[NSBundle mainBundle]objectForInfoDictionaryKey:key];
}
@end
