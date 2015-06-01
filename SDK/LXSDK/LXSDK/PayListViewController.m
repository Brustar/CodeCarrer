//
//  PayListViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "PayListViewController.h"

@implementation PayListViewController

-(void)viewDidLoad{
    self.payList=[[NSMutableArray alloc] init];
    
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
    
    NSURL *url = [NSURL URLWithString:CLIENT_PAYAPP_LOG_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [request setPostValue:[userDefault objectForKey:@"lexunToken"] forKey:@"token"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

#pragma mark - tableView datasource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.payList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"paycell"];
    Pay *pay = [self.payList objectAtIndex:indexPath.row];
    ((UILabel *)[cell viewWithTag:100]).text = pay.title;
    ((UILabel *)[cell viewWithTag:101]).text = pay.payTime;
    ((UILabel *)[cell viewWithTag:102]).text = pay.amount;
    return cell;
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
    
    if ([[json objectForKey:@"result"] isEqualToString:@"1"]) {
        self.payCount.text=[NSString stringWithFormat:@"充值记录%@条",[json objectForKey:@"total"]];
        NSURL *imageUrl = [NSURL URLWithString:self.faceurl];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.userface.image=image;
        
        //list data
        NSArray *list=[json objectForKey:@"list"];
        for (NSDictionary *dic in list) {
            Pay *pay=[[Pay alloc] init];
            pay.title=[dic objectForKey:@"remark"];
            pay.payTime=[dic objectForKey:@"writetime"];
            pay.amount=[NSString stringWithFormat:@"%d",[[dic objectForKey:@"updatecoin"] intValue]];
            [self.payList addObject:pay];
        }
        self.payCount.text=[NSString stringWithFormat:@"充值记录%lu条",(unsigned long)list.count];
    }
    else
    {
        [DialogUtil alert:[json objectForKey:@"msg"] title:@"乐讯" delegate:self];
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
