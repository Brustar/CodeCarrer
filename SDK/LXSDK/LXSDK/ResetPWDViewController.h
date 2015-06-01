//
//  ResetPWDViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/16.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define RESETPWD_URL   [BASE_URL stringByAppendingString:@"findpassword.aspx"]

@interface ResetPWDViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *verityNum;
@property (nonatomic, retain) IBOutlet UITextField *oldPWD;
@property (nonatomic, retain) IBOutlet UITextField *newerPWD;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, retain) IBOutlet UIButton *btnVerify;

@property (nonatomic) int second;

@end
