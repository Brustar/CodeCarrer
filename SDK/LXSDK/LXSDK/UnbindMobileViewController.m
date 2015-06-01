//
//  UnbindMobileViewController.m
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import "UnbindMobileViewController.h"

@implementation UnbindMobileViewController

-(void)viewDidLoad
{
    self.lbluserid.text=self.userid;
    self.lblbindmobile.text=self.bindmobile;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id theSegue = segue.destinationViewController;
    [theSegue setValue:self.bindmobile forKey:@"bindmobile"];
    [theSegue setValue:self.userid forKey:@"userid"];
}

-(IBAction)backGame:(id)sender
{
    [DialogUtil back];
}

@end
