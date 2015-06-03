//
//  SelectOptionTableView.m
//  SelectOptionTable
//
//  Created by brustar on 12-5-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionViewController.h"


@implementation OptionViewController

@synthesize data,delegate,currentIndex;


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView 
{
    return 1; 
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleDefault;
	UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
    
    if(indexPath.row==currentIndex){
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else{
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	// Set cell label
	NSString *key = [self.data objectAtIndex:indexPath.row];
	cell.textLabel.text = key;
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if(indexPath.row==currentIndex){
		[self cancelAction:self.navigationItem.leftBarButtonItem];
        return;
	}
	//点击后变成行标上对号
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:currentIndex
                                                   inSection:0];
	UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
	if (newCell.accessoryType == UITableViewCellAccessoryNone) {
		newCell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
	if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
		oldCell.accessoryType = UITableViewCellAccessoryNone;
	}
	currentIndex=indexPath.row;
	
	// Tell the delegate about the selection.
    if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(numberPicker:didChooseNumber:)] ) {
        [self.delegate numberPicker:self didChooseNumber:indexPath.row];
    }
}


- (void)presentModallyOn:(UIViewController *)parent
{
    UINavigationController *nav;
    // Create a navigation controller with us as its root.
    nav = [[[UINavigationController alloc] initWithRootViewController:self] autorelease];
    assert(nav != nil);
    // Set up the Cancel button on the left of the navigation bar.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)] autorelease];
    assert(self.navigationItem.leftBarButtonItem != nil);
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    // Present the navigation controller on the specified parent 
    // view controller.
    
    [parent presentModalViewController:nav animated:YES];
}

- (void)cancelAction:(id)sender
{	
    // Tell the delegate about the cancellation.
    if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(numberPicker:didChooseNumber:)] ) {
        [self.delegate numberPicker:self didChooseNumber:-1];
    }
}

- (void)dealloc {
    [data release];
    [super dealloc];
}

@end
