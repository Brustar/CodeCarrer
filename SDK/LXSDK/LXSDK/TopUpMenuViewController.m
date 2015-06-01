//
//  TopUpMenuViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "TopUpMenuViewController.h"

@implementation TopUpMenuViewController

-(IBAction) quickPay:(id)sender{
    [DialogUtil alert:@"暂未开通" title:@"乐讯"];
}

-(IBAction) unionPay:(id)sender{
    [DialogUtil alert:@"暂未开通" title:@"乐讯"];
}

-(IBAction) ebankPay:(id)sender{
    [DialogUtil alert:@"暂未开通" title:@"乐讯"];
}

-(IBAction) showAmount:(id)sender{
    self.amountView.hidden=!self.amountView.hidden;
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(![segue.identifier isEqualToString:@"index"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.amount.text forKey:@"amount"];
    }
}

- (IBAction)backgroundTap:(id)sender {
    [self.amount resignFirstResponder];
}

#pragma mark - textfield delegate method 点击return 按钮隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Picker Date Source Methods
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [PICKERDATA count];
}

#pragma mark Picker Delegate Methods
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [PICKERDATA objectAtIndex:row];
}

-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    self.amountView.hidden=YES;
    self.amount.text=[PICKERDATA objectAtIndex:row];
}

@end
