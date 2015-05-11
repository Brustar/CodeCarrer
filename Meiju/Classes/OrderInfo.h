//
//  OrderInfo.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject
{
    NSString *orderId,*orderNum,*orderNumber,*totalMoney,*orderDate,*picAddr;
}

@property(nonatomic,retain) NSString *orderId,*orderNum,*orderNumber,*totalMoney,*orderDate,*picAddr;

@end
