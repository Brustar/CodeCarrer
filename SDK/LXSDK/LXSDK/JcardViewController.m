//
//  JcardViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "JcardViewController.h"

@implementation JcardViewController

@synthesize amount;

-(IBAction)pay:(id)sender{
    NSString *cardNum=self.cardNum.text;
    NSString *password=self.password.text;
    
    if([cardNum isEqualToString:@""]){
        [DialogUtil alert:@"请输入卡号" title:@"乐讯"];
        return;
    }
    
    if([password isEqualToString:@""]){
        [DialogUtil alert:@"请输入密码" title:@"乐讯"];
        return;
    }
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *regUrl = [NSURL URLWithString:CARD_CHANGE_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:regUrl];
    [request setPostValue:@"2" forKey:@"paytypeid"];
    [request setPostValue:cardNum forKey:@"pa7_cardNo"];
    [request setPostValue:password forKey:@"pa8_cardPwd"];
    [request setPostValue:amount forKey:@"p3_Amt"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [request setPostValue:[userDefault objectForKey:@"lexunToken"] forKey:@"token"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
    NSLog(@"%@,%@,%@,%@",cardNum,password,[Md5Util md5:password],[DialogUtil IMEI]);
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

- (IBAction)backgroundTap:(id)sender {
    [self.cardNum resignFirstResponder];
    [self.password resignFirstResponder];
}

#pragma mark - textfield delegate method 点击return 按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.cardNum]) {
        [self.password becomeFirstResponder];
    }
    
    if ([textField isEqual:self.password]) {
        [self pay:nil];
    }
    return YES;
}

#pragma mark- textfield delegate method
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
    if ([[json objectForKey:@"result"] intValue]==0) {
        [DialogUtil alert:[json objectForKey:@"msg"] title:@"乐讯"];
        return;
    }
    
    if ([[json objectForKey:@"result"] intValue]==1) {
        [self performSegueWithIdentifier:@"success" sender:self];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [DialogUtil stopwaiting:self.waiting withUI:self.waitingView];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
}

@end
