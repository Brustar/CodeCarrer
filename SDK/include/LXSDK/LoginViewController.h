//
//  LoginViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/15.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define LOGIN_URL   [BASE_URL stringByAppendingString:@"login.aspx"]

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@end