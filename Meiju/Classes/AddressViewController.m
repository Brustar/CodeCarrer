//
//  AddressViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

@synthesize addressArray,receivedData,deleteConn,listConn,removeAddr,isPay,caller;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[[NSString alloc] 
                       initWithBytes:[receivedData bytes] 
                       length:[receivedData length] 
                       encoding:NSUTF8StringEncoding] autorelease];
    if ([connection isEqual:self.listConn]) {
        if ([DataSource isEmptyJsonArray:json]) {
            [UIMakerUtil confirm:@"您还未设置收货地址，请先新增收货地址." title:self.title delegate:self];
            return;
        }
        self.addressArray=[self fetchAddressFormJson:json];
    } else if ([connection isEqual:self.deleteConn]) {
        if ([[DataSource fetchValueFormJsonObject:json forKey:RETURN_CODE] isEqualToString:@"0"]) {
            [self.addressArray removeObject:self.removeAddr];
        }else {
            [UIMakerUtil alert:[DataSource fetchValueFormJsonObject:json forKey:RETURN_MESSAGE] title:self.title];
        }
    }
    [self.tableView reloadData];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(NSMutableArray *)fetchAddressFormJson:(NSString *)data
{
    NSDictionary *json= [DataSource fetchDictionaryFromURL:data];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
            //initWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *recId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"recId"]];
			NSString *cusId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"cusId"]];
			AddressInfo *info=[[[AddressInfo alloc] init] autorelease];	
            info.recId=recId;
            info.recPerName=[dic objectForKey:@"recPerName"];
            info.cusId=cusId;
            info.recAddr=[dic objectForKey:@"recAddr"];
            info.zipCode=[dic objectForKey:@"zipCode"];
            info.phoneNum=[dic objectForKey:@"phoneNum"];
			[retArray addObject:info];
		}
	}
	return [retArray autorelease];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)insertAddress:(id)sender
{
    InsertAddressViewController *view=[[[InsertAddressViewController alloc] init] autorelease];
    [self.navigationController pushViewController:view animated:YES];
}

-(void) viewWillAppear:(BOOL) animated
{
	[super viewWillAppear:animated];
	[self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title=@"收货地址";
    self.tableView.rowHeight=LINE_HEIGHT;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"新增" andTarget:self andSelector:@selector(insertAddress:)];
    
    UserInfo *info=[SessionUtil sharedInstance].userInformation;
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *param=[NSString stringWithFormat:@"cusId=%@",info.cusId];
    NSString *url=[ConstantUtil createRequestURL:ADDRESS_URL withParam:param];
    self.listConn=[DataSource createConn:url delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    [super dealloc];
    [addressArray release];
    [receivedData release];
    [deleteConn release];
    [listConn release];
    [removeAddr release];
    [caller release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.addressArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    AddressInfo *info = [self.addressArray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines=4;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = [NSString stringWithFormat:@"收货人姓名: %@\n地址: %@\n邮政编码: %@\n联系电话: %@",info.recPerName,info.recAddr,info.zipCode,info.phoneNum];
    cell.textLabel.textAlignment= UITextAlignmentLeft;
    
    return cell;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// delete item
    AddressInfo *info=[self.addressArray objectAtIndex:indexPath.row];
    receivedData=[[NSMutableData alloc] initWithData:nil];
    self.removeAddr=info;
    NSString *param=[NSString stringWithFormat:@"&cusId=%@&recId=%@",info.cusId,info.recId];
    NSString *url=[ConstantUtil createRequestURL:REMOVE_ADDRESS_URL];
    self.deleteConn=[DataSource createPostConn:url param:param delegate:self];
}

-(void)enterEditMode
{
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	[self.tableView setEditing:YES animated:YES];
}

-(void)leaveEditMode
{
	[self.tableView setEditing:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AddressInfo *info=[self.addressArray objectAtIndex:indexPath.row];

    InsertAddressViewController *view=[[[InsertAddressViewController alloc] init] autorelease];
    view.address=info;
    view.isPay=self.isPay;
    view.caller=self.caller;
    [[self navigationController] pushViewController:view animated:YES];
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        InsertAddressViewController *view=[[[InsertAddressViewController alloc] init] autorelease];
        [self.navigationController pushViewController:view animated:YES];
    }
}

@end
