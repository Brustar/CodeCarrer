//
//  MyMeijuViewController.h
//  Meiju
//
//  Created by Simon Zhou on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionUtil.h"
#import "UIMakerUtil.h"
#import "UserViewController.h"
#import "OrderViewController.h"
#import "EditProfileViewController.h"
#import "FavoritesViewController.h"
#import "AddressViewController.h"
#import "UserDelegate.h"

#define ORDER_STATUE_URL    @"/getOrderStatusCountByCusId.do"

@interface ProfileViewController : UIViewController<UserDelegate>
{
    NSMutableData *receivedData;
    NSArray *retArray;
    UserInfo *userInfo;
    UILabel *userName,*telephone,*mail;
}

@property(nonatomic,retain) NSArray *retArray;

-(void) createTableView;
- (void)presentModally;

@end
