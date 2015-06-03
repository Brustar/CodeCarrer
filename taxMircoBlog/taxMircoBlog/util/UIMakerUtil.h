//
//  MessageBoxUtil.h
//  Meiju
//
//  Created by brustar on 12-4-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <QuartzCore/QuartzCore.h> 
#import "ConstantUtil.h"
#import "PropertyButton.h"

@interface UIMakerUtil : NSObject {
	
}

//提示消息框
+ (void) alert: (NSString *) message title:(NSString *) title;
+ (void) alert: (NSString *) message title:(NSString *) title delegate:(id) delegate;
+ (void) confirm: (NSString *) message title:(NSString *) title delegate:(id) delegate;
+ (void) actionSheet:(NSString *) message delegate:(id) delegate;
+ (void) actionSheet:(NSString *) message delegate:(id) delegate addButton:(NSString *)otherButtonTitles, ...;

//保存网络图片
+(void) saveImageViewFromURL : (NSString *) URL;
//获取网络图片
+(UIImageView *) createImageViewFromURL : (NSString *) URL;
+(UIImageView *) createImageViewFromURL : (NSString *) URL frame:(CGRect) frame;
+(UIImageView *) createImageView : (NSString *) name frame:(CGRect) frame;
+(UIImageView *) createImageView : (NSString *) name;

+(UILabel *)createLabel;
+(UILabel *)createLabelWithBg:(NSString *)text frame:(CGRect)frame;
+(UILabel *)createLabel:(NSString *)text  frame:(CGRect) frame;
+(UILabel *)createTitleLabel:(NSString *)text frame:(CGRect)frame;
+(UILabel *)createMainTitle:(NSString *)text  frame:(CGRect) frame;

+(UITextField *)createTextField:(CGRect)frame;
+(UITextField *)createTextField:(CGRect)frame delegate:(id)delegate;
+(UITextField *)createTextField:(CGRect)frame delegate:(id)delegate returnKey:(UIReturnKeyType)key;
+(UITextField *)createTextField:(CGRect)frame tag:(NSInteger)tag delegate:(id)delegate;
+(UITextView *)createTextView:(CGRect)frame;
+(UITextView *)createTextAreaView:(NSString *)text frame:(CGRect)frame;
+(UITextView *)createNOBgTextAreaView:(NSString *)text frame:(CGRect)frame;
+(UIControl *)createUIControl:(SEL)selector target:(id)target;
+(UIActivityIndicatorView *)createActivityView:(CGRect)frame;

+(UIButton *) createButton:(NSString *) text;
+(UIButton *) createButton:(NSString *) text frame:(CGRect)frame;
+(UIButton *) createButton:(NSString *) text point:(CGPoint) point;
+(PropertyButton *) createPropertyButton:(NSString *) text image:(NSString *) imageName frame:(CGRect)frame;
+(PropertyButton *) createPropertyButton:(NSString *) imageName frame:(CGRect)frame;
+(UIButton *) createButton:(NSString *) text image:(NSString *) imageName frame:(CGRect)frame;
+(UIButton *) createImageButton:(NSString *) text image:(NSString *)image frame:(CGRect)frame;
+(UIButton *) createImageButton:(NSString *) imageName light:(NSString *)lightImage frame:(CGRect) rect;
+(UIButton *) createImageButton:(NSString *) imageName light:(NSString *)lightImage point:(CGPoint) point;
// 添加一个隐藏的按钮
+(UIButton *)createHiddenButton:(CGRect)frame;
+(PropertyButton *)createHiddenButton:(CGRect)frame data:(id) data;
+(UIButton *) createDetailDisclosureButton:(CGPoint) point;
+(UIBarButtonItem *) createCustomerBackButton:(NSString *) imageName;
+(UIBarButtonItem *) createBarButtonItem:(NSString *)img andTarget:(id)theTarget andSelector:(SEL)selector;
+(UIScrollView *) createScrollView;

+(UIImageView *) createIcon : (NSString *) name frame:(CGRect) frame;
+(UINavigationBar *)createNavigationBarWithBackgroundImage:(UIImage *)backgroundImage title:(NSString *)title;
+(UINavigationBar *)createNavigationBar:(NSString *)title;
+(UISearchBar *) createSearchBar:(CGRect)frame;
+(UIView *) createMaskView:(CGRect)frame;
+(UIView *) createRoundedRectView:(CGRect)frame;
+(UISegmentedControl *) createSegmentedControl:(NSArray *) buttonNames frame:(CGRect)frame;
+(UIPickerView *)createUIPickerView:(CGPoint)point delegateAndSoruce:(id)ds;
+(UITableView *)createTableView:(CGRect)frame delegateAndSoruce:(id)ds;
+(UITableView *)createTableGroupView:(CGRect)frame delegateAndSoruce:(id)ds;

+(void) sysApplicationCall:(NSString *) address protocol:(NSString *)protocol;

//检查网络是否正常
+(void) checkNetworkConnected;

+ (BOOL) connectedToNetwork;
//调试用信息
+ (void) dumpView: (UIView *) aView atIndent: (int) indent into:(NSMutableString *) outstring;
+ (NSString *) displayViews: (UIView *) aView;

//通用提示框
+ (void)alertOKCancelAction:(NSString *)msg title:(NSString *)title delegate:(id)delegate;

@end
