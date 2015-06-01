//
//  BindMobileViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "BindMobileViewController.h"

@implementation BindMobileViewController

-(void)viewDidLoad
{
    self.lbluserid.text=self.userid;
    self.second=59;
}

- (void)schedule
{
    //每1秒运行一次function方法。
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
}

-(IBAction)countdown:(id)sender
{
    self.second--;
    [self.btnVerify setTitle:[NSString stringWithFormat:@"%d秒后重新获取",self.second] forState:UIControlStateDisabled];
    if (self.second<=0) {
        self.second=59;
        self.btnVerify.enabled=YES;
        [self.timer invalidate];
    }
}

-(IBAction)bind:(id)sender
{
    NSString *mobilenum=self.mobilenum.text;
    NSString *verifycode=self.verifycode.text;
    
    if([mobilenum isEqualToString:@""]){
        [DialogUtil alert:@"请输入手机号" title:@"乐讯"];
        return;
    }
    
    if([verifycode isEqualToString:@""]){
        [DialogUtil alert:@"请输入验证码" title:@"乐讯"];
        return;
    }
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *url = [NSURL URLWithString:BIND_PHONE_NUMBER_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:mobilenum forKey:@"mobile"];
    [request setPostValue:verifycode forKey:@"v"];
    [request setPostValue:@"1" forKey:@"op"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [request setPostValue:[userDefault objectForKey:@"lexunToken"] forKey:@"token"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
}

-(IBAction)recievetext:(id)sender
{
    NSString *mobilenum=self.mobilenum.text;
    
    if([mobilenum isEqualToString:@""]){
        [DialogUtil alert:@"请输入手机号" title:@"乐讯"];
        return;
    }
    
    self.btnVerify.enabled=NO;
    [self schedule];
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *url = [NSURL URLWithString:BIND_PHONE_NUMBER_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:mobilenum forKey:@"mobile"];
    [request setPostValue:@"0" forKey:@"op"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [request setPostValue:[userDefault objectForKey:@"lexunToken"] forKey:@"token"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier:@"bindSuccess" sender:self];
}

- (IBAction)backgroundTap:(id)sender {
    [self.mobilenum resignFirstResponder];
    [self.verifycode resignFirstResponder];
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

#pragma mark textfield delegate method 点击return 按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.mobilenum]) {
        [self recievetext:nil];
    }
    
    if ([textField isEqual:self.verifycode]) {
        [self bind:nil];
    }
    return YES;
}

#pragma mark - textfield delegate method
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [DialogUtil stopwaiting:self.waiting withUI:self.waitingView];
    // 当以文本形式读取返回内容时用这个方法
    NSString *responseString = [request responseString];
    
    NSLog(@"response:%@",responseString);
    NSError *error;
    NSDictionary* json =[NSJSONSerialization
                         JSONObjectWithData:[request responseData]
                         options:kNilOptions
                         error:&error];
    
    if ([[json objectForKey:@"result"] intValue]==1) {
        [DialogUtil alert:[json objectForKey:@"msg"] title:@"乐讯" delegate:self];
    }
    else
    {
        [DialogUtil alert:[json objectForKey:@"msg"] title:@"乐讯"];
        return;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [DialogUtil stopwaiting:self.waiting withUI:self.waitingView];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
}

@end
