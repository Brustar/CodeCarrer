//
//  ModifyPwdViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ModifyPwdViewController.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController

@synthesize receivedData;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[[NSString alloc] 
                       initWithBytes:[receivedData bytes] 
                       length:[receivedData length] 
                       encoding:NSUTF8StringEncoding] autorelease];
    NSString *retCode=[NSString stringWithFormat:@"%@",[DataSource fetchJSONValueFormServer:json forKey:RETURN_CODE]];
    NSString *message=[DataSource fetchJSONValueFormServer:json forKey:RETURN_MESSAGE];
    if ([retCode isEqualToString:@"1"]) {
        [UIMakerUtil alert:message title:self.title];
        return;
    }
    
    [UIMakerUtil alertOKCancelAction:message title:self.title delegate:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)modifyPwdAction:(id)sender
{
    NSString *oldPwd=[(UITextField *)[self.view viewWithTag:101] text];
    NSString *newPwd=[(UITextField *)[self.view viewWithTag:102] text];
    NSString *confirmPwd=[(UITextField *)[self.view viewWithTag:103] text];

    if (oldPwd==nil || [oldPwd isEqualToString:@""]) {
        [UIMakerUtil alert:@"旧密码不能为空。" title:self.title];
        return;
    }
    
    if (![newPwd isEqualToString:confirmPwd]) {
        [UIMakerUtil alert:@"新密码和确认密码不一致。" title:self.title];
        return;
    }
    
    if ([newPwd length]>12 || [newPwd length]<4) {
        [UIMakerUtil alert:@"新密码长度应该为(4-12)。" title:self.title];
        return;
    }
    
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:MODIFY_PWD_URL];
    UserInfo *userInfo=[SessionUtil sharedInstance].userInformation;
    NSString *param=[NSString stringWithFormat:@"&newPwd=%@&oldPwd=%@&cusId=%@",[[Md5Util md5:newPwd] uppercaseString],[[Md5Util md5:oldPwd] uppercaseString],userInfo.cusId];
    [DataSource createPostConn:url param:param delegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"密码修改";
    CGRect rect=CGRectMake(50, 50, 100, TITLE_HEIGHT);
    [self.view addSubview:[UIMakerUtil createLabel:@"旧密码:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"新密码:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"确认密码:" frame:rect]];
    rect.origin.y-=80;
    rect.origin.x+=100;
    rect.size.height=30;
    UITextField *oldPwd=[UIMakerUtil createTextField:rect];
    oldPwd.tag=101;
    oldPwd.secureTextEntry=YES;
    oldPwd.delegate=self;
    [self.view addSubview:oldPwd];
    rect.origin.y+=40;
    UITextField *newPwd=[UIMakerUtil createTextField:rect];
    newPwd.tag=102;
    newPwd.secureTextEntry=YES;
    newPwd.delegate=self;
    [self.view addSubview:newPwd];
    rect.origin.y+=40;
    UITextField *ConfirmPwd=[UIMakerUtil createTextField:rect];
    ConfirmPwd.tag=103;
    ConfirmPwd.secureTextEntry=YES;
    ConfirmPwd.delegate=self;
    [self.view addSubview:ConfirmPwd];
    
    UIButton *submit=[UIMakerUtil createImageButton:ALERT_OK_TITLE point:CGPointMake(160,200)];
    [submit addTarget:self action:@selector(modifyPwdAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.title=@"修改密码";
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    [super dealloc];
    [receivedData release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//键盘RETURN委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//通用提示框按钮委托
- (void)alertView:(UIAlertView *)view clickedButtonAtIndex:(NSInteger)buttonIndex {   
    // the user clicked one of the OK/Cancel buttons   
    if (buttonIndex == 0){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
