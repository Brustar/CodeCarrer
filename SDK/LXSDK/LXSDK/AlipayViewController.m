//
//  AlipayViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "AlipayViewController.h"

@implementation AlipayViewController

@synthesize amount;

-(void) viewDidLoad{
    self.txtamount.text=self.amount;
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

-(IBAction)pay:(id)sender{
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *url = [NSURL URLWithString:ALIPAY_ORDOERS_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.amount forKey:@"paymoney"];
    [request setPostValue:[Md5Util md5:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]] forKey:@"merchant_orders"];
    [request setPostValue:@"4" forKey:@"btype"];
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
    [self performSegueWithIdentifier:@"login" sender:self];
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
        [DialogUtil alert:[json objectForKey:@"outmsg"] title:@"乐讯" delegate:self];
        return;
    }
    
    if ([[json objectForKey:@"result"] intValue]==1) {
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[json objectForKey:@"tradeNO"],@"tradeNO",[userDefault objectForKey:@"lexunToken"],@"userid",self.amount,@"price", nil];
        [AlipayRSA callAlipay:dic];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [DialogUtil stopwaiting:self.waiting withUI:self.waitingView];
    NSError *error = [request error];
    NSLog(@"error:%@",error);
}

@end
