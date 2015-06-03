//
//  UpdatePWDViewController.m
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-8.
//
//

#import "UpdatePWDViewController.h"

@interface UpdatePWDViewController ()

@end

@implementation UpdatePWDViewController

@synthesize titles;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title=@"修改密码";
    self.view.backgroundColor=SYS_BG;
    self.tableView.backgroundView=nil;
    
    self.titles=[NSArray arrayWithObjects:@"旧密码",@"新密码",@"确认密码", nil];
    [self createUI];
}

-(void) createUI
{
    UIButton *loginButton=[UIMakerUtil createImageButton:@"确认修改" image:@"Registration_Confirm" frame:CGRectMake(10, 150, 300, 43)];
    [loginButton addTarget:self action:@selector(updatePWDAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

-(IBAction)updatePWDAction:(id)sender
{
    NSString *oldPwd=((UITextField *)[self.view viewWithTag:100]).text;
    NSString *pwd=((UITextField *)[self.view viewWithTag:101]).text;
    NSString *rePwd=((UITextField *)[self.view viewWithTag:102]).text;
    if (oldPwd && pwd) {
        if ([pwd length]<6 || [pwd length]>12) {
            [UIMakerUtil alert:@"密码长度为6-12位" title:self.title];
            return;
        }
        if ([pwd isEqualToString:rePwd]) {
            NSString *url=[ConstantUtil createRequestURL:UPDATE_PWD_URL];
            ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
            [request addPostValue:[Md5Util md5:oldPwd] forKey:@"oldPwd"];
            [request addPostValue:[Md5Util md5:pwd] forKey:@"newPwd"];
            [request addPostValue:[[[SessionUtil sharedInstance] userInformation] cusId] forKey:@"cusId"];
        }else{
           [UIMakerUtil alert:@"确认密码和新密码不一致" title:self.title];
        }
    }else{
        [UIMakerUtil alert:@"请输入密码" title:self.title];
    }
}

-(CustomCell *) createCell:(int)row reuseIdentifier:(NSString *)reuseIdentifier
{
    CustomCell *cell=[[[CustomCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:reuseIdentifier] autorelease];
    UIView *loginView=[[[UIView alloc] init] autorelease];
    UILabel *rowLabel=[UIMakerUtil createLabel:[self.titles objectAtIndex:row] frame:CGRectMake(20, 10, 70, 20)];
    rowLabel.font=[UIFont systemFontOfSize:16];
    
    UITextField *txtInput=[UIMakerUtil createTextField:CGRectMake(100, 10, 180, 30)];
    txtInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtInput.secureTextEntry=YES;
    txtInput.tag=100+row;           //设定UI识别ID
    [loginView addSubview:txtInput];
    [loginView addSubview:rowLabel];
    [cell setView:loginView];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
    cell = [self createCell:indexPath.row reuseIdentifier:CellIdentifier];
    return cell;
}

#pragma mark - ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *jsonString = [request responseString];
    id jsonValue = [jsonString JSONValue];
    NSString *code = [jsonValue valueForKey:RETURN_CODE];
    if ([code isEqualToString:@"0"]) {
        [UIMakerUtil alert:@"修改密码成功" title:[jsonValue valueForKey:RETURN_MESSAGE]];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [UIMakerUtil alert:[jsonValue valueForKey:RETURN_MESSAGE] title:REQUEST_FAIL];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [UIMakerUtil alert:SERVER_ERROR title:[error localizedDescription]];
}

@end