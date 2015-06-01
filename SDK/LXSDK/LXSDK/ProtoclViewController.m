//
//  ProtoclViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/16.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "ProtoclViewController.h"

@implementation ProtoclViewController

-(void)viewDidLoad{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"lxsdk_user_agreement" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.protocolWebView loadRequest:request];
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

@end
