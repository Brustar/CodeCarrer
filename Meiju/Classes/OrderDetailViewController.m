//
//  OrderDetailViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

@synthesize info,receivedData,proArray,loadConn,payConn;

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
    if ([connection isEqual:self.loadConn]) {
        [self createUI:json];
    }else if([connection isEqual:self.payConn]){
        [self payOrder:json];
    }

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma view init
-(UILabel *) zoomFont:(UILabel *)label
{
    label.font=[UIFont systemFontOfSize:12];
    return label;
}

-(NSString *) orderState:(NSString *)state
{
    //0 待支付 1待发货 2 已发货 3取消
    if ([state isEqualToString:@"0"]) {
        return @"待支付";
    }else if ([state isEqualToString:@"1"]) {
        return @"待发货";
    }else if ([state isEqualToString:@"2"]) {
        return @"已发货";
    }else if ([state isEqualToString:@"3"]) {
        return @"取消";
    }
    return @"";
}

-(NSString *)totalMoney:(NSString *)json
{
	double total=0.0;
    NSArray *array=[[DataSource fetchDictionaryFromURL:json] objectForKey:@"orderGoodsList"];

	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if([dic objectForKey:@"totalMoney"])
		{
			total+=[[NSString stringWithFormat:@"%@",[dic objectForKey:@"totalMoney"]] doubleValue];
		}
	}
	return [[[NSString stringWithFormat:@"%.2f",total] fillZeroAtStart] RMBFormat];
}

-(NSMutableArray *) fetchGoods:(NSString *)json
{
    NSMutableArray *goods=[[[NSMutableArray alloc] init] autorelease];
    NSArray *array=[[DataSource fetchDictionaryFromURL:json] objectForKey:@"orderGoodsList"];
    
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if([dic objectForKey:@"totalMoney"])
		{
			Product *pro=[[[Product alloc] init] autorelease];
            pro.mallPrice=[NSString stringWithFormat:@"%@",[dic objectForKey:@"totalMoney"]];
            pro.name=[dic objectForKey:@"goodsName"];
            pro.picURL=[dic objectForKey:PIC_KEY];
            [goods addObject:pro];
		}
	}
	return goods;
}

-(void)payOrder:(NSString *)json
{
    ShopCartViewController *shop=[[[ShopCartViewController alloc] init] autorelease];
    int ret=[shop payAction:json];
    if (ret == kSPErrorAlipayClientNotInstalled) 
    {
        [UIMakerUtil alert:@"您还没有安装支付宝的客户端，快去安装吧。" title:@"提示" delegate:self];
    }
    else if (ret == kSPErrorSignError) 
    {
        NSLog(@"签名错误！");
    }
}

-(IBAction)repayAction:(id)sender
{
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *param=[NSString stringWithFormat:@"&orderId=%@",self.info.orderId];
    NSString *url=[ConstantUtil createRequestURL:REPAY_URL withParam:param];
    self.payConn=[DataSource createConn:url delegate:self];
}

-(void) createUI:(NSString *) json
{
    NSString *statu=[DataSource fetchJSONValueFormServer:json forKey:@"orderStatus"];
    if ([statu isEqualToString:@"0"]) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"结算" andTarget:self andSelector:@selector(repayAction:)];
    }
    
    self.proArray=[self fetchGoods:json];
    UIScrollView *scrollView=[UIMakerUtil createScrollView];
    scrollView.contentSize= CGSizeMake(1,scrollView.frame.size.height+100);
    CGRect rect=CGRectMake(10, 10, 100, TITLE_HEIGHT);
    [scrollView addSubview:[UIMakerUtil createLabel:@"订单信息" frame:rect] ];
    [scrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0,TITLE_HEIGHT+10)] ];
    
    rect.origin.y+= TITLE_HEIGHT+10;
    rect.size.width=self.view.frame.size.width;
    NSString *line=[NSString stringWithFormat:@"订单编号: %@",self.info.orderNum];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    
    rect.origin.y+= TITLE_HEIGHT;
    line=[NSString stringWithFormat:@"下单日期: %@",[ConstantUtil parseDate:self.info.orderDate]];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    
    rect.origin.y+= TITLE_HEIGHT;
    line=[NSString stringWithFormat:@"订单总金额: %@",[self totalMoney:json]];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    
    rect.origin.y+= TITLE_HEIGHT;
    
    line=[NSString stringWithFormat:@"订单状态: %@",[self orderState:statu]];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    
    if ([statu isEqualToString:@"2"]) {
        rect.origin.y+= TITLE_HEIGHT;
        line=[NSString stringWithFormat:@"物流情况: %@",[DataSource fetchJSONValueFormServer:json forKey:@"logtCompName"]];
        [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    
        rect.origin.y+= TITLE_HEIGHT;
        line=[NSString stringWithFormat:@"物流单号: %@",[DataSource fetchJSONValueFormServer:json forKey:@"logtNum"]];
        [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    }
    rect.origin.y+= TITLE_HEIGHT;
    [scrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0,rect.origin.y+10)] ];
    
    rect.origin.y+= TITLE_HEIGHT;
    [scrollView addSubview:[UIMakerUtil createLabel:@"商品信息" frame:rect]];
    
    rect.origin.y+= TITLE_HEIGHT;
    [scrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0,rect.origin.y+10)] ];
    
    UITableView *tableView=[UIMakerUtil createTableView:CGRectMake(0, rect.origin.y, self.view.frame.size.width, LINE_HEIGHT*[self.proArray count]+20) delegateAndSoruce:self];
    tableView.rowHeight=LINE_HEIGHT;
    [scrollView addSubview:tableView];

    rect.origin.y+= LINE_HEIGHT*[self.proArray count]+10;
    [scrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0,rect.origin.y+10)] ];
    
    rect.origin.y+= TITLE_HEIGHT;
    [scrollView addSubview:[UIMakerUtil createLabel:@"收货信息" frame:rect]];
    
    rect.origin.y+= TITLE_HEIGHT;
    [scrollView addSubview:[UIMakerUtil createSeparatorLine:CGPointMake(0,rect.origin.y+10)] ];
    
    rect.origin.y+= TITLE_HEIGHT;
    line=[NSString stringWithFormat:@"收货人姓名: %@",[DataSource fetchJSONValueFormServer:json forKey:@"erecPerName"]];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    rect.origin.y+= TITLE_HEIGHT;
    line=[NSString stringWithFormat:@"收货人地址: %@",[DataSource fetchJSONValueFormServer:json forKey:@"recAddr"]];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    rect.origin.y+= TITLE_HEIGHT;
    line=[NSString stringWithFormat:@"邮政编码: %@",[DataSource fetchJSONValueFormServer:json forKey:@"phoneNum"]];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    rect.origin.y+= TITLE_HEIGHT;
    line=[NSString stringWithFormat:@"联系电话: %@",[DataSource fetchJSONValueFormServer:json forKey:@"zipCode"]];
    [scrollView addSubview:[self zoomFont:[UIMakerUtil createLabel:line frame:rect]]];
    scrollView.contentSize= CGSizeMake(1,rect.origin.y+40);
    [self.view addSubview:scrollView];
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
    self.view.backgroundColor=SYS_BG;
    self.title=@"订单详情";

    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *param=[NSString stringWithFormat:@"orderId=%@",self.info.orderId];
    NSString *url=[ConstantUtil createRequestURL:ORDER_DETAIL_URL withParam:param];
    self.loadConn=[DataSource createConn:url delegate:self];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

-(void) dealloc
{
    [super dealloc];
    [receivedData release];
    [info release];
    [proArray release];
    [loadConn release];
    [payConn release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.proArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    Product *pro=[self.proArray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines=2;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = pro.name;
    if (!pro.picURL || [pro.picURL isEqualToString:@""]) {
        cell.imageView.image=[UIImage imageNamed:@"noImage"];
    }else {
        cell.imageView.image=[UIMakerUtil createImageViewFromURL:pro.picURL].image;
    }
    
    cell.textLabel.textAlignment= UITextAlignmentLeft;
    cell.detailTextLabel.numberOfLines=1;
    cell.detailTextLabel.text=[[pro.mallPrice fillZeroAtStart] RMBFormat];
    
    return cell;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
        NSString *URLString = [NSString stringWithFormat: 
                               @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=333206289"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}
}

@end
