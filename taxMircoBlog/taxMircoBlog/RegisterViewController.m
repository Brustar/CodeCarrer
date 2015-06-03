//
//  RegisterViewController.m
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-7.
//
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title=@"注册";
    self.view.backgroundColor=SYS_BG;
    self.tableView.backgroundView=nil;

    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];
    [self createUI];
}

- (void)createUI
{
    UIButton *nextStepButton=[UIMakerUtil createImageButton:@"下一步" image:@"Registration_Confirm" frame:CGRectMake(10, 160, 300, 43)];
    [nextStepButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStepButton];
}

-(IBAction)nextStepAction:(id)sender
{
    NSString *mail=((UITextField *)[self.view viewWithTag:100]).text;
    NSString *pwd=((UITextField *)[self.view viewWithTag:101]).text;
    NSString *rePwd=((UITextField *)[self.view viewWithTag:102]).text;
    if (mail && pwd) {
        if ([pwd length]<6 || [pwd length]>12) {
            [UIMakerUtil alert:@"密码长度必须是6-12位" title:self.title];
            return;
        }
        if (![pwd isEqualToString:rePwd]) {
            [UIMakerUtil alert:@"密码和重复密码不一致" title:self.title];
            return;
        }
        if (![mail isMatchedByRegex:MAIL_REGX]) {
            [UIMakerUtil alert:@"邮箱不合法，请输入合法的邮箱" title:self.title];
            return;
        }
        
        NSString *url=[ConstantUtil createRequestURL:ACCOUNT_CHECK_URL];
        ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
        [request addPostValue:mail forKey:@"account"];
    }else{
        [UIMakerUtil alert:@"请输入密码及帐号" title:self.title];
    }
}

-(CustomCell *) createCell:(int)row reuseIdentifier:(NSString *)reuseIdentifier
{
    CustomCell *cell=[[[CustomCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:reuseIdentifier] autorelease];
    UIView *loginView=[[[UIView alloc] init] autorelease];
    UILabel *rowLabel=[UIMakerUtil createLabel:[REGISTER_TITLES objectAtIndex:row] frame:CGRectMake(20, 10, 80, 20)];
    rowLabel.font=[UIFont systemFontOfSize:16];
    rowLabel.textAlignment=UITextAlignmentRight;
    UITextField *txtInput=[UIMakerUtil createTextField:CGRectMake(110, 10, 170, 30)];
    if (row==0) {
        txtInput.placeholder=@"请输入你的邮箱地址";
    }
    txtInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtInput.secureTextEntry=row>0;
    txtInput.tag=100+row;           //设定UI识别ID
    [loginView addSubview:txtInput];
    [loginView addSubview:rowLabel];
    if (row==0) {
        [txtInput becomeFirstResponder];
    }
    [cell setView:loginView];
    return cell;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
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
        NSString *mail=((UITextField *)[self.view viewWithTag:100]).text;
        NSString *pwd=((UITextField *)[self.view viewWithTag:101]).text;
        ProfileViewController *view=[[[ProfileViewController alloc] init] autorelease];
        UserInfo *info=[[[UserInfo alloc] init] autorelease];
        info.email=mail;
        info.pwd=pwd;
        view.userinfo=info;
        [self.navigationController pushViewController:view animated:YES];
    }else {
        [[self.view viewWithTag:100] becomeFirstResponder];
        [UIMakerUtil alert:[jsonValue valueForKey:RETURN_MESSAGE] title:REQUEST_FAIL];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [UIMakerUtil alert:SERVER_ERROR title:[error localizedDescription]];
}

@end