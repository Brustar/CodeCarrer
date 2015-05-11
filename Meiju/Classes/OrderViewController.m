//
//  UnpaymentViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

@synthesize receivedData,orderArray,cate,pageNo,serverPages,loadConn,moreConn;


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
    self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
    if ([connection isEqual:self.loadConn]) {
        self.orderArray=[self fetchOrdersFormJson:json];
    }else if([connection isEqual:self.moreConn]) {
        NSMutableArray *results= [self fetchOrdersFormJson:json];  
        [self.orderArray addObjectsFromArray:results];
    }
    [self.tableView reloadData];
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)fetchOrdersFormJson:(NSString *) data
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
			NSString *orderId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderId"]];
			NSString *totalMoney=[NSString stringWithFormat:@"%@",[dic objectForKey:@"totalMoney"]];
			OrderInfo *info=[[[OrderInfo alloc] init] autorelease];	
            info.orderId=orderId;
            info.picAddr=[dic objectForKey:PIC_KEY];
            info.totalMoney=totalMoney;
            info.orderNum=[dic objectForKey:@"orderNum"];
            info.orderNumber=[dic objectForKey:@"orderNumber"];
            info.orderDate=[dic objectForKey:@"orderDate"];
			[retArray addObject:info];
		}
	}
	return [retArray autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的订单";
    self.tableView.rowHeight=LINE_HEIGHT;
    self.pageNo=1;
    UserInfo *info=[SessionUtil sharedInstance].userInformation;
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *param=[NSString stringWithFormat:@"pageNo=%d&orderStatus=%d&cusId=%@",self.pageNo,self.cate,info.cusId];
    NSString *url=[ConstantUtil createRequestURL:ORDER_URL withParam:param];
    self.loadConn=[DataSource createConn:url delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{
    [super dealloc];
    [receivedData release];
    [orderArray release];
    [loadConn release];
    [moreConn release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [self.orderArray count]; 
	if (count<PAGE_LENGTH || self.pageNo==self.serverPages) { //不足一页时或者最后一页
		return count;
	}
    return  count + 1; 
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
    
    if([indexPath row] == [self.orderArray count]) { 
		if (self.pageNo < self.serverPages) {   //创建loadMoreCell 
			cell.textLabel.text=MORE;
			cell.imageView.image=nil;
			cell.detailTextLabel.text=@"";
		}
	}else {
        OrderInfo *order = [self.orderArray objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines=3;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.text = [NSString stringWithFormat:@"订单编号: %@\n下单日期: %@\n总金额: %@ (共%@件)" ,order.orderNum,[ConstantUtil parseDate:order.orderDate],[[order.totalMoney fillZeroAtStart] RMBFormat],order.orderNumber];
        if (!order.picAddr || [order.picAddr isEqualToString:@""]) {
            cell.imageView.image=[UIImage imageNamed:@"noImage"];
        }else {
            cell.imageView.image=[UIMakerUtil createImageViewFromURL:order.picAddr].image;
        }
    }
    

    //cell.imageView.image=[UIMakerUtil createImageViewFromURL:order.picAddr].image;
    cell.textLabel.textAlignment= UITextAlignmentLeft;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.orderArray count] && self.pageNo<self.serverPages) {
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath]; 
        loadMoreCell.textLabel.text=@"loading more …";
        [self loadMore:nil];
		//[self performSelectorInBackground:@selector(loadMore:) withObject:nil];
		[tableView deselectRowAtIndexPath:indexPath animated:YES]; 
        return; 
    }
    
    OrderDetailViewController *view=[[[OrderDetailViewController alloc] init] autorelease];
    view.info=[self.orderArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:view animated:YES];
}

-(IBAction)loadMore:(id)sender
{
	self.pageNo++;
    UserInfo *info=[SessionUtil sharedInstance].userInformation;
    NSString *key=[NSString stringWithFormat:@"pageNo=%d&orderStatus=%d&cusId=%@",self.pageNo,self.cate,info.cusId];  
	
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:ORDER_URL withParam:key];
	self.moreConn=[DataSource createConn:url delegate:self];
}

@end
