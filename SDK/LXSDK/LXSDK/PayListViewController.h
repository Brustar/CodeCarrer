//
//  PayListViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pay.h"
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define CLIENT_PAYAPP_LOG_URL [BASE_URL stringByAppendingString:@"paylog.aspx"]

@interface PayListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *payTable;

@property (nonatomic, retain) IBOutlet UILabel *payCount;
@property (nonatomic, retain) IBOutlet UIImageView *userface;

@property (nonatomic, retain) NSMutableArray *payList;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@property(nonatomic,retain) NSString *faceurl;

@end
