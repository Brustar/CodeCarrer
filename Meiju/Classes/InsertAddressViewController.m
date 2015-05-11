//
//  InsertAddressViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InsertAddressViewController.h"

@interface InsertAddressViewController ()

@end

@implementation InsertAddressViewController

@synthesize receivedData,address,isPay,caller;

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
    if (isPay) {
        ((ShopCartViewController *)self.caller).address=self.address;
        [((ShopCartViewController *)self.caller) addOrder];
    }else {
        [UIMakerUtil alertOKCancelAction:message title:self.title delegate:self];
    }
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)insertAction:(id)sender
{
    NSString *userName=[(UITextField *)[self.view viewWithTag:101] text];
    NSString *addr=[(UITextField *)[self.view viewWithTag:102] text];
    NSString *postcode=[(UITextField *)[self.view viewWithTag:103] text];
    NSString *tel=[(UITextField *)[self.view viewWithTag:104] text];
    if (!userName || [[userName trim] isEqualToString:@""]) {
        [UIMakerUtil alert:@"收货人姓名不能为空." title:self.title];
        return;
    }else if (!addr ||[[addr trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"收货人地址不能为空." title:self.title];
        return;
    }else if (!postcode ||[[postcode trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"邮政编码不能为空." title:self.title];
        return;
    }else if (!tel ||[[tel trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"联系电话不能为空." title:self.title];
        return;
    }
    
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:self.address?UPDATE_ADDRESS_URL:INSERT_ADDRESS_URL];
    UserInfo *userInfo=[SessionUtil sharedInstance].userInformation;

    NSString *param=[NSString stringWithFormat:@"&recPerName=%@&recAddr=%@&zipCode=%@&phoneNum=%@&cusId=%@&recId=%@",userName,addr,postcode,tel,userInfo.cusId,self.address.recId];
    [DataSource createPostConn:url param:param delegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title=@"设置收货地址";
    
    UIImageView *backView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)] autorelease];
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTouch = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)] autorelease];
    [backView addGestureRecognizer:singleTouch];
    [self.view addSubview:backView];
    
    CGRect rect=CGRectMake(20, 50, 100, TITLE_HEIGHT);
    [self.view addSubview:[UIMakerUtil createTitleLabel:@"收货人姓名:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createTitleLabel:@"收货人地址:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createTitleLabel:@"邮政编码:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createTitleLabel:@"联系电话:" frame:rect]];
    
    rect.origin.y-=120;
    rect.origin.x+=120;
    rect.size.height=30;
    rect.size.width=160;
    UITextField *userName=[UIMakerUtil createTextField:rect tag:101 delegate:self];
    userName.text=self.address.recPerName;
    [self.view addSubview:userName];
    rect.origin.y+=40;
    UITextField *userAddress=[UIMakerUtil createTextField:rect tag:102 delegate:self];
    userAddress.text=self.address.recAddr;
    [self.view addSubview:userAddress];
    rect.origin.y+=40;
    UITextField *textPostCode=[UIMakerUtil createTextField:rect tag:103 delegate:self];
    textPostCode.text=self.address.zipCode;
    textPostCode.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:textPostCode];

    rect.origin.y+=40;
    UITextField *textTel=[UIMakerUtil createTextField:rect tag:104 delegate:self];
    textTel.text=self.address.phoneNum;
    textTel.keyboardType=UIKeyboardTypePhonePad;
    [self.view addSubview:textTel];
    
    NSString *ok=ALERT_OK_TITLE;
    if (isPay) {
        ok=@"确认并结算";
    }
    UIButton *submit=[UIMakerUtil createImageButton:ok point:CGPointMake(160,rect.origin.y+60)];
    [submit addTarget:self action:@selector(insertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardDidShowNotification 
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note { 
    // create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    doneButton.titleLabel.textColor=[UIColor blackColor];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        if([[keyboard description] hasPrefix:@"<UIPeripheralHost"]){
            if ([[self.view viewWithTag:103] isFirstResponder]) {
                [keyboard addSubview:doneButton];
            }
        }
    }
}

- (void)doneButton:(id)sender {
    [[self.view viewWithTag:103] resignFirstResponder];
    [[self.view viewWithTag:104] becomeFirstResponder];
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
    [address release];
    [caller release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//键盘RETURN委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:[self.view viewWithTag:101]]) {
        [[self.view viewWithTag:102] becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
}

//通用提示框按钮委托
- (void)alertView:(UIAlertView *)view clickedButtonAtIndex:(NSInteger)buttonIndex {   
    // the user clicked one of the OK/Cancel buttons   
    if (buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)dismissKeyboard:(id)sender{
    [[self.view viewWithTag:103] resignFirstResponder];
    [[self.view viewWithTag:104] resignFirstResponder];
}

@end
