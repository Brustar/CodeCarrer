//
//  popUpBox.h
//  popUpDemo
//
//  Created by bbk on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Classificatory.h"
#import "MallViewController.h"

@interface PopUpBox : UIView<UITableViewDelegate, UITableViewDataSource> {

	UITableView		*popUpBoxTableView;
	NSArray		    *popUpBoxDatasource;
	UIAlertView		*alertView;
	NSString		*boxTitle;
	UIButton		*retButton;
	id				controller;
}
-(id)initWithFrame:(CGRect)frame withTitle:text withButton:(UIButton *)button controller:(id) controller;
-(void)reloadData;

@property(nonatomic, retain) UITableView *popUpBoxTableView;
@property(nonatomic, retain) NSArray *popUpBoxDatasource;
@property(nonatomic, retain) UIAlertView *alertView;
@property(nonatomic, retain) NSString *boxTitle;
@property(nonatomic, retain) UIButton *retButton;
@property(nonatomic, retain) id	controller;

@end
