//
//  Store.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "News.h"

@interface Store : NSObject
{
    NSString *shopId;
    NSString *recomIndex;
    NSString *featDesc;
    NSString *exclSpec;
    NSString *shopNum;
    NSString *shopName;
    NSString *phoneNum;
    NSString *address;
    NSString *picAddr;
    NSArray  *shopInfo;
}

-(id) initWithID:(NSString *) storeId withName:(NSString *) storeName;
-(id) fetchStoreWithJSON:(NSString *)json;

@property (nonatomic, retain) NSString *shopId,*recomIndex,*featDesc,*exclSpec,*shopNum,*shopName,*phoneNum,*address,*picAddr;
@property (nonatomic, retain) NSArray  *shopInfo;

@end
