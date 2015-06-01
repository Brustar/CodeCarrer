//
//  UnbindingMobileViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

@interface UnbindingMobileViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,retain) NSString *bindmobile;
@property(nonatomic,retain) NSString *userid;

@property (nonatomic, retain) IBOutlet UILabel *lblbindmobile;
@property (nonatomic, retain) IBOutlet UILabel *lbluserid;

@property (nonatomic, retain) IBOutlet UITextField *verifycode;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, retain) IBOutlet UIButton *btnVerify;

@property (nonatomic) int second;

@end
