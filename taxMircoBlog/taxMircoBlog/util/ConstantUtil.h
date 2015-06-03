//
//  ConstantUtil.h
//  Meiju
//
//  Created by brustar on 12-4-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_HOST	@"http://www.china-xrl.com"  //服务器地址 192.168.1.2 192.168.1.37 www.china-xrl.com
#define HOST_PORT	7003                        //服务器端口 8080 1144 7003
#define APP_HOST_PATH	@"/taxm"                //服务器应用名
#define APP_OS			@"IOS"	
#define SCREEN_WIDTH	320                     //屏幕宽度
#define SCREEN_HEIGHT	480                     //屏幕高度

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )  

#define TELEPHONE_PROTOCOL  @"tel://"
#define SMS_PROTOCOL        @"sms:"
#define MAIL_PROTOCOL       @"mailto://"
#define WEB_PROTOCOL        @"http://"
#define MAIL_REGX           @"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$"

#define VERSION_KEY		@"CFBundleVersion"
#define APP_NAME_KEY    @"CFBundleDisplayName"
#define ARRAY_NAME		@"jsonArray"
#define PIC_KEY			@"picAddr"           //图像地址在JSON中的键值
#define LAST_PAGE		@"isLastPage"
#define RETURN_CODE     @"methodCode"
#define RETURN_MESSAGE  @"methodMessage"

#define MORE			@"更多..."
#define ALERT_OK_TITLE  @"确定"
#define TITEL_CANCEL    @"取消"
#define SERVER_ERROR    @"无法连接服务器，请与网络管理员联系。"
#define REQUEST_FAIL    @"请求异常"
#define NOT_LOGIN       @"您还没有登录"
#define LOGOUT_MESSAGE  @"确定要退出吗?"

#define SYS_BG		[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1.0]	//eaeaea
#define ORANGE_BG	[UIColor colorWithRed:1.0 green:141.0/255.0 blue:37.0/255.0 alpha:1.0]	//ff8d25
#define GRAY_BG     [UIColor colorWithRed:109.0/255.0 green:107.0/255.0 blue:102.0/255.0 alpha:1.0]      //6d6b66
#define CONTENT_FONT        [UIFont systemFontOfSize:14];
#define DATASTORE_PATH      [NSHomeDirectory() stringByAppendingString:@"/Documents/shopcart.sqlite"]
#define CACHE_JOSN_PATH     [NSHomeDirectory() stringByAppendingString:@"/Documents/home.json"]
#define CACHE_IMAGE         @"source.png"
//#define ORANGE_BAR	[UIColor colorWithPatternImage:[UIImage imageNamed:BAR_PICNAME]];
#define PAGE_LENGTH	10
#define TITLE_HEIGHT 20
#define	BAR_HEIGHT	44
#define IMAGE_HEIGHT 80
#define MAIN_BANNER_WIDTH 311

#define ICON_HEIGHT 30

@interface ConstantUtil : NSObject {

}

//自动生成请求地址
+(NSString *) createBaseRequestURL:(NSString *)url;

+(NSString *) createRequestURL:(NSString *)url;

+(NSString *) createRequestURL:(NSString *)url withParam:(NSString *)param;

+(NSString *) createParam:(NSString *)param;

+(NSString *) parseDate:(NSString *)date;

+(NSString *) createPreviewImagePath;
+(NSString *) createSandTempPath:(NSString *) fileName;
//取Info.plist中的键值
+(NSString *) fetchValueFromPlistFile:(NSString *)key;

+ (NSDate *) dateFromString: (NSString *) aString;

+(UIColor *) initSystemBackground;

+ (NSString *)createUUID;
+ (NSString *)createShortUUID;
+(BOOL) isNumbric:(NSString *) text;
+(int)parseToInt:(NSString *)str;
+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
@end
