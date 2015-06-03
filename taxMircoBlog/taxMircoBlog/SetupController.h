//
//  SetupController.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantUtil.h"
#import "SessionUtil.h"
#import "AboutController.h"
#import "CollectionTableViewController.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"

@interface SetupController : UITableViewController
{
    NSArray *titles,*details,*icons;
}

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *details;
@property (strong, nonatomic) NSArray *icons;

@end
