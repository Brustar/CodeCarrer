//
//  AboutViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "MoreViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    self.title=ABOUT_TITLE;
    
    CGRect rect=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    rect.size.height=480-20-44-49;
    [self.view addSubview:[UIMakerUtil createImageView:@"aboutus" frame:rect]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
