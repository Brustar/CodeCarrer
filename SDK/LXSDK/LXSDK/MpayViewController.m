//
//  MpayViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "MpayViewController.h"

@implementation MpayViewController

@synthesize amount;

-(void) viewDidLoad{
    self.txtamount.text=amount;
    self.cardtype=-1;
}

-(IBAction) showCards:(id)sender{
    self.cardView.hidden=!self.cardView.hidden;
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

-(NSString *)payTypeid{
    switch (self.cardtype) {
        case 0:
            return @"1";
        case 1:
            return @"4";
        case 2:
            return @"3";
        default:
            return @"";
    }
}

-(IBAction)pay:(id)sender{
    NSString *cardNum=self.cardNum.text;
    NSString *password=self.password.text;
    
    if (self.cardtype==-1) {
        [DialogUtil alert:@"请选择充值卡类型" title:@"乐讯"];
        return;
    }
    
    if([cardNum isEqualToString:@""]){
        [DialogUtil alert:@"请输入卡号" title:@"乐讯"];
        return;
    }
    
    if([password isEqualToString:@""]){
        [DialogUtil alert:@"请输入密码" title:@"乐讯"];
        return;
    }
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *regUrl = [NSURL URLWithString:MPAY_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:regUrl];
    [request setPostValue:[self payTypeid] forKey:@"paytypeid"];
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

- (IBAction)backgroundTap:(id)sender {
    [self.cardNum resignFirstResponder];
    [self.password resignFirstResponder];
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
    if ([textField isEqual:self.cardNum]) {
        [self.password becomeFirstResponder];
    }
    
    if ([textField isEqual:self.password]) {
        [self pay:nil];
    }
    return YES;
}

#pragma mark -
#pragma mark Picker Date Source Methods
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [PICKERDATAS count];
}

#pragma mark Picker Delegate Methods
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [PICKERDATAS objectAtIndex:row];
}

-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    self.cardView.hidden=YES;
    self.card.titleLabel.text=[PICKERDATAS objectAtIndex:row];
    self.cardtype=(int)row;
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
