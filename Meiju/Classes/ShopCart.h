//
//  ShopCart.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ShopCart : NSManagedObject
{

}

@property (nonatomic, retain) NSString * afterSale;
@property (nonatomic, retain) NSString * cartId;
@property (nonatomic, retain) NSNumber *mallPrice;
@property (nonatomic) double marketPrice;
@property (nonatomic, retain) NSString * phase;
@property (nonatomic, retain) NSString * pic;
@property (nonatomic, retain) NSNumber *productAmount;
@property (nonatomic, retain) NSString * productDesc;
@property (nonatomic, retain) NSNumber * productId;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * user;

@end