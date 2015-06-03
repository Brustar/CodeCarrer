//
//  Catalog.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CatalogController.h"

@implementation CatalogController

@synthesize catas,icons,master;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
		self.contentSizeForViewInPopover = CGSizeMake(100, 3 * 30 - 2); // 设定弹出窗口大小
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.rowHeight = 30.0;
    self.catas=[NSArray arrayWithObjects:@"税事评论",@"税政解读",@"税务杂谈", nil];
    self.icons=[NSArray arrayWithObjects:@"comment",@"PolicyStudies",@"Taxtittle-tattle", nil];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
     
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [catas count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.font=[UIFont systemFontOfSize:12];
	cell.textLabel.text = [catas objectAtIndex:[indexPath row]]; 
	//cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image=[UIImage imageNamed:[icons objectAtIndex:[indexPath row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(MasterViewController *)master loadCatalog:indexPath.row+1];
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
        return self.tableView.rowHeight+=10;
    }
    return self.tableView.rowHeight;
}
*/
@end
