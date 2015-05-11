//
//  ReportCaseViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReportCaseViewController.h"

@interface ReportCaseViewController ()

@end

@implementation ReportCaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title=INSURANCE_REPORTCASE;
    //[self.view addSubview:[UIMakerUtil createIcon:@"pre" frame:CGRectMake(10,25,21,21)]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    [super dealloc];
    [callNumber release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)callDoctor:(id)sender
{
    callNumber=@"120";
    NSString *title=[NSString stringWithFormat:@"确定要拔打 %@ 吗?",CALL_120];
    [UIMakerUtil actionSheet:title delegate:self];
}

-(IBAction)callPolice:(id)sender
{
    callNumber=@"110";
    NSString *title=[NSString stringWithFormat:@"确定要拔打 %@ 吗?",CALL_110];
    [UIMakerUtil actionSheet:title delegate:self];
}

#pragma mark table delegate management
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return REPORTCASE_MESSAGE;
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect sectionHeaderLabelViewFrame = CGRectMake(20, 0, self.tableView.frame.size.width - 40, 40);
    
    UILabel *sectionHeaderLabel = [[[UILabel alloc] initWithFrame:sectionHeaderLabelViewFrame] autorelease];
    sectionHeaderLabel.backgroundColor = [UIColor clearColor];
    sectionHeaderLabel.textColor = [UIColor colorWithRed:0.298 green:0.337 blue:0.424 alpha:1.0];
    sectionHeaderLabel.shadowColor = [UIColor whiteColor];
    sectionHeaderLabel.shadowOffset = CGSizeMake(0, 1);
    sectionHeaderLabel.textAlignment=UITextAlignmentCenter;
    sectionHeaderLabel.font = [UIFont boldSystemFontOfSize:12];
    
    
    if ([tableView.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        NSString* title = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
        if (title.length) {
            sectionHeaderLabel.text = title;
        }
    }
    
    return sectionHeaderLabel;
}
*/
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleValue1;
	UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    UIButton *button=[UIMakerUtil createImageButton:@"call" light:@"callLight" frame:CGRectMake(260, 5,34,34)];
    if (indexPath.row==0) {
        cell.textLabel.text=CALL_120;
        [button addTarget:self action:@selector(callDoctor:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
    }else if (indexPath.row==1) {
        [button addTarget:self action:@selector(callPolice:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        cell.textLabel.text=CALL_110;
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=INSURANCE_CALL;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        [self.navigationController pushViewController:[[[InsuranceViewController alloc] init] autorelease] animated:YES];
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
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
