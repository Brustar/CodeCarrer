//
//  AddressInfo.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfo : NSObject
{
    NSString *recId,*cusId,*recPerName,*recAddr,*zipCode,*phoneNum;
}

@property(nonatomic,retain) NSString *recId,*cusId,*recPerName,*recAddr,*zipCode,*phoneNum;
@end
