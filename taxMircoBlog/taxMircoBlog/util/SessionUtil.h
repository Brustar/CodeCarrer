//
//  SessionUtil.h
//  Meiju
//
//  Created by Simon Zhou on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface SessionUtil : NSObject{
    BOOL isLogined;
    UserInfo *userInformation;
}

@property (nonatomic) BOOL isLogined;
@property (nonatomic,retain) UserInfo *userInformation;

+ (SessionUtil *)sharedInstance;
- (void)logout;
-(void) updateProfile;

@end
