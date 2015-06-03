//
//  GetbackPWDViewController.m
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-8.
//
//

#import "GetbackPWDViewController.h"

@interface GetbackPWDViewController ()

@end

@implementation GetbackPWDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title=@"找回密码";
    self.view.backgroundColor=SYS_BG;

    self.navigationItem.rightBarButtonItem =[UIMakerUtil createBarButtonItem:@"countersign" andTarget:self andSelector:@selector(send:)];
    [self createUI];
}

-(IBAction)send:(id)sender
{
    if (sender) {
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
    
    NSString *mail=((UITextField *)[self.view viewWithTag:101]).text;
    if (![mail isMatchedByRegex:MAIL_REGX]) {
        [UIMakerUtil alert:@"邮箱不合法，请输入合法的邮箱" title:self.title];
        return;
    }
    NSString *url=[ConstantUtil createRequestURL:GETBACK_PWD_URL];
    ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
    [request addPostValue:mail forKey:@"account"];
}

-(void) createUI
{
    UIView *view=[UIMakerUtil createRoundedRectView:CGRectMake(10, 20, 300, 40)];
    UITextField *mailTxt=[UIMakerUtil createTextField:CGRectMake(10, 10, 300, 20)];
    mailTxt.font=[UIFont systemFontOfSize:14];
    mailTxt.tag=101;
    mailTxt.placeholder=@"请输入和税眼看事帐号相同的邮箱地址";
    mailTxt.delegate=self;
    mailTxt.returnKeyType=UIReturnKeySend;
    [view addSubview:mailTxt];
    [mailTxt becomeFirstResponder];
    [self.view addSubview:view];
}

#pragma mark - ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *jsonString = [request responseString];
    id jsonValue = [jsonString JSONValue];
    NSString *code = [jsonValue valueForKey:RETURN_CODE];
    if ([code isEqualToString:@"0"]) {
        [UIMakerUtil alert:[NSString stringWithFormat:@"密码信息已经发送到邮箱：%@，请查收",[jsonValue valueForKey:@"email"]] title:[jsonValue valueForKey:RETURN_MESSAGE] delegate:self];
    }else {
        [UIMakerUtil alert:[jsonValue valueForKey:RETURN_MESSAGE] title:REQUEST_FAIL];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [UIMakerUtil alert:SERVER_ERROR title:[error localizedDescription]];
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark- KeyboardDelegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self send:nil];
    return YES;
}

@end