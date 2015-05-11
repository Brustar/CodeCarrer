//
//  PhoneCallsViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhoneCallsViewController.h"

@interface PhoneCallsViewController ()

@end

@implementation PhoneCallsViewController

@synthesize phoneCalls;

-(void)callStore:(NSInteger) index
{
    callNumber=[self.phoneCalls objectAtIndex:index];
    NSString *title=[NSString stringWithFormat:@"确定要拔打 %@ 吗?",callNumber];
    [UIMakerUtil actionSheet:title delegate:self]; 
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"商户电话";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [phoneCalls release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.phoneCalls count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    } 
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.textLabel.text=[self.phoneCalls objectAtIndex:indexPath.section];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    [self callStore:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL destructiveClicked=actionSheet.destructiveButtonIndex==buttonIndex;
    if (destructiveClicked) {
        [UIMakerUtil sysApplicationCall:callNumber protocol:TELEPHONE_PROTOCOL]; 
    }
}

@end
