//
//  Store.m
//  Meiju
//
//  Created by Brustar XRL on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Store.h"

@implementation Store

@synthesize shopId,recomIndex,featDesc,exclSpec,shopNum,shopName,phoneNum,address,picAddr,shopInfo;

-(id) initWithID:(NSString *) storeId withName:(NSString *) storeName
{
    self.shopId=storeId;
    self.shopName=storeName;
    return self;
}

-(id) fetchStoreWithJSON:(NSString *)json
{
    self.exclSpec=[DataSource fetchValueFormDictionary:json forKey:@"exclSpec"];
    NSMutableArray *arr=[[[NSMutableArray alloc] init] autorelease];
    NSDictionary *dic= [[DataSource fetchDictionaryFromURL:json] objectForKey:JSONOBJECT];
    NSArray *array=[dic objectForKey:@"jsonArrayShopInfos"];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if([dic objectForKey:@"infoId"])
		{
			News *news=[[[News alloc] init] autorelease];
            news.newsId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"infoId"]];
            news.content=[dic objectForKey:@"content"];
            news.title=[dic objectForKey:@"title"];
            [arr addObject:news];
		}
	}
    self.shopInfo=[NSArray arrayWithArray:arr];
    
    self.featDesc=[DataSource fetchValueFormDictionary:json forKey:@"featDesc"];
    return self;
}

@end
