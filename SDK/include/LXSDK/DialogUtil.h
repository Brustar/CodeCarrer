//
//  DialogUtil.h
//  sdkExample
//
//  Created by lexun05 on 14/12/15.
//  Copyright (c) 2014年 lexun05. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AdSupport/ASIdentifierManager.h> 

@interface DialogUtil : NSObject

//提示消息框
+ (void) alert: (NSString *) message title:(NSString *) title;
+ (void) alert: (NSString *) message title:(NSString *) title delegate:(id) delegate;
+ (void) confirm: (NSString *) message title:(NSString *) title delegate:(id) delegate;

+(void)showaiting:(UIActivityIndicatorView *)indicator withUI:(UIView *)container;
+(void)stopwaiting:(UIActivityIndicatorView *)indicator withUI:(UIView *)container;

+ (NSString *) IMEI;

+ (void) back;
@end
