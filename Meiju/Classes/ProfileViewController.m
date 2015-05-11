//
//  MyMeijuViewController.m
//  Meiju
//
//  Created by Simon Zhou on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize retArray;

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

	if ([[DataSource fetchValueFormJsonObject:json forKey:@"methodCode"] isEqualToString:@"0"]) {
        self.retArray=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[DataSource fetchValueFormJsonObject:json forKey:@"notPay"]],[NSString stringWithFormat:@"%@",[DataSource fetchValueFormJsonObject:json forKey:@"notDeliver"]],[NSString stringWithFormat:@"%@",[DataSource fetchValueFormJsonObject:json forKey:@"alreadyDeliver"]] , nil];
    }
    
	[self createTableView];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void) createTableView
{
    [self.view addSubview:[UIMakerUtil createTableView:CGRectMake(0, 120, self.view.frame.size.width, 300) delegateAndSoruce:self]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)exitAction:(id)sender
{
    [UIMakerUtil actionSheet:@"确定要退出吗?" delegate:self];
}

-(IBAction)setup:(id)sender
{
    EditProfileViewController *view=[[[EditProfileViewController alloc] init] autorelease];
    [self.navigationController pushViewController:view animated:YES];
}

-(void) createUI
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"退出" andTarget:self andSelector:@selector(exitAction:)];
    
    // Do any additional setup after loading the view from its nib.
    CGRect rect=CGRectMake(50, 10, 100, TITLE_HEIGHT);
    [self.view addSubview:[UIMakerUtil createLabelWithBg:@"帐号:" frame:rect]];
    rect.origin.x=160;
    rect.size.width+=20;
    [self.view addSubview:[UIMakerUtil createLabelWithBg:userInfo.account frame:rect]];
    
    rect.origin.y+=TITLE_HEIGHT+10;
    userName.frame=rect;
    [self.view addSubview:userName];
    rect.origin.x=50;
    rect.size.width-=20;
    [self.view addSubview:[UIMakerUtil createLabelWithBg:@"姓名:" frame:rect]];
    UIButton *button=[UIMakerUtil createImageButton:@"setup" light:@"setuped" point:CGPointMake(280, rect.origin.y+12.5)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(setup:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.y+=TITLE_HEIGHT+10;
    [self.view addSubview:[UIMakerUtil createLabelWithBg:@"联系电话:" frame:rect]];
    rect.origin.x=160;
    telephone.frame=rect;
    [self.view addSubview:telephone];
    
    rect.origin.y+=TITLE_HEIGHT+10;
    mail.frame=rect;
    [self.view addSubview:mail];
    rect.origin.x=50;
    [self.view addSubview:[UIMakerUtil createLabelWithBg:@"邮箱:" frame:rect]];    
    
    NSString *url=[ConstantUtil createRequestURL:ORDER_STATUE_URL withParam:[NSString stringWithFormat:@"&cusId=%@",userInfo.cusId]];
    receivedData=[[NSMutableData alloc] initWithData:nil];
	[DataSource createConn:url delegate:self];

}

-(void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];
    if ([[SessionUtil sharedInstance] isLogined]) {
        userInfo=[SessionUtil sharedInstance].userInformation;
        telephone=[UIMakerUtil createLabel];
        telephone.text=userInfo.phoneNum;
        userName=[UIMakerUtil createLabel];
        userName.text=userInfo.cusName;
        mail=[UIMakerUtil createLabel];
        mail.text=userInfo.email;
        [self createUI];
    }else {
        [self presentModally];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的魅車";
    self.navigationController.navigationBar.tintColor=ORANGE_BG;
    self.view.backgroundColor=SYS_BG;
}



#pragma mark pop view management
- (void)presentModally
{
    UserViewController *vc=[[[UserViewController alloc] init] autorelease];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [retArray release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL destructiveClicked=actionSheet.destructiveButtonIndex==buttonIndex;
    if (destructiveClicked) {
        [[SessionUtil sharedInstance] logout];
        [UserViewController clearCookies];
        [self forward:self];
    }
}

#pragma mark table delegate management
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	if (section==0) {
        return 3;
    }else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleValue1;
	UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
	// Set cell label
    if (indexPath.section==0) { 
        if (indexPath.row==0) {
            cell.imageView.image=[UIMakerUtil createImageView:@"unpayment"].image;
            cell.textLabel.text = @"待付款订单";
             
        }else if (indexPath.row==1) {
            cell.imageView.image=[UIMakerUtil createImageView:@"undelivery"].image;
            cell.textLabel.text = @"待发货订单";
        }else if (indexPath.row==2) {
            cell.imageView.image=[UIMakerUtil createImageView:@"deliveried"].image;
            cell.textLabel.text = @"已发货订单";
        }
        cell.detailTextLabel.text = [self.retArray objectAtIndex:indexPath.row];
    }else if (indexPath.section==1) {
        cell.imageView.image=[UIMakerUtil createImageView:@"favorites"].image;
        cell.textLabel.text = @"我的收藏";
    }else if (indexPath.section==2) {
        cell.imageView.image=[UIMakerUtil createImageView:@"address"].image;
        cell.textLabel.text = @"收货地址设置";
    }
	cell.editingAccessoryType = UITableViewCellAccessoryNone;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *view=nil;
    if (indexPath.section==0) {
        if ([[self.retArray objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            [UIMakerUtil alert:@"此栏无订单." title:self.title];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
        }
        if (indexPath.row==0) {
            view=[[[OrderViewController alloc] init] autorelease];
        }else if (indexPath.row==1) {
             view=[[[OrderViewController alloc] init] autorelease];
        }else if (indexPath.row==2) {
             view=[[[OrderViewController alloc] init] autorelease];
        }
        ((OrderViewController *)view).cate=indexPath.row;
    }else if (indexPath.section==1) {
         view=[[[FavoritesViewController alloc] init] autorelease];
    }else if (indexPath.section==2) {
         view=[[[AddressViewController alloc] init] autorelease];
    }

    [self.navigationController pushViewController:view animated:YES];
	
}

@end
