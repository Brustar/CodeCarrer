//
//  JcardViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define JCARDPAY_URL   [CARD_CHANGE_URL stringByAppendingString:@"clientpayapp.aspx"]

@interface JcardViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,retain) NSString *amount;

@property (nonatomic, retain) IBOutlet UITextField *cardNum;
@property (nonatomic, retain) IBOutlet UITextField *password;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@end
