//
//  TopUpMenuViewController.h
//  sdkExample
//
//  Created by lexun05 on 14/12/17.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DialogUtil.h"

#define PICKERDATA [[NSArray alloc]initWithObjects:@"10",@"30",@"50",@"100",@"200",@"300",@"500", nil]

@interface TopUpMenuViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *amount;
@property (nonatomic, retain) IBOutlet UIView *amountView;

@end
