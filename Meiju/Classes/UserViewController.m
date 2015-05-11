//
//  UserViewController.m
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UserViewController.h"
#import "UIMakerUtil.h"
#import "UserRegViewController.h"


@implementation UserViewController

@synthesize textField_Username,weiBoEngine;
@synthesize textField_Password;
@synthesize userRegViewController;
@synthesize delegate,_tencentOAuth,loginConn,queryConn,regConn,associateConn;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
    if ([self.loginConn isEqual:connection]) {
        NSString *result= (NSString *)[DataSource fetchValueFormJsonObject:json forKey:@"resultCode"];
        if([result isEqualToString:@"0"]){
            //登录成功,保存持久化信息
            [self login:json];
            [self.delegate dismissModalViewControllerAnimated:YES];

        }else {
            //登录失败
            [UIMakerUtil alert:@"您输入的账号或密码不正确，请重试。" title:@"Login"];
        }
    }else if ([self.queryConn isEqual:connection]){
        NSString *result= (NSString *)[DataSource fetchValueFormJsonObject:json forKey:@"resultCode"];
        if([result isEqualToString:@"0"]){
            if ([DataSource fetchValueFormDictionary:json forKey:@"cusId"]!=nil) {
                [self login:json];
                [self.delegate dismissModalViewControllerAnimated:YES];
            }else {
                [self createUser];
            }
            
        }
    }else if ([self.regConn isEqual:connection]) {
        NSString *result= (NSString *)[DataSource fetchValueFormJsonObject:json forKey:@"resultCode"];
        if([result isEqualToString:@"0"]){
            [self associate:[DataSource fetchValueFormJsonObject:json forKey:@"cusId"]];
        }else {
            [UIMakerUtil alert:@"帐号异常,请用其他第三方帐号尝试登录。" title:self.title];
        }
    }else if ([associateConn isEqual:connection]) {
        NSString *result= (NSString *)[DataSource fetchValueFormJsonObject:json forKey:@"resultCode"];
        NSString *methodCode= (NSString *)[DataSource fetchValueFormJsonObject:json forKey:@"methodCode"];
        if([result isEqualToString:@"0"] && [methodCode isEqualToString:@"0"]){ 
            [self.delegate dismissModalViewControllerAnimated:YES];
        }
    }
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void) associate:(NSString *) custId
{
    NSString *param=nil;
    if (weiBoEngine) {
        param=[NSString stringWithFormat:@"openId=%@&cusId=%@&openType=0",weiBoEngine.userID,custId];
    }
    if (_tencentOAuth) {
        param=[NSString stringWithFormat:@"openId=%@&cusId=%@&openType=0",_tencentOAuth.openId,custId];
    }
    NSString *url=[ConstantUtil createRequestURL:ASSOCIATE_USER_URL];
    receivedData=[[NSMutableData alloc] initWithData:nil];
    self.associateConn=[DataSource createPostConn:url param:param delegate:self];
}

-(void) createUser
{
    if (weiBoEngine) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSString *userName =[[pasteboard.string componentsSeparatedByString:@"@"] objectAtIndex:0];
        if ([userName length]>12 || [userName length]<4) {
            userName=[ConstantUtil createShortUUID];
        }
        NSString *param=[NSString stringWithFormat:@"cusName=%@&account=%@&phoneNum=13800138000&cusPwd=%@&email=%@",userName,userName,[[Md5Util md5:userName] uppercaseString],pasteboard.string];
        NSString *url=[ConstantUtil createRequestURL:USER_REG_URL];
        receivedData=[[NSMutableData alloc] initWithData:nil];
        self.regConn=[DataSource createPostConn:url param:param delegate:self];
    }
    if (_tencentOAuth) {
        [_tencentOAuth getUserInfo];
    }
}

/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSString *param=[NSString stringWithFormat:@"cusName=%@&account=%@&phoneNum=13800138000&cusPwd=%@&email=%@@qq.com",[response.jsonResponse objectForKey:@"nickname"],pasteboard.string,[[Md5Util md5:pasteboard.string] uppercaseString],pasteboard.string];
        NSString *url=[ConstantUtil createRequestURL:USER_REG_URL];
        receivedData=[[NSMutableData alloc] initWithData:nil];
        self.regConn=[DataSource createPostConn:url param:param delegate:self];
	}
	else {
        [UIMakerUtil alert:[NSString stringWithFormat:@"%", response.errorMsg] title:@"操作失败"];
	}
}

-(void) login:(NSString *) json
{
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[DataSource fetchValueFormDictionary:json forKey:@"cusId"] forKey:@"cusId"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[DataSource fetchValueFormDictionary:json forKey:@"account"] forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[DataSource fetchValueFormDictionary:json forKey:@"cusName"] forKey:@"cusName"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[DataSource fetchValueFormDictionary:json forKey:@"phoneNum"] forKey:@"phoneNum"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[DataSource fetchValueFormDictionary:json forKey:@"email"] forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[DataSource fetchValueFormDictionary:json forKey:@"score"] forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[DataSource fetchValueFormDictionary:json forKey:@"grade"] forKey:@"grade"];
    if (_tencentOAuth!=nil) {
        [[NSUserDefaults standardUserDefaults] setValue:_tencentOAuth forKey:@"tencent"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SessionUtil sharedInstance].isLogined=YES;
    
    UserInfo *userInformation=[[[UserInfo alloc] init] autorelease];
    userInformation.cusId=[[NSUserDefaults standardUserDefaults] stringForKey:@"cusId"];
    userInformation.account=[[NSUserDefaults standardUserDefaults] stringForKey:@"account"];
    userInformation.cusName=[[NSUserDefaults standardUserDefaults] stringForKey:@"cusName"];
    userInformation.phoneNum=[[NSUserDefaults standardUserDefaults] stringForKey:@"phoneNum"];
    userInformation.email=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    userInformation.score=[[NSUserDefaults standardUserDefaults] stringForKey:@"score"];
    userInformation.grade=[[NSUserDefaults standardUserDefaults] stringForKey:@"grade"];
    if (_tencentOAuth) {
        userInformation.tencentAuth=_tencentOAuth;
    }
    if (weiBoEngine) {
        userInformation.weiboAuth=weiBoEngine;
    }
    
    [SessionUtil sharedInstance].userInformation=userInformation; 
    
    [self writeCookie:userInformation];
}

-(void) writeCookie :(UserInfo *)userInformation
{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"cusId" forKey:NSHTTPCookieName];
    [cookieProperties setObject:userInformation.cusId forKey:NSHTTPCookieValue];
    [self processCookie:cookieProperties];
    
    [cookieProperties setObject:@"account" forKey:NSHTTPCookieName];
    [cookieProperties setObject:userInformation.account forKey:NSHTTPCookieValue];
    [self processCookie:cookieProperties];
    
    [cookieProperties setObject:@"cusName" forKey:NSHTTPCookieName];
    [cookieProperties setObject:userInformation.cusName forKey:NSHTTPCookieValue];
    [self processCookie:cookieProperties];
    
    [cookieProperties setObject:@"phoneNum" forKey:NSHTTPCookieName];
    [cookieProperties setObject:userInformation.phoneNum forKey:NSHTTPCookieValue];
    [self processCookie:cookieProperties];
    
    [cookieProperties setObject:@"email" forKey:NSHTTPCookieName];
    [cookieProperties setObject:userInformation.email forKey:NSHTTPCookieValue];
    [self processCookie:cookieProperties];

}

-(void) processCookie:(NSMutableDictionary *)cookieProperties
{
    [cookieProperties setObject:APP_HOST forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:APP_HOST forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:[NSDate dateWithTimeIntervalSinceNow:15*24*60*60] forKey:NSHTTPCookieExpires];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

+(void) loginWithCookie:(NSDictionary *) dic
{
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"cusId"] forKey:@"cusId"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"account"] forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"cusName"] forKey:@"cusName"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"phoneNum"] forKey:@"phoneNum"];
    [[NSUserDefaults standardUserDefaults] setValue:(NSString *)[dic objectForKey:@"email"] forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SessionUtil sharedInstance].isLogined=YES;
    
    UserInfo *userInformation=[[[UserInfo alloc] init] autorelease];
    userInformation.cusId=[[NSUserDefaults standardUserDefaults] stringForKey:@"cusId"];
    userInformation.account=[[NSUserDefaults standardUserDefaults] stringForKey:@"account"];
    userInformation.cusName=[[NSUserDefaults standardUserDefaults] stringForKey:@"cusName"];
    userInformation.phoneNum=[[NSUserDefaults standardUserDefaults] stringForKey:@"phoneNum"];
    userInformation.email=[[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    [SessionUtil sharedInstance].userInformation=userInformation; 
}

+(void) clearCookies
{
    NSArray* cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.title=@"用户";
    self.navigationController.navigationBar.tintColor=ORANGE_BG;
	self.view.backgroundColor = SYS_BG;
    
    textField_Password.secureTextEntry=YES;
    //textField_Username.returnKeyType=UIReturnKeyNext;
    //textField_Username.enablesReturnKeyAutomatically=YES;
    //textField_Password.returnKeyType=UIReturnKeyGo;
    //textField_Password.enablesReturnKeyAutomatically=YES;

    userRegViewController = [[UserRegViewController alloc] init];
    ((UserRegViewController *)userRegViewController).delegate=self.delegate;
    
    UIButton *regButton=[UIMakerUtil createImageButton:@"注册" point:CGPointMake(80,200)];
    [regButton addTarget:self action:@selector(buttonPressed_Reg:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *loginButton=[UIMakerUtil createImageButton:@"登录" point:CGPointMake(230,200)];
    [loginButton addTarget:self action:@selector(buttonPressed_Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];
    [self.view addSubview:loginButton];
    
    [self.view addSubview:[UIMakerUtil createTableView:CGRectMake(0, 220, SCREEN_WIDTH, 120) delegateAndSoruce:self]];
}


- (void)presentModallyOn:(UIViewController *)parent
{
    UINavigationController *nav;
	
    // Create a navigation controller with us as its root.
    nav = [[[UINavigationController alloc] initWithRootViewController:self] autorelease];
    assert(nav != nil);
	
    // Set up the Cancel button on the left of the navigation bar.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)] autorelease];
    assert(self.navigationItem.leftBarButtonItem != nil);

    // Present the navigation controller on the specified parent 
    // view controller.
    
    [parent presentModalViewController:nav animated:YES];
}

- (void)cancelAction:(id)sender
{	
    // Tell the delegate about the cancellation.
    if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(forward:)] )
    {
        [self.delegate forward:self];
    }
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [textField_Password release];
}


- (void)dealloc {
    [super dealloc];
    [textField_Username release];
    [weiBoEngine release];
    [textField_Password release];
    [userRegViewController release];
    [delegate release];
    [_tencentOAuth release];
    [loginConn release];
    [queryConn release];
    [regConn release];
    [associateConn release];
}

-(void)tencentDidLogin
{
    NSString *param=[NSString stringWithFormat:@"openId=%@&openType=0",_tencentOAuth.openId];
    NSString *url=[ConstantUtil createRequestURL:QUERY_OPEN_USER_URL withParam:param];
    receivedData=[[NSMutableData alloc] initWithData:nil];
    self.queryConn=[DataSource createConn:url delegate:self];
}

//用户登录
-(IBAction)buttonPressed_Login:(id)sender
{
    //验证数据
    if(![self CheckInput])
	{
        return;
    }
    
    //访问用户登录接口(委托方式)
    NSString *param=@"account=";
    param=[param stringByAppendingString:[self.textField_Username text]];
    param=[param stringByAppendingString:@"&cusPwd="];
    param=[param stringByAppendingString:[[Md5Util md5:[self.textField_Password text]] uppercaseString]];

    NSString *url=[ConstantUtil createRequestURL:USER_LOGIN_URL];
    receivedData=[[NSMutableData alloc] initWithData:nil];
	self.loginConn=[DataSource createPostConn:url param:param delegate:self];
}

//用户注册
-(IBAction)buttonPressed_Reg:(id)sender
{
    [[self navigationController] pushViewController:userRegViewController animated:YES];
}

-(BOOL)CheckInput
{
    //验证用户输入内容
    NSString *username = textField_Username.text;
    NSString *password = textField_Password.text;
    
    if( [[username trim] isEqualToString:@""] ){
        [UIMakerUtil alert:@"请输入用户名。" title:@"Login"];
        return NO;
    }
    
    if( [[password trim] isEqualToString:@""]){
        [UIMakerUtil alert:@"请输入密码。" title:@"Login"];
        return NO;
    }
    
    return YES;
}

//键盘RETURN委托
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    /*if ([textField isEqual: textField_Username]) {
        [textField_Password becomeFirstResponder];
    }
    if ([textField isEqual: textField_Password]) {
        [self buttonPressed_Login:nil];
    }*/
    [textField resignFirstResponder];
    return YES;
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    NSString *param=[NSString stringWithFormat:@"openId=%@&openType=0",engine.userID];
    NSString *url=[ConstantUtil createRequestURL:QUERY_OPEN_USER_URL withParam:param];
    receivedData=[[NSMutableData alloc] initWithData:nil];
    self.queryConn=[DataSource createConn:url delegate:self];
}

#pragma mark table delegate management
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	// Set cell label
    if (indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"weibo"];
        cell.textLabel.text = @"新浪微博";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }else {
        cell.imageView.image=[UIImage imageNamed:@"qq"];
        cell.textLabel.text = @"QQ";
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBSDKDemoAppKey appSecret:kWBSDKDemoAppSecret];
        [engine setRootViewController:self];
        [engine setDelegate:self];
        [engine setRedirectURI:@"http://www.meijumall.com/"];
        [engine setIsUserExclusive:NO];
        self.weiBoEngine = engine;
        [engine logIn];
        [engine release];
    }else {
        NSArray *_permissions =  [NSArray arrayWithObjects:
                          @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album", 
                          @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil];
       _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"100261163"
                                                andDelegate:self];
        _tencentOAuth.redirectURI = @"www.qq.com";
       [_tencentOAuth authorize:_permissions inSafari:NO]; 
    }
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"合作网站帐号登录";
}


@end
