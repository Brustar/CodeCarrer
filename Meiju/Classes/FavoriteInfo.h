//
//  FavoriteInfo.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteInfo : NSObject
{
    NSString *goodsId,*goodsName,*mallPrice,*pubTime,*picAddr,*isNew,*isBestSellers,*isRecommend,* isPromot,*popularity;

}
    
@property(nonatomic,retain) NSString *goodsId,*goodsName,*mallPrice,*pubTime,*picAddr,*isNew,*isBestSellers,*isRecommend,*isPromot,*popularity;

@end