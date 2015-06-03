//
//  MyDataSource.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "UIMakerUtil.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface DataSource : NSObject

+ (void)fetchJSON:(NSString *)addr delegate:(id) delegate;

+ (NSDictionary *)fetchJSON:(NSString *)addr;

+ (id)fetchJSONValueForURL:(NSURL *)url;

+ (NSString *)fetchHttpString:(NSURL *)url;

+ (void)fetchHttpString:(NSURL *)url delegate:(id)delegate;

//发送post请求
+(ASIFormDataRequest *)postRequest:(NSString *)addr delegate:(id) delegate;

@end
