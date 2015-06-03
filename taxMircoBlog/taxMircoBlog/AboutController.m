//
//  AboutController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"关于";
    
    [self.view addSubview:[UIMakerUtil createImageView:@"icon" frame:CGRectMake(130, 20, 57, 57)]];
    UILabel *title=[UIMakerUtil createLabel:[NSString stringWithFormat:@"%@ %@",[ConstantUtil fetchValueFromPlistFile:APP_NAME_KEY],[ConstantUtil fetchValueFromPlistFile:VERSION_KEY]] frame:CGRectMake(110, 90, 100, 30)];
    title.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:title];
    UILabel *des=[UIMakerUtil createLabel:@"Copyright © 2011-2012 郭伟税务工作室 版权所有 由Thrivefa Technology Co. Ltd设计并提供技术支持" frame:CGRectMake(25, 120, 275, 57)];
    des.numberOfLines=2;
    des.textColor=[UIColor grayColor];
    des.textAlignment=UITextAlignmentCenter;
    des.font=[UIFont systemFontOfSize:12];
    
    [self.view addSubview:des];
    
    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
