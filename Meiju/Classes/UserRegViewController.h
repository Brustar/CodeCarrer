//
//  UserRegViewController.h
//  Meiju
//
//  Created by Simon Zhou on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "Md5Util.h"
#import "SessionUtil.h"

@interface UserRegViewController : UIViewController<UITextFieldDelegate>{
    UITextField *textField_Account;
    UITextField *textField_Name;
    UITextField *textField_Password;
    UITextField *textField_Confirm;
    UITextField *textField_Phone;
    UITextField *textField_Email;

    id delegate;
    NSMutableData *receivedData;
}

-(IBAction)buttonPressed:(id)sender;
- (void)presentModallyOn:(UIViewController *)parent;

@property(retain,nonatomic)UITextField *textField_Account;
@property(retain,nonatomic)UITextField *textField_Name;
@property(retain,nonatomic)UITextField *textField_Password;
@property(retain,nonatomic)UITextField *textField_Confirm;
@property(retain,nonatomic)UITextField *textField_Phone;
@property(retain,nonatomic)UITextField *textField_Email;
@property (nonatomic, retain) NSMutableData *receivedData;

@property (retain,nonatomic) id delegate;

@end
