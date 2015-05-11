//
//  popUpBox.m
//  popUpDemo
//
//  Created by bbk on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PopUpBox.h"

@implementation PopUpBox
@synthesize popUpBoxTableView, popUpBoxDatasource, alertView,boxTitle,retButton,controller;

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)text withButton:(UIButton *)button controller:(id) control
{
	self.boxTitle=text;
	self.retButton=button;
	self.controller=control;
	return [self initWithFrame:frame];
}

-(void)categoryButtonPressed:(id)sender
{
	[self.controller popButtonClick];
    [alertView show];
}

-(void)reloadData
{
	[self.popUpBoxTableView reloadData];
}
 
-(id)initWithFrame:(CGRect)frame 
{
	if ((self = [super initWithFrame: frame])) {
		[retButton addTarget:self action:@selector(categoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:retButton];
		// 添加一个tableView
		popUpBoxTableView = [[UITableView alloc] initWithFrame: CGRectMake(15, 50, 255, 225)];
		popUpBoxTableView.delegate = self;
		popUpBoxTableView.dataSource = self;
		
		// 添加一个alertView
		alertView = [[UIAlertView alloc] initWithTitle:boxTitle message: @"\n\n\n\n\n\n\n\n\n\n\n" delegate: nil cancelButtonTitle: @"取消" otherButtonTitles: nil];
		[alertView addSubview: popUpBoxTableView];
    }
	return self;
}

#pragma mark table data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	int n = [popUpBoxDatasource count];
	return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ListCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	if([[popUpBoxDatasource objectAtIndex:indexPath.row] isKindOfClass:[Classificatory class]])
	{
		Classificatory *cate = [popUpBoxDatasource objectAtIndex:indexPath.row];
		cell.textLabel.text = cate.typeName;
		if (!cate.parentId) {
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}else {
			cell.accessoryType =UITableViewCellAccessoryNone;
		}
	}else {
		cell.textLabel.text =[popUpBoxDatasource objectAtIndex:indexPath.row];
	}

	cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
	
	
	return cell;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 35.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// 点击使alertView消失
	NSUInteger cancelButtonIndex = alertView.cancelButtonIndex;
	
	NSString *selectedCellText;
	//弹出大小类框
	if([[popUpBoxDatasource objectAtIndex:indexPath.row] isKindOfClass:[Classificatory class]])
	{
		Classificatory *cate = [popUpBoxDatasource objectAtIndex:indexPath.row];
		selectedCellText = cate.typeName;
		[retButton setTitle:selectedCellText forState:UIControlStateNormal];
		//pop and search
		if (!cate.parentId) { //大类,弹小类框
			[self.controller searchClassificatory:cate.typeId];
		}else { //小类，直接搜索
			[alertView dismissWithClickedButtonIndex: cancelButtonIndex animated: YES];
			[self.controller searchByClassificatory:(cate.typeId==nil?cate.parentId:cate.typeId) isParent:cate.typeId==nil];
		}
	}else {	//弹出排序框
		[alertView dismissWithClickedButtonIndex: cancelButtonIndex animated: YES];
		selectedCellText =[popUpBoxDatasource objectAtIndex:indexPath.row];
		[retButton setTitle:selectedCellText forState:UIControlStateNormal];
		//search
		[self.controller sort:indexPath.row+1];
	}				
	
}

-(void)dealloc {
	[super dealloc];
	[alertView release];
	//[popUpBoxTableView release];
}
@end
