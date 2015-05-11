//
//  UserViewController.h
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "TencentOAuth.h"
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "UserRegViewController.h"
#import "ProfileViewController.h"
#import "DataSource.h"
#import "Md5Util.h"
#import "SessionUtil.h"
#import "WBLogInAlertView.h"

#define kWBSDKDemoAppKey    @"2316363066"
#define kWBSDKDemoAppSecret @"f97e9c6dcbaa4fdb702b17fda4ea21fe"
#define USER_LOGIN_URL      @"custmLogin.do"
#define QUERY_OPEN_USER_URL     @"getCusIdFromFront.do"
#define ASSOCIATE_USER_URL   @"addThirdCustomerFromFront.do"

@interface UserViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,WBEngineDelegate,TencentSessionDelegate>
{
    IBOutlet UITextField *textField_Username;
    IBOutlet UITextField *textField_Password;
    id userRegViewController,delegate;
    NSMutableData *receivedData;
    NSURLConnection *loginConn,*queryConn,*regConn,*associateConn;
    TencentOAuth *_tencentOAuth;
    
    WBEngine *weiBoEngine;
}

- (IBAction)buttonPressed_Reg:(id)sender;
- (IBAction)buttonPressed_Login:(id)sender;
- (void)presentModallyOn:(UIViewController *)parent;
- (BOOL)CheckInput;
+(void) loginWithCookie:(NSDictionary *) dic;
+(void) clearCookies;

-(void)tencentDidLogin;

@property (retain,nonatomic) UITextField *textField_Username;
@property (retain,nonatomic) UITextField *textField_Password;
@property (retain,nonatomic) id userRegViewController,delegate;
@property (retain,nonatomic) TencentOAuth* _tencentOAuth;
@property (retain,nonatomic) NSURLConnection *loginConn,*queryConn,*regConn,*associateConn;
@property (retain,nonatomic) WBEngine *weiBoEngine;

@end
