//
//  SetupController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SetupController.h"

@interface SetupController ()

@end

@implementation SetupController

@synthesize titles,details,icons;

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
    
    self.title=@"系统设置";
    self.view.backgroundColor=SYS_BG;
    self.tableView.backgroundView=nil;
    NSString *loginDetail=@"个人帐号资料详细设置与修改";
    if ([[SessionUtil sharedInstance] isLogined]) {
        loginDetail=@"已登录";
    }
    
    self.titles=[NSArray arrayWithObjects:@"我的帐号",@"我的收藏",@"关于税眼看事", nil];
    self.details=[NSArray arrayWithObjects:loginDetail,@"我收藏的信息",@"当前应用版本号/免责声明/版权声明", nil];
    self.icons=[NSArray arrayWithObjects:@"personal_profile",@"myfavorite",@"about", nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.font=[UIFont systemFontOfSize:14];
	cell.textLabel.text = [titles objectAtIndex:[indexPath row]]; 
    cell.detailTextLabel.text=[details objectAtIndex:[indexPath row]];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:10];
    cell.imageView.image=[UIImage imageNamed:[icons objectAtIndex:[indexPath row]]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *forward=nil;
    // Navigation logic may go here. Create and push another view controller.
    switch (indexPath.row) {
        case 0:
            if ([[SessionUtil sharedInstance] isLogined]) {
                forward=[[[ProfileViewController alloc] init] autorelease];
            }else {
                forward=[[[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
            }
            break;
        case 1:
            //先判断是否有登录
            if ([[SessionUtil sharedInstance] isLogined]) {
                forward=[[[CollectionTableViewController alloc] init] autorelease];
            }else {
                forward=[[[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
            }
            break;
        case 2:
            forward=[[[AboutController alloc] init] autorelease];
            break;
    }
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:forward animated:YES];

}

@end
