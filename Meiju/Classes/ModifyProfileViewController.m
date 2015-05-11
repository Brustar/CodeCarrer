//
//  ModifyProfileController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ModifyProfileViewController.h"

@interface ModifyProfileViewController ()

@end

@implementation ModifyProfileViewController

@synthesize receivedData;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[[NSString alloc] 
                       initWithBytes:[receivedData bytes] 
                       length:[receivedData length] 
                       encoding:NSUTF8StringEncoding] autorelease];
    NSString *retCode=[NSString stringWithFormat:@"%@",[DataSource fetchJSONValueFormServer:json forKey:RETURN_CODE]];
    NSString *message=[DataSource fetchJSONValueFormServer:json forKey:RETURN_MESSAGE];
    if ([retCode isEqualToString:@"1"]) {
        [UIMakerUtil alert:message title:self.title];
        return;
    }
    
    [self updateProfile];
    [UIMakerUtil alertOKCancelAction:message title:self.title delegate:self];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void) updateProfile
{
    NSString *userName=[(UITextField *)[self.view viewWithTag:101] text];
    NSString *telephone=[(UITextField *)[self.view viewWithTag:102] text];
    NSString *email=[(UITextField *)[self.view viewWithTag:103] text];
    SessionUtil *session=[SessionUtil sharedInstance];
    UserInfo *userInfo=session.userInformation;
    userInfo.cusName=userName;
    userInfo.phoneNum=telephone;
    userInfo.email=email;
    [session updateProfile];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)modifyProfileAction:(id)sender
{
    NSString *userName=[(UITextField *)[self.view viewWithTag:101] text];
    NSString *telephone=[(UITextField *)[self.view viewWithTag:102] text];
    NSString *email=[(UITextField *)[self.view viewWithTag:103] text];
    
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:MODIFY_PROFILE_URL];
    UserInfo *userInfo=[SessionUtil sharedInstance].userInformation;
    NSString *param=[NSString stringWithFormat:@"&cusName=%@&phoneNum=%@&email=%@&cusId=%@",userName,telephone,email,userInfo.cusId];
    [DataSource createPostConn:url param:param delegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"修改个人资料";
    CGRect rect=CGRectMake(30, 50, 100, TITLE_HEIGHT);
    UserInfo *userInfo=[SessionUtil sharedInstance].userInformation;
    [self.view addSubview:[UIMakerUtil createLabel:@"姓名:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"联系电话:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"邮箱:" frame:rect]];
    rect.origin.y-=80;
    rect.origin.x+=100;
    rect.size.height=30;
    rect.size.width=160;
    UITextField *userName=[UIMakerUtil createTextField:rect];
    userName.tag=101;
    userName.delegate=self;
    userName.text=userInfo.cusName;
    [self.view addSubview:userName];
    rect.origin.y+=40;
    UITextField *telephone=[UIMakerUtil createTextField:rect];
    telephone.text=userInfo.phoneNum;
    telephone.tag=102;
    telephone.keyboardType=UIKeyboardTypePhonePad;
    telephone.delegate=self;
    [self.view addSubview:telephone];
    rect.origin.y+=40;
    UITextField *email=[UIMakerUtil createTextField:rect];
    email.text=userInfo.email;
    email.tag=103;
    email.keyboardType=UIKeyboardTypeEmailAddress;
    email.delegate=self;
    [self.view addSubview:email];
    
    UIButton *submit=[UIMakerUtil createImageButton:ALERT_OK_TITLE point:CGPointMake(160,200)];
    [submit addTarget:self action:@selector(modifyProfileAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    [super dealloc];
    [receivedData release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//键盘RETURN委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//通用提示框按钮委托
- (void)alertView:(UIAlertView *)view clickedButtonAtIndex:(NSInteger)buttonIndex {   
    // the user clicked one of the OK/Cancel buttons   
    if (buttonIndex == 0){
        //self.tabBarController.selectedIndex=0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
