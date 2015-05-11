//
//  DataSource.m
//  test
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DataSource.h"
#import "ConstantUtil.h"
//#import "JSONKit.h"
#import "JSONKit.h"
#import "HttpContent.h"

@implementation DataSource
+(NSString *)createJson:(NSString *)address
{
	NSString *urlString = [NSString stringWithString:address];
	NSURL *url = [NSURL URLWithString:urlString];
	return [[[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil] autorelease];	
}

+ (NSDictionary *)fetchDictionaryFromURL:(NSString *)string
{
	if(SYNCHRONIZE){
		return [[self createJson:string] objectFromJSONString];
	}
	else {
		return [string objectFromJSONString];
	}
}

+(id) createConn:(NSString *)address delegate:(id) obj
{
    if([ConstantUtil instanceNetOK])
    {
        NSURL *url = [NSURL URLWithString:[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        return [[HttpContent sharedHttpContent] createGetConnection:url delegate:obj];
    }
    return nil;
}

+(id) createPostConn:(NSString *)address param:(NSString *)param delegate:(id) obj
{
	if([ConstantUtil instanceNetOK])
    {
        NSURL *url = [NSURL URLWithString:address];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        return [[HttpContent sharedHttpContent] createPostConnection:url param:[param stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] delegate: obj];
    }
    return nil;
}

+(id) fetchJSONValueFormServer:(NSString *)address forKey:(NSString *)key
{
	return [[self fetchDictionaryFromURL:address] objectForKey :key];
}

+(id)fetchValueFormJsonArray:(NSString *)address forKey:(NSString *)key
{	
	NSDictionary *json= [self fetchDictionaryFromURL:address];
	NSArray *array=[json objectForKey:JSONARRAY];
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if([dic objectForKey:key])
		{
			[retArray addObject:[dic objectForKey:key]];
		}
	}
	return [retArray autorelease];
}

+(NSString *)synValueFormJsonObject:(NSString *)address forKey:(NSString *)key
{
    NSDictionary *json=  [[self createJson:address] objectFromJSONString];
	if([json objectForKey:key])
	{
		return [json objectForKey:key];
	}
	return nil;
}

+(NSString *)fetchValueFormJsonObject:(NSString *)address forKey:(NSString *)key
{	
	NSDictionary *json= [self fetchDictionaryFromURL:address];
	//NSDictionary *dic=[json objectForKey:JSONARRAY];
	if([json objectForKey:key])
	{
		return [json objectForKey:key];
	}
	return nil;
}

+(NSString *)fetchValueFormDictionary:(NSString *)address forKey:(NSString *)key
{	
	
    NSDictionary *json= [self fetchDictionaryFromURL:address];
	NSDictionary *dic=[json objectForKey:JSONOBJECT];
	if([dic objectForKey:key])
	{
		return [dic objectForKey:key];
	}
	return nil;
}

+(id)fetchProductsFormJson:(NSString *) url
{
	NSDictionary *json= [DataSource fetchDictionaryFromURL:url];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
			//initWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *proId=[NSString stringWithFormat:@"%@",[dic objectForKey:PRO_ID]];
			Product *pro=[Product productWithId:proId picURL:[dic objectForKey:PIC_KEY]];
			pro.name=[dic objectForKey:PRO_NAME_KEY];
			[retArray addObject:pro];
		}
	}
	return [retArray autorelease];
}

+(BOOL) isEmptyJsonArray:(NSString *) json
{
    return [[self fetchProductsFormJson:json] count]==0;
}

+(id)fetchAdsFormJson:(NSString *) url
{
	NSDictionary *json= [DataSource fetchDictionaryFromURL:url];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
			//initWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *adId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"adId"]];
			Advertisement *ad=[[Advertisement alloc] init];
			ad.adId=adId;
			ad.adName=[dic objectForKey:@"adName"];
			ad.link=[dic objectForKey:@"link"];
			ad.picAddr=[dic objectForKey:PIC_KEY];
			ad.isShow=[dic objectForKey:@"isShow"];
			[retArray addObject:ad];
			[ad release];
		}
	}
	return [retArray autorelease];
}

#pragma mark not tested yet
+(id) FetchDataFromSourceFile:(NSString *) path
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:path];
    NSData *myData = [[[NSData alloc] initWithContentsOfFile:appFile] autorelease];
	return myData;
}

@end
