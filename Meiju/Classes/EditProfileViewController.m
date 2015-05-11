//
//  EditProfileViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)modifyPwd:(id)sender
{
    ModifyPwdViewController *view=[[[ModifyPwdViewController alloc] init] autorelease];
    [self.navigationController pushViewController:view animated:YES];
}

-(IBAction)modifyProfile:(id)sender
{
    ModifyProfileViewController *view=[[[ModifyProfileViewController alloc] init] autorelease];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人资料";
    self.view.backgroundColor=SYS_BG;
    
	UserInfo *userInfo=[SessionUtil sharedInstance].userInformation;
    CGRect rect=CGRectMake(50, 10, 120, TITLE_HEIGHT);
    [self.view addSubview:[UIMakerUtil createLabel:@"帐号:" frame:rect]];
    rect.origin.x=160;
    [self.view addSubview:[UIMakerUtil createLabel:userInfo.account frame:rect]];
    
    rect.origin.y+=TITLE_HEIGHT+10;
    [self.view addSubview:[UIMakerUtil createLabel:userInfo.cusName frame:rect]];
    rect.origin.x=50;
    [self.view addSubview:[UIMakerUtil createLabel:@"姓名:" frame:rect]];
    
    rect.origin.y+=TITLE_HEIGHT+10;
    [self.view addSubview:[UIMakerUtil createLabel:@"联系电话:" frame:rect]];
    rect.origin.x=160;
    [self.view addSubview:[UIMakerUtil createLabel:userInfo.phoneNum frame:rect]];
    
    rect.origin.y+=TITLE_HEIGHT+10;
    [self.view addSubview:[UIMakerUtil createLabel:userInfo.email frame:rect]];
    rect.origin.x=50;
    [self.view addSubview:[UIMakerUtil createLabel:@"邮箱:" frame:rect]]; 
    
    UIButton *pwdButton=[UIMakerUtil createImageButton:@"修改密码" point:CGPointMake(80,150)];
    [pwdButton addTarget:self action:@selector(modifyPwd:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *profileButton=[UIMakerUtil createImageButton:@"修改资料" point:CGPointMake(230,150)];
    [profileButton addTarget:self action:@selector(modifyProfile:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pwdButton];
    [self.view addSubview:profileButton];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
