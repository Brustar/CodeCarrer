//
//  ReplyInputViewController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReplyInputViewController.h"

@interface ReplyInputViewController ()

@end

@implementation ReplyInputViewController

@synthesize mess,cusId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=SYS_BG;
    self.title=@"发表评论";
    
    self.navigationItem.rightBarButtonItem =[UIMakerUtil createBarButtonItem:@"countersign" andTarget:self andSelector:@selector(send:)];
    [self createTextView];
    [self createTips];
	// Do any additional setup after loading the view.
}

-(IBAction)send:(UIBarButtonItem *)sender
{
    self.navigationItem.rightBarButtonItem.enabled=NO; //防止重复点击，注意不能用sender.enabled
    NSString *url=[ConstantUtil createRequestURL:REPLY_URL];
    ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
    [request addPostValue:mess.msgID forKey:@"msgId"];
    [request addPostValue:content.text forKey:@"content"];
    [request addPostValue:[[[SessionUtil sharedInstance] userInformation] cusId] forKey:@"cusId"];
    if (self.cusId) {
        [request addPostValue:self.cusId forKey:@"cusReplyId"];
    }
}

-(void) createTips
{
    tips=[UIMakerUtil createLabel:@"0/140字" frame:CGRectMake(250, 175, 55, 20)];
    tips.font=[UIFont systemFontOfSize:12];
    tips.textAlignment=UITextAlignmentCenter;
    [[tips layer] setMasksToBounds:YES];  
    [[tips layer] setCornerRadius:10.0]; //设置矩形四个圆角半径  
    [[tips layer] setBorderWidth:1.0]; //边框宽度
    tips.layer.borderColor=[ConstantUtil getColorFromRed:140 Green:140 Blue:140 Alpha:255];
    [self.view addSubview:tips];
}

-(void) createTextView
{
    content =[UIMakerUtil createTextView:CGRectMake(10, 10, 300, 200)];
    content.font = [UIFont systemFontOfSize:15.0];
    content.backgroundColor = [UIColor whiteColor];
    content.opaque = YES;
    content.alpha = 1.0;
    content.delegate = self;
    content.layer.cornerRadius = 8;
    content.clipsToBounds = YES;
    content.textAlignment = UITextAlignmentLeft;
    content.editable = YES;    
    [content becomeFirstResponder];
    [self.view addSubview:content];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITextView Delegate Methods  
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text  
{  
    if ([textView.text length]>140) {  
        return NO;  
    } 
    tips.text=[NSString stringWithFormat:@"%d/%d字",[textView.text length],140-[textView.text length]];
    return YES;  
} 

#pragma mark - ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *jsonString = [request responseString];
    id jsonValue = [jsonString JSONValue];
    NSString *code = [jsonValue valueForKey:RETURN_CODE];
    if ([code isEqualToString:@"0"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [UIMakerUtil alert:[jsonValue valueForKey:RETURN_MESSAGE] title:REQUEST_FAIL];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [UIMakerUtil alert:SERVER_ERROR title:[error localizedDescription]];
}

@end
