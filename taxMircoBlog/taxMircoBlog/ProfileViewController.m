//
//  ProfileViewController.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize details,scroll,userinfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人资料";
    self.view.backgroundColor=SYS_BG;
    logoned=[[SessionUtil sharedInstance] isLogined];
    //修改信息
    if (logoned) {
        UIButton *changePWDButton=[UIMakerUtil createImageButton:@"ChangePassword" light:nil frame:CGRectMake(250, 0, 69, 20)];
        [changePWDButton addTarget:self action:@selector(changePWD:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:changePWDButton] autorelease];
        
        self.userinfo=[[SessionUtil sharedInstance] userInformation];
        self.details=[NSArray arrayWithObjects:self.userinfo.email,self.userinfo.nickName?self.userinfo.nickName:@"",self.userinfo.sex?self.userinfo.sex:@"",self.userinfo.phone?self.userinfo.phone:@"",self.userinfo.profession?self.userinfo.profession:@"",self.userinfo.companyName?self.userinfo.companyName:@"",self.userinfo.position?self.userinfo.position:@"", nil];
    }else{      //注册
        self.details=[NSArray arrayWithObjects:self.userinfo.email,@"",@"1",@"",@"",@"",@"", nil];
    }
    [self createUI];
    
    self.navigationItem.backBarButtonItem = [UIMakerUtil createCustomerBackButton:@"back"];
    
    //control=[UIMakerUtil createUIControl:@selector(closeKeyBoard) target:self];
}

-(void)createUI
{
    self.scroll=[UIMakerUtil createScrollView];
    self.scroll.contentSize=CGSizeMake(1,520);
    UIImageView *headerIcon=[UIMakerUtil createImageView:[NSString stringWithFormat:@"head%@",self.userinfo.picHeadNum?self.userinfo.picHeadNum:@"1"] frame:CGRectMake(135, 20, 50, 50)];
    headerIcon.tag=110;
    headerIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap =
    [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeadAction:)] autorelease];
    [headerIcon addGestureRecognizer:singleTap];
    
    UIView *view=[UIMakerUtil createRoundedRectView:CGRectMake(134, 19, 52, 52)];
    [[view layer] setCornerRadius:1.0];
    [self.scroll addSubview:view];
    [self.scroll addSubview:headerIcon];
    
    [self.scroll addSubview:[UIMakerUtil createTableGroupView:CGRectMake(0, 80, self.view.frame.size.width, 330) delegateAndSoruce:self]];
    if (logoned) {
        UIButton *logoutButton=[UIMakerUtil createImageButton:@"注销登录" image:@"logout" frame:CGRectMake(10, 410, 300, 43)];
        [logoutButton addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:logoutButton];
    }else{
        UIButton *loginFinishButton=[UIMakerUtil createImageButton:@"完成注册" image:@"Registration_Confirm" frame:CGRectMake(10, 410, 300, 43)];
        [loginFinishButton addTarget:self action:@selector(finishRegister:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:loginFinishButton];
    }
    [self.view addSubview:scroll];
}

- (NSMutableArray *)prepareDatasource
{
    NSMutableArray *datasource = [[[NSMutableArray alloc] init] autorelease];
    for (int i=0; i<16; i++) {
        UIImage *head=[NSString stringWithFormat:@"head%d",i+1];
        [datasource addObject:head];
    }
    return datasource;
}

-(IBAction)selectHeadAction:(id)sender
{
    [self closeKeyBoard];
    ImagePickerViewController *photoCollectionController = [[ImagePickerViewController alloc] initWithDatasource:[self prepareDatasource]];
    photoCollectionController.title = @"请选择头像";
    photoCollectionController.delegate=self;
    [photoCollectionController presentModallyOn:self];
}

-(IBAction)finishRegister:(id)sender
{
    NSString *nickName=((UITextField *)[self.view viewWithTag:101]).text;
    NSString *phone=((UITextField *)[self.view viewWithTag:103]).text;
    NSString *companyName=((UITextField *)[self.view viewWithTag:105]).text;
    NSString *position=((UITextField *)[self.view viewWithTag:106]).text;
    
    if (![self checkInput:nickName company:companyName position:position]) {
        return;
    }
    
    NSString *url=[ConstantUtil createRequestURL:REG_URL];
    ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
    [request addPostValue:self.userinfo.email forKey:@"email"];
    [request addPostValue:[Md5Util md5:self.userinfo.pwd] forKey:@"password"];
    [request addPostValue:nickName forKey:@"nickName"];
    if (self.userinfo.sex) {
        [request addPostValue:self.userinfo.sex forKey:@"sex"];
    }else{
        [request addPostValue:@"1" forKey:@"sex"];
    }
    if (phone) {
        [request addPostValue:phone forKey:@"phone"];
    }
    if (companyName) {
        [request addPostValue:companyName forKey:@"companyName"];
    }
    if (self.userinfo.profession) {
        [request addPostValue:self.userinfo.profession forKey:@"profession"];
    }else{
        [request addPostValue:@"0" forKey:@"profession"];
    }
    if (position) {
        [request addPostValue:position forKey:@"position"];
    }
    if (self.userinfo.picHeadNum) {
        [request addPostValue:self.userinfo.picHeadNum forKey:@"picHead"];
    }else{
        [request addPostValue:@"1" forKey:@"picHead"];
    }
}

-(IBAction)logout:(id)sender
{
    [UIMakerUtil actionSheet:LOGOUT_MESSAGE delegate:self];
}

-(IBAction)changePWD:(id)sender
{
    UpdatePWDViewController *view=[[[UpdatePWDViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)update
{
    //[control removeFromSuperview];

    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    if (logoned && [self alreadyChangeInput]) {
        [self updateUserInfo];
    }
}

-(BOOL)alreadyChangeInput
{
    NSString *nickName=((UITextField *)[self.view viewWithTag:101]).text;
    NSString *phone=((UITextField *)[self.view viewWithTag:103]).text;
    NSString *companyName=((UITextField *)[self.view viewWithTag:105]).text;
    NSString *position=((UITextField *)[self.view viewWithTag:106]).text;
    if ([companyName isEqualToString:@""]) {
        companyName=nil;
    }
    if ([position isEqualToString:@""]) {
        position=nil;
    }

    return !([nickName isEqualToString:self.userinfo.nickName] && ([companyName isEqualToString:self.userinfo.companyName] ||companyName==self.userinfo.companyName) && ([position isEqualToString:self.userinfo.position] || position==self.userinfo.position) && [phone isEqualToString:self.userinfo.phone]);
}

-(BOOL) checkInput:(NSString *)nickName company: (NSString *)companyName position:(NSString *)position
{
    if (!nickName || [nickName length]<2) {
        [[self.view viewWithTag:101] becomeFirstResponder];
        [UIMakerUtil alert:@"姓名不能为空，且长度为(2-5)" title:self.title];
        return NO;
    }
    
    if (nickName && [nickName length]>5) {
        [[self.view viewWithTag:101] becomeFirstResponder];
        [UIMakerUtil alert:@"姓名长度不能超过5" title:self.title];
        return NO;
    }
    
    if (position && [position length]>50) {
        [[self.view viewWithTag:106] becomeFirstResponder];
        [UIMakerUtil alert:@"职位长度不能超过50" title:self.title];
        return NO;
    }
    
    if (companyName && [companyName length]>100) {
        [[self.view viewWithTag:105] becomeFirstResponder];
        [UIMakerUtil alert:@"公司长度不能超过100" title:self.title];
        return NO;
    }
    
    return YES;
}

-(void) updateUserInfo
{
    NSString *nickName=((UITextField *)[self.view viewWithTag:101]).text;
    NSString *phone=((UITextField *)[self.view viewWithTag:103]).text;
    NSString *companyName=((UITextField *)[self.view viewWithTag:105]).text;
    NSString *position=((UITextField *)[self.view viewWithTag:106]).text;
    
    if (![self checkInput:nickName company:companyName position:position]) {
        return;
    }
    
    NSString *url=[ConstantUtil createRequestURL:UPDATE_USERINFO_URL];
    ASIFormDataRequest *request=[DataSource postRequest:url delegate:self];
    [request addPostValue:self.userinfo.email forKey:@"email"];
    [request addPostValue:nickName forKey:@"nickName"];
    [request addPostValue:self.userinfo.cusId forKey:@"cusId"];
    if (self.userinfo.sex) {
        [request addPostValue:self.userinfo.sex forKey:@"sex"];
    }else{
        [request addPostValue:@"1" forKey:@"sex"];
    }
    if (phone) {
        [request addPostValue:phone forKey:@"phone"];
    }
    if (companyName) {
        [request addPostValue:companyName forKey:@"companyName"];
    }
    if (self.userinfo.profession) {
        [request addPostValue:self.userinfo.profession forKey:@"profession"];
    }else{
        [request addPostValue:@"0" forKey:@"profession"];
    }
    if (position) {
        [request addPostValue:position forKey:@"position"];
    }
    if (self.userinfo.picHeadNum) {
        [request addPostValue:self.userinfo.picHeadNum forKey:@"picHead"];
    }else{
        [request addPostValue:@"1" forKey:@"picHead"];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CustomCell *) createCell:(int)row reuseIdentifier:(NSString *)reuseIdentifier
{
    CustomCell *cell=[[[CustomCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:reuseIdentifier] autorelease];
    UIView *loginView=[[[UIView alloc] init] autorelease];
    NSString *rowText=[TITLE_ARRAY objectAtIndex:row];
    UILabel *rowLabel=[UIMakerUtil createLabel:rowText frame:CGRectMake(20, 10, 57, 20)];
    rowLabel.font=[UIFont systemFontOfSize:16];
    rowLabel.textColor=[UIColor colorWithRed:102.0/255.0 green:115.0/255.0 blue:147.0/255.0 alpha:1.0];
    rowLabel.textAlignment=UITextAlignmentRight;
    
    UITextField *txtInput=[UIMakerUtil createTextField:CGRectMake(82, 10, 190, 30)];
    txtInput.text=[details objectAtIndex:row];
    txtInput.textColor=[UIColor grayColor];
    txtInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtInput.delegate=self;
    txtInput.tag=row+100;
    if (logoned) {
        txtInput.returnKeyType=UIReturnKeyDone;
    }
    [loginView addSubview:txtInput];
    [loginView addSubview:rowLabel];
    [cell setView:loginView];
    return cell;
}

-(void) closeKeyBoard
{
    [self update];
    [[self.view viewWithTag:101] resignFirstResponder];
    [[self.view viewWithTag:103] resignFirstResponder];
    [[self.view viewWithTag:105] resignFirstResponder];
    [[self.view viewWithTag:106] resignFirstResponder];
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row==6 || indexPath.row%2==1) {
        cell = [self createCell:indexPath.row reuseIdentifier:CellIdentifier];
    }else{
        cell.textLabel.text=[TITLE_ARRAY objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        NSString *detail=@"";
        if (indexPath.row==2) {
            detail=[SEX_ARRAY objectAtIndex:[ConstantUtil parseToInt:[details objectAtIndex:indexPath.row]]];
        }else if (indexPath.row==4){
            detail=[PROFESSION_ARRAY objectAtIndex:[ConstantUtil parseToInt:[details objectAtIndex:indexPath.row]]];
        }else{
            detail=[details objectAtIndex:indexPath.row];
        }
        cell.detailTextLabel.text=detail;
        cell.detailTextLabel.textColor=[UIColor grayColor];
    }
    if (indexPath.row>0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selCell= [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row==2) {
        [self presentNumberPickerModally:selCell.detailTextLabel.text array:SEX_ARRAY];
    }else if(indexPath.row==4)
    {
        [self presentNumberPickerModally:selCell.detailTextLabel.text array:PROFESSION_ARRAY];
    }
}

#pragma mark - value picker management
// Displays the number picker so that the user can add a new number to the
// list of numbers to add up.
- (void)presentNumberPickerModally:(NSString *)sel array:(NSArray *) array
{
    [self closeKeyBoard];
    OptionViewController *vc= [self createSelectOptionTableView:array selected:sel];
    assert(vc != nil);
    vc.delegate = self;
    vc.title=@"请选择";
    [vc presentModallyOn:self];
}

-(OptionViewController *)createSelectOptionTableView:(NSArray *)data selected:(NSString *)sel
{
	OptionViewController *selectTable=[[[OptionViewController alloc] init] autorelease];
	selectTable.data=data;
	selectTable.currentIndex=[data indexOfObject:sel];
	
	return selectTable;
}

#pragma mark - Called by the number picker when the user chooses a number or taps cancel.
- (void)numberPicker:(OptionViewController *)controller didChooseNumber:(int)row
{
    assert(controller != nil);
    // If it wasn't cancelled...
    if (row >=0) {
		if ([controller.data count]==2) {
            self.userinfo.sex=[NSString stringWithFormat:@"%d",row];
            selCell.detailTextLabel.text=[SEX_ARRAY objectAtIndex:row];
        }else{
            self.userinfo.profession=[NSString stringWithFormat:@"%d",row];
            selCell.detailTextLabel.text=[PROFESSION_ARRAY objectAtIndex:row];
        }
    }
    [selCell setSelected:NO];
    if (logoned) {
        [self updateUserInfo];
    }
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - PickerDelegate Methods
- (void)imagePicker:(ImagePickerViewController *)view didChoose:(int)tag
{
    if(tag>=0){
        UIImageView *head=(UIImageView *)[self.view viewWithTag:110];
        head.image=[UIImage imageNamed:[NSString stringWithFormat:@"head%d",tag+1]];
        self.userinfo.picHeadNum=[NSString stringWithFormat:@"%d",tag+1];
    }
    if (logoned) {
        [self updateUserInfo];
    }
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL destructiveClicked=actionSheet.destructiveButtonIndex==buttonIndex;
    if (destructiveClicked) {
        [[SessionUtil sharedInstance] logout];
        [CookieUtil clearCookies];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark- KeyboardDelegate methods解决虚拟键盘挡住UITextField的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self update];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //[self.view addSubview:control];             //加入点击界面其他地方，隐藏键盘的控制
    int index=textField.tag-100+1;
    int offset = 80 + index*30 - 320 + 252.0;   //键盘高度216,ios5中文键盘为252
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

#pragma mark - ASIHTTPRequest delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *jsonString = [request responseString];
    id jsonValue = [jsonString JSONValue];
    NSString *code = [jsonValue valueForKey:RETURN_CODE];
    if ([code isEqualToString:@"0"]) {
        if (!logoned) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSString *nickName=((UITextField *)[self.view viewWithTag:101]).text;
            NSString *phone=((UITextField *)[self.view viewWithTag:103]).text;
            NSString *companyName=((UITextField *)[self.view viewWithTag:105]).text;
            NSString *position=((UITextField *)[self.view viewWithTag:106]).text;
            SessionUtil *session=[SessionUtil sharedInstance];
            UserInfo *info=self.userinfo;
            info.nickName=nickName;
            info.position=position;
            info.companyName=companyName;
            info.phone=phone;
            session.userInformation=info;
            [session updateProfile];
        }
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