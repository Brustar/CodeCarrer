//
//  MoreViewController.m
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"


@implementation MoreViewController

-(IBAction)userAction:(id)sender
{
    if ([[SessionUtil sharedInstance] isLogined]) {
        [UIMakerUtil actionSheet:EXIT_MESSAGE delegate:self];
    }else {
        //self.tabBarController.selectedIndex=2;
        [self presentModally];
    }
    
}

- (void)presentModally
{
    UserViewController *vc=[[[UserViewController alloc] init] autorelease];
    assert(vc != nil);
    vc.delegate = self;
    [vc presentModallyOn:self];
}

- (void)forward:(UIViewController *)controller
{
    assert(controller != nil);
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex=0;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"更多";
    self.navigationController.navigationBar.tintColor=ORANGE_BG;
    
    [self.tableView initWithFrame:self.view.frame style:UITableViewStyleGrouped];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark UIAlertViewDelegate Methods 
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [[SessionUtil sharedInstance] logout];
        self.tabBarController.selectedIndex=2;
    }
}

#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL destructiveClicked=actionSheet.destructiveButtonIndex==buttonIndex;
    if (destructiveClicked) {
        [[SessionUtil sharedInstance] logout];
        [UserViewController clearCookies];
        self.tabBarController.selectedIndex=0;
    }
    
    if (buttonIndex==0) {
        if (![actionSheet.title isEqualToString:EXIT_MESSAGE]) {
            [self showSMSPicker:nil]; 
        }
    }else if (buttonIndex==1) {
        if (![actionSheet.title isEqualToString:EXIT_MESSAGE]) {
            [self sendEMail];
        }
    }else if (buttonIndex==2) {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"魅車商城软件分享", @"title",
                                       APPSTORE_LINK_URL, @"url",
                                       @"魅車商城1.0上线啦!",@"comment",
                                       COMMENT_CONTENT,@"summary",
                                       ICON_URL,@"images",
                                       @"4",@"source",
                                       nil];
        
        if ([[SessionUtil sharedInstance] isLogined]) {
            UserInfo *info=[[SessionUtil sharedInstance] userInformation];
            if (info.tencentAuth) {
                TencentOAuth *auth=(TencentOAuth *)info.tencentAuth;
                if ([info.tencentAuth isSessionValid] && [auth isOpenIdValid]) {
                    [auth addShareWithParams:params];
                    [UIMakerUtil alert:@"已经发布到你的QQ分享" title:self.title];
                }
            }else {
                [UIMakerUtil alert:@"请用你的QQ登录,然后再分享" title:self.title];
            }
        }else {
            [UIMakerUtil alert:@"你还没有登录" title:self.title];
        }

    }else if (buttonIndex==3) {
        if ([[SessionUtil sharedInstance] isLogined]) {
            UserInfo *info=[[SessionUtil sharedInstance] userInformation];
            if (info.weiboAuth) {
                NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:ICON_URL]];
                [info.weiboAuth sendWeiBoWithText:COMMENT_CONTENT image:[UIImage imageWithData:imageData]];
                [UIMakerUtil alert:@"已经发布到你的微博" title:self.title];
                
            }else {
                [UIMakerUtil alert:@"请用你的微博登录,然后再分享" title:self.title];
            }
        }else {
            [UIMakerUtil alert:@"你还没有登录" title:self.title];
        }
    }
}

-(IBAction)share:(id)sender
{

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
    }else if (section==1) {
        return 3;
    }else {
        return 2;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleValue1;
	UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];

    cell.textLabel.font = [UIFont systemFontOfSize:14];
	// Set cell label
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.imageView.image=[UIMakerUtil createImageView:@"store"].image;
            cell.textLabel.text = CONTRACT_STORE;
        }else if (indexPath.row==1) {
            cell.imageView.image=[UIMakerUtil createImageView:@"report"].image;
            cell.textLabel.text = INSURANCE_REPORTCASE;
        }else {
            cell.imageView.image=[UIMakerUtil createImageView:@"knowledge"].image;
            cell.textLabel.text = CAR_KNOWLEDGE;
        }
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            cell.imageView.image=[UIMakerUtil createImageView:@"help"].image;
            cell.textLabel.text = HELP_TITLE;
        }else if (indexPath.row==1) {
            cell.imageView.image=[UIMakerUtil createImageView:@"feedback"].image;
            cell.textLabel.text = FEEDBACK_TITLE;
        }else if (indexPath.row==2) {
            cell.imageView.image=[UIMakerUtil createImageView:@"share"].image;
            cell.textLabel.text = SOFT_SHARE;
        }
    }else {
       if (indexPath.row==0) {
           cell.imageView.image=[UIMakerUtil createImageView:@"about"].image;
           cell.textLabel.text = ABOUT_TITLE;
       }else {
           if ([[SessionUtil sharedInstance] isLogined]) {
               cell.imageView.image=[UIMakerUtil createImageView:@"exit"].image;
               cell.textLabel.text = EXIT_TITLE;
               cell.detailTextLabel.text =[[[SessionUtil sharedInstance] userInformation] cusName];
           }else {
               cell.imageView.image=[UIMakerUtil createImageView:@"user"].image;
               cell.textLabel.text = @"您还未登录";
               cell.detailTextLabel.text = @"登录/注册";
           }
       }
    }

	cell.editingAccessoryType = UITableViewCellAccessoryNone;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *view=nil;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            view=[[[StoreViewController alloc] init] autorelease];
        }else if (indexPath.row==1) {
            view=[[[ReportCaseViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
        }else {
            view=[[[KnowledgeViewController alloc] init] autorelease];
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            view=[[[HelpViewController alloc] init] autorelease];
        }else if (indexPath.row==1) {
            view=[[[FeedBackViewController alloc] init] autorelease];
        }else if (indexPath.row==2) {
            [UIMakerUtil actionSheet:SOFT_SHARE delegate:self addButton:@"短信",@"邮件",@"QQ分享",@"微博分享",nil]; 
        }
    }else {
        if (indexPath.row==0) {
            view=[[[AboutViewController alloc] init] autorelease];
        }else if (indexPath.row==1) {
            [self userAction:nil];
        }
    }
    
    if (!(indexPath.section==2 && indexPath.row==1) && !(indexPath.section==1 && indexPath.row==2)){
        [self.navigationController pushViewController:view animated:YES];
    }
    else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
	
}

#pragma mark -
#pragma mark SMS

-(IBAction)showSMSPicker:(id)sender {
	//	The MFMessageComposeViewController class is only available in iPhone OS 4.0 or later.
	//	So, we must verify the existence of the above class and log an error message for devices
	//		running earlier versions of the iPhone OS. Set feedbackMsg if device doesn't support
	//		MFMessageComposeViewController API.
	Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
	if (messageClass != nil) {
		// Check whether the current device is configured for sending SMS messages
		if ([messageClass canSendText]) {
			[self displaySMSComposerSheet];
		}
		else {
            [UIMakerUtil alert:@"设备没有短信功能" title:self.title];
		}
	}
	else {
        [UIMakerUtil alert:@"iOS版本过低,iOS4.0以上才支持程序内发送短信" title:self.title];
	}
}

-(void)displaySMSComposerSheet
{
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
    
	picker.body=COMMENT_CONTENT;
	
	[self presentModalViewController:picker animated:YES];
	[picker release];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
				 didFinishWithResult:(MessageComposeResult)result {
    
	switch (result)
	{
		case MessageComposeResultCancelled:
			NSLog(@"Result: SMS sending canceled");
			break;
		case MessageComposeResultSent:
			NSLog(@"Result: SMS sent");
            [UIMakerUtil alert:@"短信推荐成功" title:self.title];
			break;
		case MessageComposeResultFailed:
            [UIMakerUtil alert:@"短信发送失败" title:self.title];
			break;
		default:
			NSLog(@"Result: SMS not sent");
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark 发送邮件，点击按钮后，触发这个方法  
-(void)sendEMail   
{  
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));  
    
    if (mailClass != nil)  
    {  
        if ([mailClass canSendMail])  
        {  
            [self displayComposerSheet];  
        }   
        else   
        {  
            [self launchMailAppOnDevice];  
        }  
    }   
    else   
    {  
        [self launchMailAppOnDevice];  
    }      
}  
//可以发送邮件的话  
-(void)displayComposerSheet   
{  
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];  
    
    mailPicker.mailComposeDelegate = self;  
    
    //设置主题  
    [mailPicker setSubject: [ConstantUtil fetchValueFromPlistFile:APP_NAME_KEY]];  
    
    // 添加发送者  
    NSArray *toRecipients = nil;   
    [mailPicker setToRecipients: toRecipients];  
    
    // 添加图片  
    UIImage *addPic = [UIImage imageNamed: @"aboutus"];  
    NSData *imageData = UIImagePNGRepresentation(addPic); // png   
    [mailPicker addAttachmentData: imageData mimeType: @"png" fileName: @"aboutus.png"];  
    
    NSString *emailBody = COMMENT_CONTENT;  
    [mailPicker setMessageBody:emailBody isHTML:YES];  
    
    [self presentModalViewController: mailPicker animated:YES];  
    [mailPicker release];  
} 

-(void)launchMailAppOnDevice  
{  
    NSString *recipients =[NSString stringWithFormat: @"&subject=%@",[ConstantUtil fetchValueFromPlistFile:APP_NAME_KEY]];   
    NSString *body = [NSString stringWithFormat: @"&body=%@",COMMENT_CONTENT];  
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];  
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  

    [UIMakerUtil sysApplicationCall:email protocol:MAIL_PROTOCOL];
}  
- (void)mailComposeController:(MFMailComposeViewController *)controller   
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error   
{   
    switch (result)   
    {  
        case MFMailComposeResultCancelled:  
            //msg = @"邮件发送取消";  
            break;  
        case MFMailComposeResultSaved:    
            [UIMakerUtil alert:@"邮件保存成功" title:self.title];
            break;  
        case MFMailComposeResultSent:  
            [UIMakerUtil alert: @"邮件发送成功" title:self.title];  
            break;  
        case MFMailComposeResultFailed:  
 
            [UIMakerUtil alert:@"邮件发送失败" title:self.title];  
            break;  
        default: 
            break;  
    }  
    [self dismissModalViewControllerAnimated:YES];  
}  


@end