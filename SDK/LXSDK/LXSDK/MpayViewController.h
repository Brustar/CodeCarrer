//
//  MpayViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define PICKERDATAS [[NSArray alloc]initWithObjects:@"移动充值卡",@"联通充值卡",@"电信充值卡", nil]
#define MPAY_URL   [CARD_CHANGE_URL stringByAppendingString:@"clientpayapp.aspx"]

@interface MpayViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (nonatomic,retain) NSString *amount;
@property (nonatomic, retain) IBOutlet UILabel *txtamount;

@property (nonatomic, retain) IBOutlet UIButton *card;
@property (nonatomic, retain) IBOutlet UIView *cardView;

@property (nonatomic, retain) IBOutlet UITextField *cardNum;
@property (nonatomic, retain) IBOutlet UITextField *password;

@property (nonatomic) int cardtype;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@end
