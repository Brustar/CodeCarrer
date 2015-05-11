//
//  MessageBoxUtil.h
//  Meiju
//
//  Created by brustar on 12-4-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantUtil.h"
#import "Product.h"
#import "News.h"
#import "ProductDetailViewController.h"
#import "NewsDetailViewController.h"

@interface UIMakerUtil : NSObject {
	
}

//提示消息框
+ (void) alert: (NSString *) message title:(NSString *) title;
+ (void) alert: (NSString *) message title:(NSString *) title delegate:(id) delegate;
+ (void) confirm: (NSString *) message title:(NSString *) title delegate:(id) delegate;
+ (void) actionSheet:(NSString *) message delegate:(id) delegate;
+ (void) actionSheet:(NSString *) message delegate:(id) delegate addButton:(NSString *)otherButtonTitles, ...;

//获取网络图片
+(UIImageView *) saveImageViewFromURL : (NSString *) URL;
+(UIImageView *) createImageViewFromURL : (NSString *) URL;

+(UIImageView *) createImageViewFromURL : (NSString *) URL frame:(CGRect) frame;
+(UIImageView *) createImageView : (NSString *) name frame:(CGRect) frame;
+(UIImageView *) createImageView : (NSString *) name;
+(UIImageView *) createSeparatorLineByWidth:(CGRect) frame;
+(UIImageView *)createSeparatorLine:(CGPoint) point;

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

+(UIActivityIndicatorView *)createActivityView:(CGRect)frame;

+(id)createProductDetailView:(Product *)pro;
+(id)createNewsDetailView:(News *) news;

+(UIButton *) createButton:(NSString *) text;
+(UIButton *) createButton:(NSString *) text frame:(CGRect)frame;
+(UIButton *) createButton:(NSString *) text point:(CGPoint) point;
+(UIButton *) createImageButton:(NSString *) text point:(CGPoint) point;
+(UIButton *) createImageButton:(NSString *) imageName light:(NSString *)lightImage frame:(CGRect) rect;
+(UIButton *) createImageButton:(NSString *) imageName light:(NSString *)lightImage point:(CGPoint) point;
// 添加一个隐藏的按钮
+(UIButton *)createHiddenButton:(CGRect)frame;
+(UIButton *) createDetailDisclosureButton:(CGPoint) point;
+(UIScrollView *) createScrollView;

+(UIImageView *) createIcon : (NSString *) name frame:(CGRect) frame;
+ (UINavigationBar *)createNavigationBarWithBackgroundImage:(UIImage *)backgroundImage title:(NSString *)title;
+(UINavigationBar *)createNavigationBar:(NSString *)title;
+(UISearchBar *) createSearchBar:(CGRect)frame;
+(UIView *) createMaskView:(CGRect)frame;
+(UISegmentedControl *) createSegmentedControl:(NSArray *) buttonNames frame:(CGRect)frame;
+(UIPickerView *)createUIPickerView:(CGPoint)point delegateAndSoruce:(id)ds;
+(UITableView *)createTableView:(CGRect)frame delegateAndSoruce:(id)ds;

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
