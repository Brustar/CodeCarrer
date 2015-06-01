//
//  UnbindMobileViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/18.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DialogUtil.h"

@interface UnbindMobileViewController : UIViewController

@property(nonatomic,retain) NSString *bindmobile;
@property(nonatomic,retain) NSString *userid;

@property (nonatomic, retain) IBOutlet UILabel *lblbindmobile;
@property (nonatomic, retain) IBOutlet UILabel *lbluserid;

@end
