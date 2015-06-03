//
//  SessionUtil.m
//  Meiju
//
//  Created by Simon Zhou on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SessionUtil.h"

static SessionUtil *shareInstance;

@implementation SessionUtil

@synthesize userInformation,isLogined;
 
+ (SessionUtil *)sharedInstance
{
    if(!shareInstance)
        shareInstance = [[self alloc] init];
    
    return shareInstance;
}

-(void)logout{
    self.userInformation=nil;
    self.isLogined=NO;
    [self updateProfile];
}

-(void) updateProfile
{
    //[[NSUserDefaults standardUserDefaults] ];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.cusId forKey:@"cusId"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.sex forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.nickName forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.position forKey:@"position"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.profession forKey:@"profession"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
