//
//  ResetPWDViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/16.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "ResetPWDViewController.h"

@implementation ResetPWDViewController

-(void) viewDidLoad
{
    self.second=59;
    [self schedule];
}

-(IBAction)resetPWD:(id)sender
{
    [self.timer invalidate];
    NSString *verityNum=self.verityNum.text;
    NSString *oldPWD=self.oldPWD.text;
    NSString *newerPWD=self.newerPWD.text;
    
    if([verityNum isEqualToString:@""]){
        [DialogUtil alert:@"请输入验证号" title:@"乐讯"];
        return;
    }
    
    if([oldPWD isEqualToString:@""]){
        [DialogUtil alert:@"请输入密码" title:@"乐讯"];
        return;
    }
    
    if([newerPWD isEqualToString:@""]){
        [DialogUtil alert:@"请重复输入密码" title:@"乐讯"];
        return;
    }
    
    if(![newerPWD isEqualToString:oldPWD]){
        [DialogUtil alert:@"重复密码有误" title:@"乐讯"];
        return;
    }
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *regUrl = [NSURL URLWithString:RESETPWD_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:regUrl];
    [request setPostValue:@"1" forKey:@"op"];
    [request setPostValue:verityNum forKey:@"v"];
    [request setPostValue:oldPWD forKey:@"p"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
    NSLog(@"%@,%@,%@,%@",verityNum,oldPWD,[Md5Util md5:oldPWD],[DialogUtil IMEI]);
}

- (void)schedule
{
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

- (IBAction)backgroundTap:(id)sender {
    [self.verityNum resignFirstResponder];
    [self.oldPWD resignFirstResponder];
    [self.newerPWD resignFirstResponder];
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

#pragma mark textfield delegate method 点击return 按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.verityNum]) {
        [self.verityNum becomeFirstResponder];
    }
    
    if ([textField isEqual:self.oldPWD]) {
        [self.newerPWD becomeFirstResponder];
    }
    
    if ([textField isEqual:self.newerPWD]) {
        [self resetPWD:nil];
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier:@"login" sender:self];
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
    
    if ([@"0" isEqualToString:[json objectForKey:@"errortype"]]) {
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
