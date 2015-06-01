//
//  ModifyPWDViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define MODEFY_PWD_URL [BASE_URL stringByAppendingString:@"modifypwd.aspx"]

@interface ModifyPWDViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UITextField *newpwd;
@property (nonatomic, retain) IBOutlet UITextField *newerpwd;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@end
