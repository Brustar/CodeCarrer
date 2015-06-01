//
//  MainMenuViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "MainMenuViewController.h"

@implementation MainMenuViewController

-(void) viewDidLoad{
    [DialogUtil showaiting:self.waiting withUI:self.waitingView];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self userinfo];
}

-(void) userinfo
{
    NSURL *url = [NSURL URLWithString:GET_LOGIN_USERINFO_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [request setPostValue:[userDefault objectForKey:@"lexunToken"] forKey:@"token"];
    [request setPostValue:GAME_ID forKey:@"gameid"];
    [request setPostValue:[DialogUtil IMEI] forKey:@"imei"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.2; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"];
    [request setDelegate:self];
    [request startSynchronous];
}

-(IBAction)switchCookie:(id)sender{
    UISwitch *cookie=(UISwitch *)sender;
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    if (!cookie.selected) {
        [userDefault removeObjectForKey:@"lexunToken"];
        [userDefault synchronize];
    }
}

-(IBAction)bind:(id)sender{
    if ([self.bindmobile isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"bindsegue" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"unbindsegue" sender:self];
    }
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"listsegue"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.faceurl forKey:@"faceurl"];
    }
    if([segue.identifier isEqualToString:@"bindsegue"] || [segue.identifier isEqualToString:@"unbindsegue"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.bindmobile forKey:@"bindmobile"];
        [theSegue setValue:self.userid.text forKey:@"userid"];
    }
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
        self.nick.text=[[json objectForKey:@"info"] objectForKey:@"nick"];
        self.userid.text=[NSString stringWithFormat:@"%d",[[[json objectForKey:@"info"] objectForKey:@"userid"] intValue]];
        self.bindmobile=[[json objectForKey:@"info"] objectForKey:@"mobilephone"];
        if ([self.bindmobile isEqualToString:@""])
        {
            self.mobile.text=@"";
        }
        else
        {
            self.mobile.text=[NSString stringWithFormat:@"(%@)",self.bindmobile];
        }
        self.faceurl=[[json objectForKey:@"info"] objectForKey:@"userface"];
        NSURL *imageUrl = [NSURL URLWithString:self.faceurl];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
        self.userface.image=image;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissModalViewControllerAnimated:YES];
}

@end
