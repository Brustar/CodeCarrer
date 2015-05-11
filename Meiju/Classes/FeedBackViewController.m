//
//  FeedBackViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedBackViewController.h"
#import "MoreViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

@synthesize cateArray,contactText,contentView,selValue;

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

    NSString *message=[DataSource fetchJSONValueFormServer:json forKey:RETURN_MESSAGE];
    [UIMakerUtil alert:message title:FEEDBACK_TITLE];
    if ([[DataSource fetchJSONValueFormServer:json forKey:RETURN_CODE] isEqualToString:@"0"]) {
        self.contactText.text=@"";
        self.contentView.text=@"";
        [self.contactText resignFirstResponder];
        [self.contentView resignFirstResponder];
        self.selValue=[self.cateArray objectAtIndex:0];
        cell.detailTextLabel.text=self.selValue;
    }
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) createUI
{
    CGRect rect=CGRectMake(0, 0, self.view.frame.size.width, 55);
    //UILabel *cate=[UIMakerUtil createTitleLabel:@"问题类型:" frame:rect];
    cateTable=[UIMakerUtil createTableView:rect delegateAndSoruce:self];
    [self.view addSubview:cateTable];

    self.cateArray=[NSArray arrayWithObjects:@"购买咨询",@"内容问题",@"功能意见",@"界面意见",@"操作意见",@"您的新需求",@"流量问题",@"其他", nil];
    self.selValue=[self.cateArray objectAtIndex:0];
    
    rect.origin.x=10;
    rect.origin.y+=35;
    rect.size.width=80;
    UILabel *content=[UIMakerUtil createLabel:@"反馈内容:" frame:rect];
    //self.cateTable=[UIMakerUtil createTableView:rect delegateAndSoruce:self];
    [self.view addSubview:content];

    rect.origin.y+=40;
    rect.size.width=self.view.frame.size.width-30;
    rect.size.height=70;
    self.contentView=[UIMakerUtil createTextView:rect];
    [self.contentView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.contentView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.contentView.layer setBorderWidth: 1.4];
    [self.contentView.layer setCornerRadius:8.0f];
    [self.contentView.layer setMasksToBounds:YES];
    //contentView.delegate=self;
    [self.view addSubview:self.contentView];
    
    rect.origin.y+=50;
    UILabel *contact=[UIMakerUtil createLabel:@"联系方式:" frame:rect];
    [self.view addSubview:contact];
    
    rect.origin.y+=45;
    rect.size.height=30;
    self.contactText=[UIMakerUtil createTextField:rect];
    self.contactText.placeholder = @"您的姓名，手机号，邮箱等";//设置默认显示文本
    self.contactText.delegate=self;
    [self.view addSubview:self.contactText];
    
    UIToolbar * topView = [[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];  
    [topView setBarStyle:UIBarStyleBlack];  
    
    UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextInput)];  
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];  
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];  
    
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];  
    [doneButton release];  
    [btnSpace release];  
    [helloButton release];  
    
    [topView setItems:buttonsArray];  
    [self.contentView setInputAccessoryView:topView];  
    
 
}

-(IBAction)nextInput
{
    [self.contactText becomeFirstResponder];
}

-(IBAction)dismissKeyBoard  
{  
    [self.contentView resignFirstResponder];  
} 

-(void)feedbackAction
{
    if ([[[self.contentView text] trim] isEqualToString:@""]) {
        [UIMakerUtil alert:@"反馈内容不能为空" title:FEEDBACK_TITLE];
        return;
    }
    
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:FEEDBACK_URL];
    NSInteger quesType=[self.cateArray indexOfObject:self.selValue];
    NSString *param=[NSString stringWithFormat:@"&quesType=%d&content=%@&contactMethod=%@",quesType,self.contentView.text,self.contactText.text?self.contactText.text:@""];
    [DataSource createPostConn:url param:param delegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=FEEDBACK_TITLE;
    self.view.backgroundColor=SYS_BG;

    UIBarButtonItem *done = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(feedbackAction)] autorelease]; 

    self.navigationItem.rightBarButtonItem = done;  
    [self createUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark KeyBoardDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextView Delegate Methods  
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text  
{  
    if ([text isEqualToString:@"\n"]) {  
        [textView resignFirstResponder];  
        return NO;  
    }  
    return YES;  
} 

#pragma mark table delegate management
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Retrieve or create a cell
	UITableViewCellStyle style =  UITableViewCellStyleValue1;
	cell = [tView dequeueReusableCellWithIdentifier:@"BaseCell"];
	if (!cell) cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
	// Set cell label
    cell.textLabel.text = @"问题类型:";
	cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = self.selValue; 
	cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
	cell.editingAccessoryType = UITableViewCellAccessoryNone;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *ucell = [tableView cellForRowAtIndexPath:indexPath];
    [self presentNumberPickerModally:ucell.detailTextLabel.text];
	
}

#pragma mark value picker management
- (void)presentNumberPickerModally:(NSString *)sel
// Displays the number picker so that the user can add a new number to the 
// list of numbers to add up.
{
    SelectOptionTableViewController *vc;
    vc = [self createSelectOptionTableView:self.cateArray selected:sel];
    assert(vc != nil);
    vc.delegate = self;
    vc.title=@"请选择问题类型";
    [vc presentModallyOn:self];
}

// Called by the number picker when the user chooses a number or taps cancel.
- (void)numberPicker:(SelectOptionTableViewController *)controller didChooseNumber:(NSString *)string
{
    #pragma unused(controller)
    assert(controller != nil);
    
    // If it wasn't cancelled...
    if (string != nil) {
		self.selValue=string;
		//[self.cateTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        cell.detailTextLabel.text=string;
    }
    [cell setSelected:NO];
    [self dismissModalViewControllerAnimated:YES];
}

-(SelectOptionTableViewController *)createSelectOptionTableView:(NSArray *)data selected:(NSString *)sel
{
    
	SelectOptionTableViewController *selectTable=[[[SelectOptionTableViewController alloc] init] autorelease];
	selectTable.data=data;
	selectTable.currentIndex=[data indexOfObject:sel];
	
	return selectTable;
    
}

-(void) dealloc
{
    [super dealloc];
    [cateArray release];
    [contactText release];
    [contentView release];
    [selValue release];
}

@end
