//
//  RegViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/16.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define REG_URL   [BASE_URL stringByAppendingString:@"register.aspx"]

@interface RegViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *phoneNum;
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;

@property (nonatomic) bool isRead;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@end
