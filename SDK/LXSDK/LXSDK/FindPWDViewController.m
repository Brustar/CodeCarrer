//
//  FindPWDViewcontroller.m
//  sdkExample
//
//  Created by lexun05 on 14/12/16.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "FindPWDViewController.h"

@implementation FindPWDViewController

-(IBAction)verify:(id)sender{
    NSString *phoneNum=self.phoneNum.text;
    
    if([phoneNum isEqualToString:@""]){
        [DialogUtil alert:@"请输入手机号" title:@"乐讯"];
        return;
    }
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *regUrl = [NSURL URLWithString:VERYFY_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:regUrl];
    [request setPostValue:@"0" forKey:@"op"];
    [request setPostValue:phoneNum forKey:@"mobile"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
    NSLog(@"%@,%@",phoneNum,[DialogUtil IMEI]);
}

- (IBAction)backgroundTap:(id)sender {
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
        [self verify:nil];
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
    
    if ([@"0" isEqualToString:[json objectForKey:@"errortype"]]) {
        [self performSegueWithIdentifier:@"vierfySugue" sender:self];
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
