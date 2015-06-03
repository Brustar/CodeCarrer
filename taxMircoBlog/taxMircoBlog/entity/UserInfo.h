//
//  UserInfo.h
//  Meiju
//
//  Created by Simon Zhou on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject{
    NSString *cusId;
    NSString *sex;
    NSString *nickName;
    NSString *phone;
    NSString *email;
    NSString *companyName;
    NSString *profession;
    NSString *position;
    NSString *picHeadNum;
    NSString *pwd;
}

@property (nonatomic,retain) NSString *cusId;
@property (nonatomic,retain) NSString *sex;
@property (nonatomic,retain) NSString *nickName;
@property (nonatomic,retain) NSString *phone;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *companyName;
@property (nonatomic,retain) NSString *profession;
@property (nonatomic,retain) NSString *position;
@property (nonatomic,retain) NSString *picHeadNum;
@property (nonatomic,retain) NSString *pwd;

@end
