//
//  InsuranceViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InsuranceViewController.h"

@interface InsuranceViewController ()

@end

@implementation InsuranceViewController

@synthesize insuranceArray,telNumberArray;

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
    NSString *retCode=[NSString stringWithFormat:@"%@",[DataSource fetchJSONValueFormServer:json forKey:RETURN_CODE]];
    NSString *message=[DataSource fetchJSONValueFormServer:json forKey:RETURN_MESSAGE];
    if ([retCode isEqualToString:@"1"]) {
        NSLog(@"%@",message);
    }
    [UIMakerUtil sysApplicationCall:callNumber protocol:TELEPHONE_PROTOCOL]; 
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)callInsurance:(NSInteger) index
{
    callNumber=[self.telNumberArray objectAtIndex:index];
    NSString *title=[NSString stringWithFormat:@"确定要拔打 %@(%@) 吗?",[self.insuranceArray objectAtIndex:index],callNumber];
    [UIMakerUtil actionSheet:title delegate:self]; 
}

-(void) createArray
{
    self.insuranceArray=[NSArray arrayWithObjects:@"人民财产保险",@"太平洋保险",@"平安保险",@"大地保险",@"中华联合保险",@"华安保险",@"天安保险",@"永安保险",@"太平保险",@"华泰保险",@"安邦保险",@"阳光保险",@"华泰财产保险",@"永诚保险",@"太平养老保险",@"格林保险",@"大众保险",@"中国人民保险",@"渤海保险",@"民安保险", nil];
    self.telNumberArray=[NSArray arrayWithObjects:@"95518",@"95500",@"95512",@"95590",@"95585",@"95556",@"95505",@"02987233888",@"075582960919",@"95509",@"95569",@"95510",@"95509",@"95552",@"02161002888",@"01066214406",@"02123076666",@"01062616611",@"4006116666",@"95506", nil];
}

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
    self.title=INSURANCE_CALL_TITLE;
    [self createArray];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    [super dealloc];
    [insuranceArray release];
    [telNumberArray release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark table delegate management
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
    return [self.insuranceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleValue1;
	UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [self.insuranceArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[self.telNumberArray objectAtIndex:indexPath.row];
    /*
    UIButton *button=[UIMakerUtil createImageButton:@"call" light:@"callLight" frame:CGRectMake(260, 5,34,34)];
    button.tag=indexPath.row;
    [button addTarget:self action:@selector(callInsurance:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self callInsurance:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL destructiveClicked=actionSheet.destructiveButtonIndex==buttonIndex;
    if (destructiveClicked) {
        if ([[SessionUtil sharedInstance] isLogined]) {
            NSString *param=[NSString stringWithFormat: @"cusId=%@&icId=%d",[[[SessionUtil sharedInstance] userInformation] cusId],[telNumberArray indexOfObject: callNumber]+1];
            //建立连接，取数据
            receivedData=[[NSMutableData alloc] initWithData:nil];
            NSString *url=[ConstantUtil createRequestURL:LOG_REPORT_URL];
            [DataSource createPostConn:url param:param delegate:self];
        }else {
            [UIMakerUtil sysApplicationCall:callNumber protocol:TELEPHONE_PROTOCOL]; 
        }
    }
}

@end
