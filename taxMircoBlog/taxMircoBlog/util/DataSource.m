//
//  MyDataSource.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

//异步取JSON,在委托中处理JSON信息及报错
+ (void)fetchJSON:(NSString *)addr delegate:(id) delegate
{
    NSURL *url = [NSURL URLWithString:addr];
    [self fetchHttpString:url delegate:delegate];
}

+ (void)fetchHttpString:(NSURL *)url delegate:(id)delegate
{
    if ([UIMakerUtil connectedToNetwork]) {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:delegate];
        [request startSynchronous];
        [request setResponseEncoding:NSUTF8StringEncoding];
    }
}

//同步取JSON
+ (NSDictionary *)fetchJSON:(NSString *)addr
{
    NSURL *url = [NSURL URLWithString:addr];
    NSLog(@"fetching library data");
    return [self fetchJSONValueForURL:url];
}

+ (id)fetchJSONValueForURL:(NSURL *)url
{
    NSString *jsonString = [self fetchHttpString:url];
    id jsonValue = [jsonString JSONValue];
    return jsonValue;
}

+ (NSString *)fetchHttpString:(NSURL *)url
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [request setResponseEncoding:NSUTF8StringEncoding];
        return [request responseString];
    }
    return NULL;
}
 
//发送post请求
+(ASIFormDataRequest *)postRequest:(NSString *)addr delegate:(id) delegate
{
    NSURL *url = [NSURL URLWithString:addr];
    ASIFormDataRequest *request=[[[ASIFormDataRequest alloc]initWithURL:url] autorelease];
    [request setDelegate:delegate];
    [request setResponseEncoding:NSUTF8StringEncoding];
    //[request addPostValue:@"" forKey:@"username"];
    //[request addPostValue:@"" forKey:@"realname"];
    //[request addPostValue:@"" forKey:@"email"];
    //[request setFile:@"/user/1.png" forKey:@"file"];   //可以上传图片
    [request startAsynchronous];
    return request;
}

@end
