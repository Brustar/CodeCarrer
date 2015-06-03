//
//  ConstantUtil.m
//  Meiju
//
//  Created by brustar on 12-4-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ConstantUtil.h"

@implementation ConstantUtil

+(NSString *) createBaseRequestURL:(NSString *)url
{
	return [[[NSString alloc] initWithFormat:@"%@:%d%@/%@",APP_HOST,HOST_PORT,APP_HOST_PATH,url] autorelease];
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
    return [self createSandTempPath:CACHE_IMAGE];
}

+(NSString *) createSandTempPath:(NSString *) fileName
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

#pragma mark from plist.info 
+(NSString *) fetchValueFromPlistFile:(NSString *)key
{
	return [[NSBundle mainBundle]objectForInfoDictionaryKey:key];
}

+ (NSString *)createShortUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    CFUUIDBytes bytes = CFUUIDGetUUIDBytes(uuidObject);
    NSString *retStr=[NSString stringWithFormat:@"%X%X%X%X%X%X",bytes.byte10,bytes.byte11,bytes.byte12,bytes.byte13,bytes.byte14,bytes.byte15];
    CFRelease(uuidObject);
    
    return retStr;
}

+ (NSString *)createUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    // Get the string representation of CFUUID object.
    NSString *uuidStr = [(NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject) autorelease];

    CFRelease(uuidObject);
    
    return uuidStr;
}

+(BOOL) isNumbric:(NSString *) text
{
    int digit=0,num=0;
    while (num<text.length) {
        char c=[text characterAtIndex:num];
        if(c>='0' && c<='9')
        {
            digit++;
        }
        num++;
    }
    return  digit==num;
}

+(int)parseToInt:(NSString *)string
{
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    NSNumber *number = [numberFormatter numberFromString:string];
    return [number intValue];
}

+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha  
{  
    CGFloat r = (CGFloat) red/255.0;  
    CGFloat g = (CGFloat) green/255.0;  
    CGFloat b = (CGFloat) blue/255.0;  
    CGFloat a = (CGFloat) alpha/255.0;    
    CGFloat components[4] = {r,g,b,a};  
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();  
    
    CGColorRef color = (CGColorRef)[(id)CGColorCreate(colorSpace, components) autorelease];  
    CGColorSpaceRelease(colorSpace);  
    
    return color;  
}

@end
