//
//  FeedBackViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SelectOptionTableViewController.h"
#import "FillString.h"

#define FEEDBACK_URL @"/addQuestionBack.do"

@interface FeedBackViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,SelectOptionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *cateArray;
    UITextView *contentView;
    UITextField *contactText;
    UITableView *cateTable;
    NSMutableData *receivedData;
    NSString *selValue;
    UITableViewCell *cell;
}

@property(nonatomic,retain) NSString *selValue;
@property (nonatomic, retain) NSArray *cateArray;
@property (nonatomic, retain) UITextView *contentView;
@property (nonatomic, retain) UITextField *contactText;

- (void)presentNumberPickerModally:(NSString *)sel;
-(SelectOptionTableViewController *)createSelectOptionTableView:(NSArray *)data selected:(NSString *)sel;

@end
