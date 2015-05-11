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
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.account forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.cusName forKey:@"cusName"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.phoneNum forKey:@"phoneNum"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.score forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] setValue:self.userInformation.grade forKey:@"grade"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
