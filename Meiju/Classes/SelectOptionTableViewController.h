//
//  SelectOptionTableView.h
//  SelectOptionTable
//
//  Created by brustar on 12-5-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantUtil.h"

@protocol SelectOptionDelegate;

@interface SelectOptionTableViewController : UITableViewController {
	NSArray *data;
	NSUInteger currentIndex;
	id<SelectOptionDelegate>  delegate;
}

@property(nonatomic,retain) NSArray *data;
@property(nonatomic) NSUInteger currentIndex;
@property (nonatomic, assign, readwrite) id<SelectOptionDelegate> delegate;

- (void)presentModallyOn:(UIViewController *)parent;
- (void)cancelAction:(id)sender;

@end


@protocol SelectOptionDelegate <NSObject>

@required

- (void)numberPicker:(SelectOptionTableViewController *)controller didChooseNumber:(NSString *)string;

@end