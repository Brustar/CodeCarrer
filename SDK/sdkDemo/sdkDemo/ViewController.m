//
//  ViewController.m
//  sdkDemo
//
//  Created by lexun05 on 14/12/23.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)main:(id)sender
{
    [LXSDK main];
}

-(IBAction)charge:(id)sender
{
    [LXSDK charge];
}

-(IBAction)login:(id)sender
{
    [LXSDK login];
}

@end
