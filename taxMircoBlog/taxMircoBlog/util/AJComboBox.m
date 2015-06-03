//
//  DropDown.m
//  DropDown
//
//  Created by Jasperit on 2/6/12.
//  Copyright (c) 2012 Jasper IT Pvt Ltd. All rights reserved.
// http://www.jasperitsolutions.com
//

/*
 Copyright (c) 2012, Ajeet Shakya
 
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the Zang Industries nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 Copyright 2011 AJEET SHAKYA
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "AJComboBox.h"
#import <QuartzCore/QuartzCore.h>

@implementation AJComboBox
@synthesize arrayData, delegate;
@synthesize dropDownHeight;
@synthesize labelText;
@synthesize enabled;

- (void)__show {
    viewControl.alpha = 0.0f;
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    [mainWindow addSubview:viewControl];
	[UIView animateWithDuration:0.3f
					 animations:^{
						 viewControl.alpha = 1.0f;
					 }
					 completion:^(BOOL finished) {}];
}

- (void)__hide {
	[UIView animateWithDuration:0.2f
					 animations:^{
						 viewControl.alpha = 0.0f;
					 }
					 completion:^(BOOL finished) {
						 [viewControl removeFromSuperview];
					 }];
}


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int count=[[PlistUtil arrayFromPlist] count];
        if (count>4) {
            count=4;
        }
        dropDownHeight = 30*count;
                
        viewControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [viewControl setBackgroundColor:RGBA(0, 0, 0, 0.1f)];
        [viewControl addTarget:self action:@selector(controlPressed) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat x = self.frame.origin.x;
        CGFloat y = 115;//(viewControl.frame.size.height - dropDownHeight)/2-65;

        _table = [[UITableView alloc] initWithFrame:CGRectMake(x, y, frame.size.width, dropDownHeight) style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        CALayer *layer = _table.layer;
        layer.masksToBounds = YES;
        layer.cornerRadius = 5.0f;
        layer.borderWidth = 1.5f;
        [layer setBorderColor:[UIColor grayColor].CGColor];
        [viewControl addSubview:_table];
    }
    return self;
}

- (void) setLabelText:(NSString *)_labelText
{
    [labelText release];
    labelText = [_labelText retain];
    //[button setTitle:labelText forState:UIControlStateNormal];
}

- (void) setEnable:(BOOL)_enabled
{
    enabled = _enabled;
    //[button setEnabled:_enabled];
}

- (void) setArrayData:(NSArray *)_arrayData
{
    [arrayData release];
    arrayData = [_arrayData retain];
    [_table reloadData];
}

- (void) dealloc
{
    [viewControl release];
    [_table release];
    [super dealloc];
}

- (void) buttonPressed
{
    [self __show];
}

- (void) controlPressed
{
    //[viewControl removeFromSuperview];
    [self __hide];
}

-(IBAction)deleteItemAction:(PropertyButton *)sender
{
    int index=((NSIndexPath *)sender.data).row;
    [PlistUtil deleteFromPlist:index];
    arrayData=[PlistUtil arrayFromPlist];
    [_table reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 30;
}	

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [arrayData count];
}	

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
	cell.textLabel.text = [arrayData objectAtIndex:indexPath.row];
    PropertyButton *accessoryButton=[UIMakerUtil createPropertyButton:@"clear" frame:CGRectMake(0, 0, 24, 27)];
    accessoryButton.data=indexPath;
    [accessoryButton addTarget:self action:@selector(deleteItemAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = accessoryButton;
	return cell;
}	

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndex = [indexPath row];
    //[viewControl removeFromSuperview];
    [self __hide];
    //[button setTitle:[self.arrayData objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    [delegate didChangeComboBoxValue:self selectedIndex:[indexPath row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 0;
}	

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"";
}	

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	return @"";
}	

- (NSInteger) selectedIndex
{
    return selectedIndex;
}

#pragma mark - AJComboBoxDelegate
-(void)didChangeComboBoxValue:(AJComboBox *)comboBox selectedIndex:(NSInteger)selectedIndex
{
	
}	

@end