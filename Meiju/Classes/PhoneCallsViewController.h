//
//  PhoneCallsViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"

@interface PhoneCallsViewController : UITableViewController
{
    NSArray *phoneCalls;
    NSString *callNumber;
}

@property (nonatomic,retain) NSArray *phoneCalls;;

@end
