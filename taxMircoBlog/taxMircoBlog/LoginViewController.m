//
//  LoginViewController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-11-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"登录";
    self.view.backgroundColor=SYS_BG;
    self.tableView.backgroundView=nil;
	// Do any additional setup after loading the view.
    [self createUI];
    
    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];
}

-(void) createUI
{
    UILabel *forgetPwdLabel=[UIMakerUtil createLabel:@"忘记密码" frame:CGRectMake(245, 100, 60, 20)];
    forgetPwdLabel.font=[UIFont systemFontOfSize:14];
    forgetPwdLabel.textColor=[UIColor grayColor];
    UITapGestureRecognizer *singleTap =
    [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getbackPWDAction:)] autorelease];
    forgetPwdLabel.userInteractionEnabled = YES;
    [forgetPwdLabel addGestureRecognizer:singleTap];
    
    UIButton *regButton=[UIMakerUtil createImageButton:@"注册" image:@"regist" frame:CGRectMake(10, 120, 140, 43)];
    [regButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *loginButton=[UIMakerUtil createImageButton:@"登录" image:@"Registration_Confirm" frame:CGRectMake(170, 120, 140, 43)];
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdLabel];
    [self.view addSubview:regButton];
    [self.view addSubview:loginButton];
}

-(CustomCell *) createCell:(int)row reuseIdentifier:(NSString *)reuseIdentifier
{
    CustomCell *cell=[[[CustomCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:reuseIdentifier] autorelease];
    UIView *loginView=[[[UIView alloc] init] autorelease];
    NSString *rowText=row==0?@"帐号":@"密码";
    UILabel *rowLabel=[UIMakerUtil createLabel:rowText frame:CGRectMake(20, 10, 40, 20)];
    rowLabel.font=[UIFont systemFontOfSize:16];
    
    UITextField *txtInput=[UIMakerUtil createTextField:CGRectMake(70, 10, 200, 30)];
    txtInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtInput.secureTextEntry=row==1;
    txtInput.tag=100+row;           //设定UI识别ID
    [loginView addSubview:txtInput];
    [loginView addSubview:rowLabel];
    if (row==0){
        if ([[PlistUtil arrayFromPlist] count]>0)
            txtInput.text=[[PlistUtil arrayFromPlist] objectAtIndex:0];
        [txtInput becomeFirstResponder];
        if ([[PlistUtil arrayFromPlist] count]>1) {
            UIButton *pulldown=[UIMakerUtil createImageButton:@"pulldown" light:nil frame:CGRectMake(265, 15, 22, 22)];
            [pulldown addTarget:self action:@selector(pulldownAction:) forControlEvents:UIControlEventTouchUpInside];
            [loginView addSubview:pulldown];
        }
    }
    [cell setView:loginView];
    return cell;
}

-(IBAction)pulldownAction:(id)sender
{
    AJComboBox *comboBox = [[AJComboBox alloc] initWithFrame:CGRectMake(70, 50, 230, 31)];
    [comboBox setDelegate:self];
    [comboBox setArrayData:[PlistUtil arrayFromPlist]];
    [comboBox buttonPressed];
    [self.view addSubview:comboBox];
}

-(IBAction)getbackPWDAction:(id)sender
{
    GetbackPWDViewController *view=[[[GetbackPWDViewController alloc] init] autorelease];
    [self.navigationController pushViewController:view animated:YES];
}

-(IBAction)registerAction:(id)sender
{
    RegisterViewController *controller=[[[RegisterViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
    //[UIMakerUtil alert:@"税眼看事免费版体验中，会员版即将上线，敬请期待。" title:self.title];
}

-(IBAction)loginAction:(id)sender
{
    NSString *account=((UITextField *)[self.view viewWithTag:100]).text;
    NSString *pwd=((UITextField *)[self.view viewWithTag:101]).text;
    if (account && pwd) {
        NSString *url=[ConstantUtil createRequestURL:USER_LOGIN_URL];
        ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
        [request addPostValue:account forKey:@"account"];
        [request addPostValue:[Md5Util md5:pwd] forKey:@"userPwd"];
    }else{
        [UIMakerUtil alert:@"请输入用户名和密码" title:self.title];
    }
}

-(void) login:(id) json
{
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"cusId"] forKey:@"cusId"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"email"] forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"nickName"] forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"sex"] forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"phone"] forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"companyName"] forKey:@"companyName"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"profession"] forKey:@"profession"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"position"] forKey:@"position"];
    [[NSUserDefaults standardUserDefaults] setValue:[json valueForKey:@"picHead"] forKey:@"picHead"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SessionUtil sharedInstance].isLogined=YES;
    
    UserInfo *userInformation=[[[UserInfo alloc] init] autorelease];
    userInformation.cusId=[[NSUserDefaults standardUserDefaults] stringForKey:@"cusId"];
    userInformation.email=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    userInformation.nickName=[[NSUserDefaults standardUserDefaults] stringForKey:@"nickName"];
    
    userInformation.sex=[[NSUserDefaults standardUserDefaults] stringForKey:@"sex"];
    userInformation.phone=[[NSUserDefaults standardUserDefaults] stringForKey:@"phone"];
    userInformation.companyName=[[NSUserDefaults standardUserDefaults] stringForKey:@"companyName"];
    userInformation.profession=[[NSUserDefaults standardUserDefaults] stringForKey:@"profession"];
    userInformation.position=[[NSUserDefaults standardUserDefaults] stringForKey:@"position"];
    userInformation.picHeadNum=[[NSUserDefaults standardUserDefaults] stringForKey:@"picHead"];

    [SessionUtil sharedInstance].userInformation=userInformation; 
    
    [self writeCookie:userInformation];
    [PlistUtil writeToPlist:(NSString *)[json valueForKey:@"email"]];
}

-(void) writeCookie :(UserInfo *)userInformation
{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"cusId" forKey:NSHTTPCookieName];
    [cookieProperties setObject:userInformation.cusId forKey:NSHTTPCookieValue];
    [CookieUtil processCookie:cookieProperties];
    
    [cookieProperties setObject:@"email" forKey:NSHTTPCookieName];
    [cookieProperties setObject:userInformation.email forKey:NSHTTPCookieValue];
    [CookieUtil processCookie:cookieProperties];
    
    if (userInformation.nickName) {
        [cookieProperties setObject:@"nickName" forKey:NSHTTPCookieName];
        [cookieProperties setObject:userInformation.nickName forKey:NSHTTPCookieValue];
        [CookieUtil processCookie:cookieProperties];
    }
    
    if (userInformation.sex) {
        [cookieProperties setObject:@"sex" forKey:NSHTTPCookieName];
        [cookieProperties setObject:userInformation.sex forKey:NSHTTPCookieValue];
        [CookieUtil processCookie:cookieProperties];
    }
    if (userInformation.phone) {
        [cookieProperties setObject:@"phone" forKey:NSHTTPCookieName];
        [cookieProperties setObject:userInformation.phone forKey:NSHTTPCookieValue];
        [CookieUtil processCookie:cookieProperties];
    }
    if (userInformation.companyName) {
        [cookieProperties setObject:@"companyName" forKey:NSHTTPCookieName];
        [cookieProperties setObject:userInformation.companyName forKey:NSHTTPCookieValue];
        [CookieUtil processCookie:cookieProperties];
    }
    if (userInformation.profession) {
        [cookieProperties setObject:@"profession" forKey:NSHTTPCookieName];
        [cookieProperties setObject:userInformation.profession forKey:NSHTTPCookieValue];
        [CookieUtil processCookie:cookieProperties];
    }
    if (userInformation.position) {
        [cookieProperties setObject:@"position" forKey:NSHTTPCookieName];
        [cookieProperties setObject:userInformation.position forKey:NSHTTPCookieValue];
        [CookieUtil processCookie:cookieProperties];
    }
    if (userInformation.picHeadNum) {
        [cookieProperties setObject:@"picHead" forKey:NSHTTPCookieName];
        [cookieProperties setObject:userInformation.picHeadNum forKey:NSHTTPCookieValue];
        [CookieUtil processCookie:cookieProperties];
    }
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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell = [self createCell:indexPath.row reuseIdentifier:CellIdentifier];
    return cell;
}

#pragma mark - ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *jsonString = [request responseString];
    id jsonValue = [jsonString JSONValue];
    NSString *code = [jsonValue valueForKey:RETURN_CODE];
    if ([code isEqualToString:@"0"]) {
        [self login:jsonValue];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [UIMakerUtil alert:[jsonValue valueForKey:RETURN_MESSAGE] title:REQUEST_FAIL];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [UIMakerUtil alert:SERVER_ERROR title:[error localizedDescription]];
}

#pragma - mark AJComboBoxDelegate
-(void)didChangeComboBoxValue:(AJComboBox *)comboBox selectedIndex:(NSInteger)selectedIndex
{
    ((UITextField *)[self.view viewWithTag:100]).text=[[PlistUtil arrayFromPlist] objectAtIndex:selectedIndex];
    [[self.view viewWithTag:101] becomeFirstResponder];
}

@end