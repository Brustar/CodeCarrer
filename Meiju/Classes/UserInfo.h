//
//  UserInfo.h
//  Meiju
//
//  Created by Simon Zhou on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TencentOAuth.h"
#import "WBEngine.h"

#define ORDER_URL   @"/orderListByCusId.do"

@interface UserInfo : NSObject{
    NSString *cusId;
    NSString *account;
    NSString *cusName;
    NSString *phoneNum;
    NSString *email;
    NSString *score;
    NSString *grade;
    TencentOAuth *tencentAuth;
    WBEngine *weiboAuth;
}

@property (nonatomic,retain) NSString *cusId;
@property (nonatomic,retain) NSString *account;
@property (nonatomic,retain) NSString *cusName;
@property (nonatomic,retain) NSString *phoneNum;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *score;
@property (nonatomic,retain) NSString *grade;
@property (nonatomic,retain) TencentOAuth *tencentAuth;
@property (nonatomic,retain) WBEngine *weiboAuth;

@end
