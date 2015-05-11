//
//  UserRegViewController.m
//  Meiju
//
//  Created by Simon Zhou on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserRegViewController.h"

@interface UserRegViewController ()

@end

@implementation UserRegViewController

@synthesize textField_Account;
@synthesize textField_Name;
@synthesize textField_Password;
@synthesize textField_Confirm;
@synthesize textField_Phone;
@synthesize textField_Email;

@synthesize receivedData,delegate;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
    //	self.productData=[self.productData fetchWithProduct:json];
    //	[self createUI];
    NSString *result= (NSString *)[DataSource fetchValueFormJsonObject:json forKey:RETURN_CODE];
    if([result isEqualToString:@"0"]){
        //注册成功,保存持久化信息
        [UIMakerUtil alert:[DataSource fetchValueFormJsonObject:json forKey:RETURN_MESSAGE] title:self.title];
        if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(forward:)] )
        {
            [self.delegate forward:self];
        }
    }else {
        //登录失败
        [UIMakerUtil alert:[DataSource fetchValueFormJsonObject:json forKey:RETURN_MESSAGE] title:self.title];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"注册";
    self.view.backgroundColor=SYS_BG;
    self.navigationController.navigationBar.tintColor=ORANGE_BG;
    
    UIImageView *backView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)] autorelease];
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTouch = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)] autorelease];
    [backView addGestureRecognizer:singleTouch];
    [self.view addSubview:backView];
    
    // Do any additional setup after loading the view from its nib.
    CGRect rect=CGRectMake(120 , 15, 150 , 30);
    self.textField_Account=[UIMakerUtil createTextField:rect delegate:self returnKey:UIReturnKeyNext];
    [self.view addSubview:self.textField_Account];
    
    rect.origin.y+=40;
    self.textField_Name=[UIMakerUtil createTextField:rect delegate:self returnKey:UIReturnKeyNext];
    [self.view addSubview:self.textField_Name];
    
    rect.origin.y+=40;
    self.textField_Password=[UIMakerUtil createTextField:rect delegate:self returnKey:UIReturnKeyNext];
    [self.view addSubview:self.textField_Password];
    
    rect.origin.y+=40;
    self.textField_Confirm=[UIMakerUtil createTextField:rect delegate:self returnKey:UIReturnKeyNext];
    [self.view addSubview:self.textField_Confirm];
    
    rect.origin.y+=40;
    self.textField_Phone=[UIMakerUtil createTextField:rect delegate:self];
    [self.view addSubview:self.textField_Phone];
    
    rect.origin.y+=40;
    self.textField_Email=[UIMakerUtil createTextField:rect delegate:self returnKey:UIReturnKeyDone];
    [self.view addSubview:self.textField_Email];
    
    rect=CGRectMake(30 , 15, 80 , 30);
    [self.view addSubview:[UIMakerUtil createLabel:@"帐号:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"姓名:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"密码:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"确认密码:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"联系电话:" frame:rect]];
    rect.origin.y+=40;
    [self.view addSubview:[UIMakerUtil createLabel:@"邮箱:" frame:rect]];
    
    textField_Password.secureTextEntry=YES;
    textField_Confirm.secureTextEntry=YES;
    self.textField_Phone.keyboardType=UIKeyboardTypePhonePad;
    self.textField_Email.keyboardType=UIKeyboardTypeEmailAddress;
    UIButton *regButton=[UIMakerUtil createImageButton:ALERT_OK_TITLE point:CGPointMake(160,290)];
    [regButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

-(void) dealloc
{
    [super dealloc];
    [textField_Account release];
    [textField_Name release];
    [textField_Password release];
    [textField_Confirm release];
    [textField_Phone release];
    [textField_Email release];
    [delegate release];
    //[receivedData release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)CheckInput{
    
    if( [[textField_Account.text trim] isEqualToString:@""] ){
        [UIMakerUtil alert:@"请输入账号。" title:self.title];
        return NO;
    }
    
    if( [[textField_Name.text trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"请输入姓名。" title:self.title];
        return NO;
    }
    
    if( [[textField_Password.text trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"请输入密码。" title:self.title];
        return NO;
    }
    
    if( [[textField_Confirm.text trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"请输入确认密码。" title:self.title];
        return NO;
    }
    
    if ([textField_Password.text length]>12 || [textField_Password.text length]<4) {
        [UIMakerUtil alert:@"新密码长度应该为(4-12)。" title:self.title];
        return NO;
    }
    
    if( [[textField_Phone.text trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"请输入联系电话。" title:self.title];
        return NO;
    }
    
    if( [[textField_Email.text trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"请输入邮箱。" title:self.title];
        return NO;
    }
    
    return YES;
}

-(IBAction)buttonPressed:(id)sender{
    //验证用户输入信息
    if(![self CheckInput]){
        return;
    }
    
    //访问用户登录接口(委托方式)
    NSString *param=[[NSString alloc] initWithFormat:@"cusName=%@&account=%@&phoneNum=%@&cusPwd=%@&email=%@",textField_Name.text,textField_Account.text,textField_Phone.text,[[Md5Util md5:textField_Password.text] uppercaseString],textField_Email.text];
    
    NSString *url=[ConstantUtil createRequestURL:USER_REG_URL];
    receivedData=[[NSMutableData alloc] initWithData:nil];
	[DataSource createPostConn:url param:param delegate:self];
    
    [param autorelease];
}

- (void)cancelAction:(id)sender
{	
    // Tell the delegate about the cancellation.
    if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(forward:)] )
    {
        [self.delegate forward:self];
    }
}

- (void)presentModallyOn:(UIViewController *)parent
{
    UINavigationController *nav;
	
    // Create a navigation controller with us as its root.
    nav = [[[UINavigationController alloc] initWithRootViewController:self] autorelease];
    assert(nav != nil);
	
    // Set up the Cancel button on the left of the navigation bar.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)] autorelease];
    assert(self.navigationItem.leftBarButtonItem != nil);
    
    // Present the navigation controller on the specified parent 
    // view controller.
    
    [parent presentModalViewController:nav animated:YES];
}

-(IBAction)dismissKeyboard:(id)sender{
    [self.textField_Phone resignFirstResponder];
}

#pragma mark KeyboardDelegate methods
//键盘RETURN委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:textField_Account]) {
        [self.textField_Name becomeFirstResponder];
    }
    if ([textField isEqual:textField_Name]) {
        [self.textField_Password becomeFirstResponder];
    }
    if ([textField isEqual:textField_Password]) {
        [self.textField_Confirm becomeFirstResponder];
    }
    if ([textField isEqual:textField_Confirm]) {
        [self.textField_Phone becomeFirstResponder];
    }

    if ([textField isEqual:textField_Email]) {
        NSTimeInterval animationDuration = 0.30f;  
        CGRect frame = self.view.frame;      
        frame.origin.y +=120;        
        frame.size.height -=120;     
        self.view.frame = frame;  
        //self.view移回原位置    
        [UIView beginAnimations:@"ResizeView" context:nil];  
        [UIView setAnimationDuration:animationDuration];  
        self.view.frame = frame;                  
        [UIView commitAnimations];
        
        [self buttonPressed:nil];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField  
{ 
    //当点触textField内部，开始编辑都会调用这个方法。textField将成为first responder   
    if ([textField isEqual:textField_Email]) {
    NSTimeInterval animationDuration = 0.30f;      
    CGRect frame = self.view.frame;  
    frame.origin.y -=120;  
    frame.size.height +=120;  
    self.view.frame = frame;  
    [UIView beginAnimations:@"ResizeView" context:nil];  
    [UIView setAnimationDuration:animationDuration];  
    self.view.frame = frame;                  
    [UIView commitAnimations]; 
    }
}  

@end
