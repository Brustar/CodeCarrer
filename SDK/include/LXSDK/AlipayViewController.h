//
//  AlipayViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlipayRSA.h"
#import "ASIFormDataRequest.h"
#import "Md5Util.h"

#define ALIPAY_ORDOERS_URL   @"http://cz.lexun.com/alipayclient/orders.aspx" 

@interface AlipayViewController : UIViewController

@property (nonatomic,retain) NSString *amount;

@property (nonatomic, retain) IBOutlet UILabel *txtamount;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@end
