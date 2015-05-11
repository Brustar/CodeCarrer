//
//  ShopCartViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShopCartViewController.h"

@interface ShopCartViewController ()

@end

@implementation ShopCartViewController

@synthesize context,results,address;

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

    if ([[DataSource fetchJSONValueFormServer:json forKey:RETURN_CODE] isEqualToString:@"0"]) {
        /*
        for (ShopCart * cart in self.results.fetchedObjects) {
            [self removeObject:cart];
        }*/
        int ret=[self payAction:json];
        if (ret == kSPErrorAlipayClientNotInstalled) 
        {
            [UIMakerUtil alert:@"您还没有安装支付宝的客户端，快去安装吧。" title:@"提示" delegate:self];
        }
        else if (ret == kSPErrorSignError) 
        {
            NSLog(@"签名错误！");
        }else {
            [self removeObjects];
        }
    }
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

#pragma mark Core Data
- (void) performFetch
{
	// Init a fetch request
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShopCart" inManagedObjectContext:self.context];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchBatchSize:100]; // more than needed for this example
	
	// Apply an ascending sort for the color items
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"productName" ascending:YES selector:nil];
	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
	[fetchRequest setSortDescriptors:descriptors];
    
	// Init the fetched results controller
	NSError *error;
	self.results = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil] autorelease];
    //self.results.delegate = self;
	if (![self.results performFetch:&error])	NSLog(@"Error: %@", [error localizedDescription]);
    
	[fetchRequest release];
	[sortDescriptor release];
}

- (void) initCoreData
{
	NSError *error;
	NSURL *url = [NSURL fileURLWithPath:DATASTORE_PATH];
    
	// Init the model, coordinator, context
	NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
	NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) 
		NSLog(@"Error: %@", [error localizedDescription]);
	else
	{
		self.context = [[[NSManagedObjectContext alloc] init] autorelease];
		[self.context setPersistentStoreCoordinator:persistentStoreCoordinator];
    }
	[persistentStoreCoordinator release];
    
    [self performFetch];
}

-(void) updateObject:(ShopCart *) cart
{
    NSError *error = nil;
	
	// remove all people (if they exist)
	if (!self.results.fetchedObjects.count) 
	{
		NSLog(@"No one to update");
		return;
	}
	
    NSLog(@"updating %@\n", cart.productName);
    
    // update the object
	[self.context updatedObjects];
	// save
	if (![self.context save:&error]) NSLog(@"Error: %@ (%@)", [error localizedDescription], [error userInfo]);
}

- (void) removeObjects
{
	NSError *error = nil;
	
	// remove all people (if they exist)
	[self performFetch];
	if (!self.results.fetchedObjects.count) 
	{
		NSLog(@"No one to delete");
		return;
	}
	
	// remove each person
	for (ShopCart *cart in self.results.fetchedObjects)	
	{
		NSLog(@"Deleting %@\n", cart.productName);
        
		// remove person from department
		// NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF != %@", person];
		// if (person.department.members) person.department.members = [person.department.members filteredSetUsingPredicate:pred];
        
		// delete the person object
		[self.context deleteObject:cart];
	}
	
	// save
	if (![self.context save:&error]) NSLog(@"Error: %@ (%@)", [error localizedDescription], [error userInfo]);
	[self performFetch];
}

- (void) removeObject:(ShopCart *) cart
{
    NSError *error = nil;
	
	// remove all people (if they exist)
	if (!self.results.fetchedObjects.count) 
	{
		NSLog(@"No one to delete");
		return;
	}
	
    NSLog(@"Deleting %@\n", cart.productName);
        
    // delete the object
    [self.context deleteObject:cart];
	// save
	if (![self.context save:&error]) NSLog(@"Error: %@ (%@)", [error localizedDescription], [error userInfo]);
    //及时更新，未更新表格会混乱
    if (![self.results performFetch:&error])
            NSLog(@"Error: %@", [error localizedDescription]);

    
}

- (BOOL) addObject:(Product *)product
{
	NSLog(@"Adding preset data");
	
	// Insert objects for department and two people, setting their properties
	ShopCart *shopcart = (ShopCart *)[NSEntityDescription insertNewObjectForEntityForName:@"ShopCart" inManagedObjectContext:self.context];
    
    shopcart.pic=product.picURL;
	
    shopcart.productAmount=[NSNumber numberWithInt:1];
	shopcart.productId=[NSNumber numberWithInt:product.pid.intValue];
	shopcart.productName=product.name;
    shopcart.mallPrice=[NSNumber numberWithDouble:product.mallPrice.doubleValue];
    //shopcart.marketPrice=product.markPrice.doubleValue;
    //shopcart.productDesc=product.detail;
    //shopcart.phase=product.
    //shopcart.afterSale=product.saleRemark;
    if ([self searchObject:shopcart]) {
        [UIMakerUtil alert:@"不能重复添加商品" title:self.title];
        return NO;
    }
    // Save the data
	NSError *error;
	if (![self.context save:&error]) NSLog(@"Error: %@", [error localizedDescription]);
    return YES;
}

-(BOOL) searchObject:(ShopCart *)shopcart
{
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"productId == %d", [shopcart.productId intValue]];
    NSFetchRequest *fetchRequest=[self.results fetchRequest];
    fetchRequest.predicate=thePredicate;
    //使predicate生效
    self.results = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil] autorelease];
    
    NSError* err;
    self.results.delegate = self;
	[self.results performFetch:&err];
    //加上它自己应该大于1，而不是0
    return [[self.results fetchedObjects] count]>1;
}

-(double) totalPrice:(NSInteger)num
{
    double total=0.0;
    for (NSInteger i=0;i<num;i++) {
        ShopCart *cart = [self.results objectAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		int amount=[cart.productAmount intValue];
        total+=[cart.mallPrice doubleValue]* amount;
    } 
    return total;
}

-(int) products:(NSInteger)num
{
    int total=0;
    for (NSInteger i=0;i<num;i++) {
        ShopCart *cart = [self.results objectAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        total+=[cart.productAmount intValue];
    } 
    return total;
}

-(void) settle:(id) sender
{
    if ([SessionUtil sharedInstance].isLogined) {
        AddressViewController *control=[[[AddressViewController alloc] init] autorelease];
        control.isPay=YES;
        control.caller=self;
        [self.navigationController pushViewController:control animated:YES];
    }else {
        [UIMakerUtil actionSheet:@"您还没有登录,是否现在登录？" delegate:self addButton:@"登录",@"注册",nil];
    }
}

-(void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title=@"购物车";
    [self.tableView setRowHeight:LINE_HEIGHT];
    
    [self initCoreData];
    if (self.results.fetchedObjects.count>0) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"结算" andTarget:self andSelector:@selector(settle:)];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [results release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{
    [super dealloc];
    [context release];
    [results release];
    [address release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self.results sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve or create a cell
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basic cell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"basic cell"] autorelease];
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	// Recover object from fetched results
	ShopCart *cart = [self.results objectAtIndexPath:indexPath];

    cell.textLabel.numberOfLines=2;
	cell.textLabel.text = cart.productName;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    UIImageView *imageView=[UIMakerUtil createImageViewFromURL:cart.pic];
    if (imageView.image!=nil) {
        cell.imageView.image=imageView.image;
    }else {
        cell.imageView.image=[UIImage imageNamed:@"noImage"];;
    }
    
    cell.textLabel.textAlignment= UITextAlignmentLeft;
    cell.detailTextLabel.numberOfLines=1;
    NSString *price= [NSString stringWithFormat:@"%.2f", [cart.mallPrice doubleValue]];
    cell.detailTextLabel.text=[[price fillZeroAtStart] RMBFormat];
    UITextField *numText=[UIMakerUtil createTextField:CGRectMake(260,55,40,24)];
    //numText.keyboardType=UIKeyboardTypeNumberPad;
    numText.text=[NSString stringWithFormat:@"%d", [cart.productAmount intValue]];
    numText.adjustsFontSizeToFitWidth=YES;
    //numText.tag=100+[indexPath row];
    numText.delegate=self;
    [cell.contentView addSubview:numText];
    
    return cell;
}

#pragma mark - Table view delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger num=[[[self.results sections] objectAtIndex:section] numberOfObjects];
    return [NSString stringWithFormat:@"商品总数: %d 件 总价: ￥%.2f 元",[self products:num],[self totalPrice:num]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCart *cart=[self.results objectAtIndexPath:indexPath];
    NSString *productId=[NSString stringWithFormat:@"%d", [cart.productId intValue]];
    Product *product= [Product productWithId:productId];
    
    [[self navigationController] pushViewController:[UIMakerUtil createProductDetailView:product] animated:YES];
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// delete item
	[self updateItemAtIndexPath:indexPath];
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

- (void) updateItemAtIndexPath: (NSIndexPath *) indexPath
{
    [self removeObject:[self.results objectAtIndexPath:indexPath]];
    if (self.results.fetchedObjects.count==0) {
        self.navigationItem.rightBarButtonItem =nil;
    }
	[self.tableView reloadData];
}

//键盘RETURN委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![ConstantUtil isNumbric:textField.text]) {
        [UIMakerUtil alert:@"数目必须是整数" title:self.title];
        return NO;
    }
    
    ShopCart *cart = [self.results objectAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    NSNumber *num=[NSNumber numberWithInt:[textField.text intValue]];
    if (num.intValue>99 || num.intValue<1) {
        [UIMakerUtil alert:@"数目应该为(1-99)之间" title:self.title];
        return NO;
    }
    cart.productAmount=num;
    [self updateObject:cart];
    [self.tableView reloadData];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) { //登录
        self.tabBarController.selectedIndex=2;
    }else if(buttonIndex==1){
        [self presentModally];
    }
}

#pragma mark pop view management
- (void)presentModally
{
    UserRegViewController *vc=[[[UserRegViewController alloc] init] autorelease];
    assert(vc != nil);
    vc.delegate = self;
    [vc presentModallyOn:self];
}

// Called by the number picker when the user chooses a number or taps cancel.
- (void)forward:(UIViewController *)controller
{
    assert(controller != nil);
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex=0;
}

-(NSString *)createJsonParam
{
    //[self performFetch];
    NSError *error;
    NSMutableString *buffer=[NSMutableString stringWithString:@"jsonString={orderGoodsList:["];
    
    NSFetchRequest *request=[[[NSFetchRequest alloc] init] autorelease]; 
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"ShopCart" inManagedObjectContext:self.context]; 
    [request setEntity:entity];
    
    NSArray *arr=[[self.context executeFetchRequest:request error:&error] copy];
    
    for (ShopCart *cart in arr) { 
        if ([cart isEqual:[arr lastObject]]) {
            [buffer appendFormat:@"{goodsId:%d,num:%d}",[cart.productId intValue],[cart.productAmount intValue]];
        }else {
            [buffer appendFormat:@"{goodsId:%d,num:%d},",[cart.productId intValue],[cart.productAmount intValue]];
        }
    }
    [buffer appendFormat:@"],cusId:%@",self.address.cusId];
    [buffer appendFormat:@",recId:%@",self.address.recId];
    [buffer appendString:@",orderType:\"0\"}"];
    [arr release];
    return buffer;
}

#pragma mark payment
-(void) addOrder
{
    NSString *url=[ConstantUtil createRequestURL:ADDORDER_URL withParam:[self createJsonParam]];
	receivedData=[[NSMutableData alloc] initWithData:nil];	
    [DataSource createConn:url delegate:self];
}

-(int) payAction:(NSString *) json
{
    /*
     *商户的唯一的parnter和seller。
     *本demo将parnter和seller信息存于（AlixPayDemo-Info.plist）中,外部商户可以考虑存于服务端或本地其他地方。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    //如果partner和seller数据存于其他位置,请改写下面两行代码
    NSString *partner = [DataSource fetchValueFormJsonObject:json forKey: @"payPartner"];
    NSString *seller = [DataSource fetchValueFormJsonObject:json forKey: @"paySeller"];
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        [UIMakerUtil alert:@"缺少partner或者seller。" title:@"提示"];
        return -1;
    }
    
    /*
     *生成订单信息及签名
     *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    AlixPayOrder *order = [[[AlixPayOrder alloc] init] autorelease];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [DataSource fetchValueFormJsonObject:json forKey: @"out_trade_no"]; //订单ID（由商家自行制定）
    order.productName = [DataSource fetchValueFormJsonObject:json forKey: @"paySubject"]; //商品标题
    order.productDescription = [DataSource fetchValueFormJsonObject:json forKey: @"body"]; //商品描述
    order.amount = [DataSource fetchValueFormJsonObject:json forKey: @"orderMoney"]; //商品价格
    order.notifyURL = [[DataSource fetchValueFormJsonObject:json forKey: @"payNotifyUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //回调URL 
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
    NSString *appScheme = @"xrl"; 
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner([DataSource fetchValueFormJsonObject:json forKey: @"payRsaShopPrivate"]);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
    }
    //获取安全支付单例并调用安全支付接口
    AlixPay * alixpay = [AlixPay shared];
    return [alixpay pay:orderString applicationScheme:appScheme];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==0) {
        NSString *URLString = [NSString stringWithFormat: 
                         @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=333206289"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}
}

@end
