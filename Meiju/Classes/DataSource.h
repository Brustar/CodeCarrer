//
//  DataSource.h
//  test
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Advertisement.h"

#define JSONARRAY	@"jsonArray"    //JSON数组字段名
#define JSONOBJECT  @"jsonObject"   //JSON对象字段名

@interface DataSource : NSObject {

}

//从网络取JSON转化为字典对象
+ (NSDictionary *)fetchDictionaryFromURL:(NSString *)address;

//根据key,从网络取JSON转化为OBJC对象
+(id) fetchJSONValueFormServer:(NSString *)address forKey:(NSString *)key;

//根据key,从网络取JSON数组
+(NSArray *)fetchValueFormJsonArray:(NSString *)address forKey:(NSString *)key;
//根据key,从网络取JSON对象
+(NSString *)fetchValueFormJsonObject:(NSString *)address forKey:(NSString *)key;

+(NSString *)fetchValueFormDictionary:(NSString *)address forKey:(NSString *)key;
//同步获取JSON数据
+(NSString *)synValueFormJsonObject:(NSString *)address forKey:(NSString *)key;

+(id)fetchProductsFormJson:(NSString *) url;
+(id)fetchAdsFormJson:(NSString *) url;
+(BOOL) isEmptyJsonArray:(NSString *) json;

//取资源配置文件，键值对
+(id) FetchDataFromSourceFile:(NSString *) key;

//获取连接
+(id) createConn:(NSString *)address delegate:(id) obj;
+(id) createPostConn:(NSString *)address param:(NSString *) param delegate:(id) obj;

@end
