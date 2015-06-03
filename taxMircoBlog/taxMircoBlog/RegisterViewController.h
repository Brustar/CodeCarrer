//
//  RegisterViewController.h
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-7.
//
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "CustomCell.h"
#import "RegexKitLite.h"
#import "ProfileViewController.h"

#define REGISTER_TITLES     [NSArray arrayWithObjects:@"帐号",@"密码",@"确认密码", nil]
#define ACCOUNT_CHECK_URL   @"customer_front_validationCustomer.do"

@interface RegisterViewController : UITableViewController

@end
