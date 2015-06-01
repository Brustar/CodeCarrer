//
//  ModifyPWDViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "ModifyPWDViewController.h"

@implementation ModifyPWDViewController

-(IBAction)modify:(id)sender
{
    NSString *newpwd=self.newpwd.text;
    NSString *newerpwd=self.newerpwd.text;
    NSString *password=self.password.text;
    
    if([password isEqualToString:@""]){
        [DialogUtil alert:@"请输入密码" title:@"乐讯"];
        return;
    }
    
    if([newerpwd isEqualToString:@""]){
        [DialogUtil alert:@"请输入新密码" title:@"乐讯"];
        return;
    }
    
    if (![newerpwd isEqualToString:newpwd]) {
        [DialogUtil alert:@"确认密码输入不一致" title:@"乐讯"];
        return;
    }
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *url = [NSURL URLWithString:MODEFY_PWD_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:password forKey:@"oldpwd"];
    [request setPostValue:newpwd forKey:@"pwd"];
    [request setPostValue:newpwd forKey:@"pwd2"];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [request setPostValue:[userDefault objectForKey:@"lexunToken"] forKey:@"token"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
}

- (IBAction)backgroundTap:(id)sender {
    [self.newerpwd resignFirstResponder];
    [self.password resignFirstResponder];
    [self.newpwd resignFirstResponder];
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

-(IBAction)textFieldDidBeginEditing:(UITextField *)textField{   //开始编辑时，整体上移
    if (textField.tag==10) {
        [self moveView:-60];
    }
    if (textField.tag==11)
    {
        [self moveView:-60];
    }
}
-(IBAction)textFieldDidEndEditing:(UITextField *)textField{     //结束编辑时，整体下移
    if (textField.tag==10) {
        [self moveView:60];
    }
    if (textField.tag==11)
    {
        [self moveView:60];
    }
}
-(void)moveView:(float)move{
    NSTimeInterval animationDuration = 0.90f;
    CGRect frame = self.view.frame;
    frame.origin.y +=move;//view的Y轴上移
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
}


#pragma mark - textfield delegate method 点击return 按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.password]) {
        [self.newpwd becomeFirstResponder];
    }
    
    if ([textField isEqual:self.newpwd]) {
        [self.newerpwd becomeFirstResponder];
    }
    
    if ([textField isEqual:self.newerpwd]) {
        [self modify:nil];
    }
    return YES;
}

#pragma mark - textfield delegate method
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
    if ([@"1" isEqualToString:[json objectForKey:@"result"]]) {
        [DialogUtil alert:@"修改密码成功" title:@"乐讯"];
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
