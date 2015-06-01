//
//  RegViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/16.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "RegViewController.h"

@implementation RegViewController

-(void) viewDidLoad{
    self.isRead=YES;
}

-(IBAction)reg:(id)sender{
    NSString *phoneNum=self.phoneNum.text;
    NSString *username=self.username.text;
    NSString *password=self.password.text;
    
    if([phoneNum isEqualToString:@""]){
        [DialogUtil alert:@"请输入手机号" title:@"乐讯"];
        return;
    }
    
    if([username isEqualToString:@""]){
        [DialogUtil alert:@"请输入帐号" title:@"乐讯"];
        return;
    }
    
    if([password isEqualToString:@""]){
        [DialogUtil alert:@"请输入密码" title:@"乐讯"];
        return;
    }
    
    if (!self.isRead) {
        [DialogUtil alert:@"请阅读用户服务协议" title:@"乐讯"];
        return;
    }
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *regUrl = [NSURL URLWithString:REG_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:regUrl];
    [request setPostValue:phoneNum forKey:@"phone"];
    [request setPostValue:username forKey:@"nick"];
    [request setPostValue:[Md5Util md5:password] forKey:@"pwd"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
    NSLog(@"%@,%@,%@,%@",username,password,[Md5Util md5:password],[DialogUtil IMEI]);
    
}

-(IBAction)showPassword:(id)sender{
    ((UIButton *)sender).selected=!((UIButton *)sender).selected;
    self.password.secureTextEntry=((UIButton *)sender).selected;
}

-(IBAction)readProtocol:(id)sender{
    ((UIButton *)sender).selected=!((UIButton *)sender).selected;
    self.isRead=!((UIButton *)sender).selected;
}

- (IBAction)backgroundTap:(id)sender {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.phoneNum resignFirstResponder];
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

#pragma mark textfield delegate method 点击return 按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.phoneNum]) {
        [self.username becomeFirstResponder];
    }
    
    if ([textField isEqual:self.username]) {
        [self.password becomeFirstResponder];
    }
    
    if ([textField isEqual:self.password]) {
        [self reg:nil];
    }
    return YES;
}

#pragma mark textfield delegate method
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [DialogUtil stopwaiting:self.waiting withUI:self.waitingView];
    // 当以文本形式读取返回内容时用这个方法
    NSString *responseString = [request responseString];
    
    NSLog(@"responseString:%@",responseString);
    NSError *error;
    NSDictionary* json =[NSJSONSerialization
                         JSONObjectWithData:[request responseData]
                         options:kNilOptions
                         error:&error];
    if ([@"0" isEqualToString:[json objectForKey:@"result"]]) {
        [DialogUtil alert:[json objectForKey:@"msg"] title:@"乐讯"];
        return;
    }
    
    if ([@"1" isEqualToString:[json objectForKey:@"result"]]) {

    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [DialogUtil stopwaiting:self.waiting withUI:self.waitingView];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
}

@end
