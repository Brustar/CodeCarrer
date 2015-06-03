//
//  LoginViewController.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "SessionUtil.h"
#import "DataSource.h"
#import "Md5Util.h"
#import "CookieUtil.h"
#import "PlistUtil.h"
#import "CustomCell.h"
#import "AJComboBox.h"
#import "RegisterViewController.h"
#import "GetbackPWDViewController.h"

#define USER_LOGIN_URL	@"customer_front_userLogin.do"

@interface LoginViewController : UITableViewController<AJComboBoxDelegate>

@end
