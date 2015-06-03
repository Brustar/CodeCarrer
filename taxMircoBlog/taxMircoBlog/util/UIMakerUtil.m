//
//  MessageBoxUtil.m
//  Meiju
//
//  Created by brustar on 12-4-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UIMakerUtil.h"

@implementation UIMakerUtil

+ (void) alert: (NSString *) message title:(NSString *) title
{
	UIAlertView *alert=[[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
}

+ (void) alert: (NSString *) message title:(NSString *) title delegate:(id) delegate
{
    UIAlertView *alert=[[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	[alert show];
}

+(void) confirm: (NSString *) message title:(NSString *) title delegate:(id) delegate
{
    UIAlertView *confirmDiag = [[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:TITEL_CANCEL, nil] autorelease];
    
    [confirmDiag show];
}

+ (void) actionSheet:(NSString *) message delegate:(id) delegate
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:message delegate:delegate cancelButtonTitle:TITEL_CANCEL destructiveButtonTitle:ALERT_OK_TITLE otherButtonTitles: nil];

    //[sheet showInView:((UIViewController *)delegate).view]; 这个cancel会被tabBar挡住
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    [sheet release];
}

+ (void) actionSheet:(NSString *) message delegate:(id) delegate addButton:(NSString *)otherButtonTitles, ...
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:message delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    id eachObject;
    va_list argList;
    if(otherButtonTitles)  
    {
        [sheet addButtonWithTitle:otherButtonTitles];
        va_start(argList,otherButtonTitles);

        while ((eachObject=va_arg(argList,id))) {
            [sheet addButtonWithTitle:(NSString*)eachObject];
        }
        va_end(argList);
    }

    [sheet addButtonWithTitle:TITEL_CANCEL];
    sheet.cancelButtonIndex = sheet.numberOfButtons - 1;

    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    [sheet release];
}

+(void) saveImageViewFromURL : (NSString *) URL
{
	NSURL *url=[NSURL URLWithString:URL];
	NSData *imageData =[NSData dataWithContentsOfURL:url];
    NSString *path = [ConstantUtil createPreviewImagePath];
    [imageData writeToFile:path atomically:YES];
}

+(UIImageView *) createImageViewFromURL : (NSString *) URL
{
	UIImageView *imageView=[[UIImageView alloc] init];	
	NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
	[imageView setImage:[UIImage imageWithData:imageData]];
	imageView.contentMode=UIViewContentModeCenter; //实际大小，居中显示
	return [imageView autorelease];
}

+(UIImageView *) createImageViewFromURL : (NSString *) URL frame:(CGRect) frame
{
	UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];	
	NSData *imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
	[imageView setImage:[UIImage imageWithData:imageData]];
	return [imageView autorelease];
}

+(UIImageView *) createImageView : (NSString *) name frame:(CGRect) frame
{
	UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];	
	[imageView setImage:[UIImage imageNamed:name]];
	return [imageView autorelease];
}

+(UIImageView *) createIcon : (NSString *) name frame:(CGRect) frame
{
	UIImageView *imageView=[[UIImageView alloc] initWithFrame:frame];	
	[imageView setImage:[UIImage imageNamed:name]];
	imageView.contentMode=UIViewContentModeCenter; //实际大小，居中显示
	return [imageView autorelease];
}

+(UIImageView *) createImageView : (NSString *) name
{
	UIImageView *imageView=[[UIImageView alloc] init];	
	[imageView setImage:[UIImage imageNamed:name]];
	imageView.contentMode=UIViewContentModeCenter; //实际大小，居中显示
	return [imageView autorelease];
}

+(UILabel *)createLabel
{
    UILabel *label=[[[UILabel alloc] init] autorelease];
    label.font = [UIFont systemFontOfSize:14];
	label.backgroundColor=SYS_BG;
    return label;
}

+(UILabel *)createLabelWithBg:(NSString *)text frame:(CGRect)frame
{
    UILabel *label=[self createLabel];
    label.text=text;
    label.frame=frame;
    return label;
}

+(UILabel *)createLabel:(NSString *)text frame:(CGRect)frame
{
	UILabel *label=[[UILabel alloc] initWithFrame:frame];
	label.text=text;
	label.font = [UIFont systemFontOfSize:14];
	label.backgroundColor=[UIColor clearColor];
	return [label autorelease];
}

+(UILabel *)createTitleLabel:(NSString *)text frame:(CGRect)frame
{
	UILabel *label=[[UILabel alloc] initWithFrame:frame];
	label.text=text;
	label.font = [UIFont boldSystemFontOfSize:16];
	label.backgroundColor=[UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	return [label autorelease];
}

+(UITextField *)createTextField:(CGRect)frame
{
	UITextField *textField=[[[UITextField alloc] initWithFrame:frame] autorelease];
    //textField.borderStyle = UITextBorderStyleRoundedRect;//设置文本框边框风格
    textField.autocorrectionType = UITextAutocorrectionTypeYes;//启用自动提示更正功能
	return textField;
}

+(UITextField *)createTextField:(CGRect)frame delegate:(id)delegate
{
    UITextField *textField=[self createTextField:frame];
    textField.delegate=delegate;
    return textField;
}

+(UITextField *)createTextField:(CGRect)frame delegate:(id)delegate returnKey:(UIReturnKeyType) key
{
    UITextField *textField=[self createTextField:frame];
    textField.delegate=delegate;
    textField.returnKeyType=key;
    textField.enablesReturnKeyAutomatically=YES;
    return textField;
}

+(UITextField *)createTextField:(CGRect)frame tag:(NSInteger)tag delegate:(id)delegate
{
    UITextField *textField=[self createTextField:frame delegate:delegate];
    textField.tag=tag;
    return textField;
}

+(UITextView *)createTextView:(CGRect)frame
{
	UITextView *textArea=[[[UITextView alloc] initWithFrame:frame] autorelease];
	return textArea;
}

+(UITextView *)createTextAreaView:(NSString *)text frame:(CGRect)frame
{
	UITextView *textArea=[self createTextView:frame];
	textArea.editable=NO;
	textArea.text=text;
	return textArea;
}

+(UITextView *)createNOBgTextAreaView:(NSString *)text frame:(CGRect)frame
{
	UITextView *textArea=[self createTextAreaView:text frame:frame];
	textArea.backgroundColor=[UIColor clearColor];
	return textArea;
}

+(UILabel *)createMainTitle:(NSString *)text  frame:(CGRect) frame;
{
	UILabel *label=[[UILabel alloc] initWithFrame:frame];
	label.text=text;
	label.textColor=[UIColor whiteColor];
	label.font = [UIFont boldSystemFontOfSize:18];
	label.backgroundColor=[UIColor clearColor];
    label.shadowColor=[UIColor clearColor];
	label.textAlignment = UITextAlignmentLeft;
	return [label autorelease];
}

// 添加一个隐藏的按钮
+(UIButton *)createHiddenButton:(CGRect)frame
{	
	UIButton *hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[hiddenButton setFrame: frame];
	hiddenButton.backgroundColor = [UIColor clearColor];
	return hiddenButton;
}

+(PropertyButton *)createHiddenButton:(CGRect)frame data:(id) data
{
	PropertyButton *hiddenButton = [[[PropertyButton alloc] init] autorelease];
	[hiddenButton setFrame: frame];
	hiddenButton.backgroundColor = [UIColor clearColor];
    hiddenButton.data=data;
	return hiddenButton;
}

+(UIButton *) createButton:(NSString *) text
{
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[btn setTitle:text forState:UIControlStateNormal];
	return btn;
}

+(UIButton *) createButton:(NSString *) text frame:(CGRect)frame
{
	UIButton *btn = [self createButton:text];
	btn.frame = frame;
	return btn;
}

+(UIButton *) createButton:(NSString *) text point:(CGPoint) point
{
	UIButton *button =[self createButton:text];
	CGRect frame=CGRectMake(point.x, point.y, 120, TITLE_HEIGHT);
	button.frame = frame;
	return button;
}

+(PropertyButton *) createPropertyButton:(NSString *) text image:(NSString *) imageName frame:(CGRect)frame
{
    PropertyButton *btn = [[[PropertyButton alloc] init] autorelease];
	[btn setTitle:text forState:UIControlStateNormal];
    btn.frame = frame;
    [[btn layer] setMasksToBounds:YES];  
    [[btn layer] setCornerRadius:10.0]; //设置矩形四个圆角半径  
    [[btn layer] setBorderWidth:1.0]; //边框宽度
    btn.layer.borderColor=[ConstantUtil getColorFromRed:140 Green:140 Blue:140 Alpha:255];
    btn.backgroundColor = [UIColor clearColor];

    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:10];
    btn.titleEdgeInsets=UIEdgeInsetsMake(2, 6, 0, 0);
    return btn;
}

+(PropertyButton *) createPropertyButton:(NSString *) imageName frame:(CGRect)frame
{
    PropertyButton *btn = [[[PropertyButton alloc] init] autorelease];
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}

+(UIButton *) createButton:(NSString *) text image:(NSString *) imageName frame:(CGRect)frame
{
    UIButton *btn=[UIMakerUtil createButton:text frame:frame];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:10];
    btn.titleEdgeInsets=UIEdgeInsetsMake(2, 6, 0, 0);
    return btn;
}
//带文字和背景图的按钮
+(UIButton *) createImageButton:(NSString *) text image:(NSString *)image frame:(CGRect)frame
{
	UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = frame;
	//button.center = point;
	// Set up the button aligment properties
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	// Set the font and color
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //[button setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
	return button;
}

+(UIButton *) createImageButton:(NSString *) imageName light:(NSString *)lightImage frame:(CGRect) rect
{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = rect;
	// Set up the button aligment properties
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	// Set the font and color
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:lightImage] forState:UIControlStateHighlighted];
	return button; 
}

+(UIButton *) createImageButton:(NSString *) imageName light:(NSString *)lightImage point:(CGPoint) point
{
    UIButton *button =[self createImageButton:imageName light:lightImage frame:CGRectMake(0, 0, 22, 22)];
	button.center = point;
	return button;
}


+(UIButton *) createDetailDisclosureButton:(CGPoint) point
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btn.center = point;
    return btn;
}

+(UIBarButtonItem *) createCustomerBackButton:(NSString *) imageName
{
    UIBarButtonItem *backButton=[[[UIBarButtonItem alloc] init] autorelease];
    //兼容IOS4.0
    if ([backButton respondsToSelector:@selector( setBackButtonBackgroundImage:forState:barMetrics:)]){
        //only for ios5.0
        [backButton setBackButtonBackgroundImage:[UIImage imageNamed:@"transparentpoint"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    backButton.image=[UIImage imageNamed:imageName];
     
    return backButton;
}

+(UIBarButtonItem *)createBarButtonItem:(NSString *)imgName andTarget:(id)theTarget andSelector:(SEL)selector
{
    UISegmentedControl *button = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:[UIImage imageNamed:imgName], nil]] autorelease];
    button.momentary = YES;
    button.segmentedControlStyle = UISegmentedControlStyleBar;
    //兼容IOS4.0
    if ([button respondsToSelector:@selector( setBackgroundImage:forState:barMetrics:)]){
        //only for ios5.0
        [button setBackgroundImage:[UIImage imageNamed:@"transparentpoint"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    [button addTarget:theTarget action:selector forControlEvents:UIControlEventValueChanged];
	
    UIBarButtonItem *removeButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
	
    return removeButton;
}

+(UIControl *)createUIControl:(SEL)selector target:(id)target
{
    UIControl *viewControl = [[[UIControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)] autorelease];
    [viewControl setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1f]];
    [viewControl addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return viewControl;
}

+(UIActivityIndicatorView *)createActivityView:(CGRect)frame
{
	UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] 
											   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[activityView setFrame:frame];
	 activityView.hidesWhenStopped = YES;
	//[activityView startAnimating];
    [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	return [activityView autorelease];
}

+ (UINavigationBar *)createNavigationBarWithBackgroundImage:(UIImage *)backgroundImage title:(NSString *)title {
	
    UINavigationBar *customNavigationBar = [[[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)] autorelease];
    UIImageView *navigationBarBackgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    [customNavigationBar addSubview:navigationBarBackgroundImageView];
    UINavigationItem *navigationTitle = [[UINavigationItem alloc] initWithTitle:title];
    [customNavigationBar pushNavigationItem:navigationTitle animated:NO];
    [navigationTitle release];
    [navigationBarBackgroundImageView release];
    return customNavigationBar;
}

+(UINavigationBar *)createNavigationBar:(NSString *)title
{
	UIImage *navigationBarBackgroundImage =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"" ofType:@"png"]];
	UINavigationBar *customNavigationBar = [UIMakerUtil createNavigationBarWithBackgroundImage:navigationBarBackgroundImage title:title];
	
	//[self.navigationController setNavigationBarHidden:YES animated:YES];
	return customNavigationBar;
}

+(UISearchBar *) createSearchBar:(CGRect)frame
{
	UISearchBar *search=[[[UISearchBar alloc] initWithFrame: frame] autorelease];
	search.placeholder=@"搜一下试试";
	//设置取消按钮为橙色
	search.tintColor=ORANGE_BG;
	//UIView *segment = [search.subviews objectAtIndex:0];
	//UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	//[segment addSubview: bgImage];
	//[bgImage release];
	return search;
}

+(UIView *) createMaskView:(CGRect)frame
{
	UIView *disableViewOverlay= [[[UIView alloc]   
							   initWithFrame:frame] autorelease];   
    disableViewOverlay.backgroundColor=[UIColor blackColor];   
    disableViewOverlay.alpha = 0;
	return disableViewOverlay;
}

+(UIView *) createRoundedRectView:(CGRect)frame
{
    UIView *view= [[[UIView alloc] initWithFrame:frame] autorelease];
    [[view layer] setMasksToBounds:YES];
    [[view layer] setCornerRadius:10.0]; //设置矩形四个圆角半径
    [[view layer] setBorderWidth:1.0]; //边框宽度
    view.layer.borderColor=[ConstantUtil getColorFromRed:200 Green:200 Blue:200 Alpha:255];
    view.backgroundColor = [UIColor whiteColor];
	return view;
}

+(UISegmentedControl *) createSegmentedControl:(NSArray *) buttonNames frame:(CGRect)frame
{
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:buttonNames];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	[segmentedControl setFrame: frame];
    segmentedControl.tintColor=SYS_BG;
	return [segmentedControl autorelease];
}

+(UIPickerView *)createUIPickerView:(CGPoint)point delegateAndSoruce:(id)ds
{
    CGRect pickerFrame = CGRectMake(point.x,point.y,200,100);	
	UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; 
	pickerView.dataSource = ds;
	pickerView.delegate = ds;
	pickerView.showsSelectionIndicator = YES;	
	return [pickerView autorelease];	
}

+(UITableView *)createTableView:(CGRect)frame delegateAndSoruce:(id)ds
{
    UITableView *table=[[[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain] autorelease];
    table.delegate=ds;
    table.dataSource=ds;
    table.scrollEnabled=YES;
    //table.backgroundColor=SYS_BG;
    //table.rowHeight=35;
    return table;
}

+(UITableView *)createTableGroupView:(CGRect)frame delegateAndSoruce:(id)ds
{
    UITableView *table=[[[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped] autorelease];
    table.delegate=ds;
    table.dataSource=ds;
    table.scrollEnabled=NO;
    table.backgroundColor=SYS_BG;
    table.backgroundView =nil;
    return table;
}

+(UIScrollView *) createScrollView
{
   return [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)] autorelease];
}

+(void) sysApplicationCall:(NSString *) address protocol:(NSString *)protocol
{
    if (!address) {
        address=@"";
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[protocol stringByAppendingString:address]]];
}

+(void) checkNetworkConnected
{
	if(![self connectedToNetwork])
	{
		[self alert:@"无法连接网络，请确认wifi,3G网络或蜂窝数据连接正常." title:@"Error"];
		return;
	}
}

// Recursively travel down the view tree, increasing the indentation level for children
+ (void) dumpView: (UIView *) aView atIndent: (int) indent into:(NSMutableString *) outstring
{
	for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
	[outstring appendFormat:@"[%2d] %@\n", indent, [[aView class] description]];
	for (UIView *view in [aView subviews]) [self dumpView:view atIndent:indent + 1 into:outstring];
}

// Start the tree recursion at level 0 with the root view
+ (NSString *) displayViews: (UIView *) aView
{
	NSMutableString *outstring = [[NSMutableString alloc] init];
	[self dumpView: aView atIndent:0 into:outstring];
	return [outstring autorelease];
}

+ (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);    
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) 
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

//通用提示框
+ (void)alertOKCancelAction:(NSString *)msg title:(NSString *)title delegate:(id)delegate{   
    // open a alert with an OK and cancel button   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:ALERT_OK_TITLE otherButtonTitles:nil, nil];
    [alert show];
    [alert release]; 
}

@end
/*
//自定义UINavigationBar，改背景为桔色
@implementation UINavigationBar (UINavigationBarCategory)
- (void)drawRect:(CGRect)rect {
	UIImage *img = [UIImage imageNamed:@""];
	[img drawInRect:rect];
}

@end 
*/