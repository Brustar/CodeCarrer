//
//  MainMenuViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DialogUtil.h"
#import "Md5Util.h"

#define GET_LOGIN_USERINFO_URL [BASE_URL stringByAppendingString:@"getlogininfo.aspx"]

@interface MainMenuViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *nick;
@property (nonatomic, retain) IBOutlet UILabel *userid;
@property (nonatomic, retain) IBOutlet UILabel *mobile;
@property (nonatomic, retain) IBOutlet UIImageView *userface;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic, retain) IBOutlet UIView *waitingView;

@property(nonatomic,retain) NSString *faceurl;
@property(nonatomic,retain) NSString *bindmobile;

@end
