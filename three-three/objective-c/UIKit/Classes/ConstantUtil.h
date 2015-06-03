//
//  ConstantUtil.h
//  Meiju
//
//  Created by brustar on 12-4-19.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_HOST	@"http://www.meijumall.com" //服务器地址 www.meijumall.com //192.168.1.114 192.168.1.33
#define HOST_PORT	7001	//服务器端口 7001 7002 7004
#define SYNCHRONIZE  NO
#define APP_HOST_PATH	@"/ccs"	//服务器应用名
#define APP_OS			@"IOS"	
#define SCREEN_WIDTH	1024	//屏幕宽度
#define SCREEN_HEIGHT	768	//屏幕高度

#define VERSION_KEY		@"CFBundleVersion"

//#define BAR_PICNAME		@"titleBar"
#define MORE			@"更多..."
#define LINE_IMAGE_NAME @"separatorLine"
#define ARROW_IMAGE_NAME @"arrow"
#define ALERT_OK_TITLE  @"确定"
#define TITEL_CANCEL    @"取消"
#define BOX_TITLE       @"请选择类别"

#define SYS_BG		[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0]	//e0e0e0
#define ORANGE_BG	[UIColor colorWithRed:1.0 green:141.0/255.0 blue:37.0/255.0 alpha:1.0]	//ff8d25
#define GRAY_BG     [UIColor colorWithRed:109.0/255.0 green:107.0/255.0 blue:102.0/255.0 alpha:1.0]      //6d6b66
#define DATASTORE_PATH   [NSHomeDirectory() stringByAppendingString:@"/Documents/shopcart.sqlite"]
//#define ORANGE_BAR	[UIColor colorWithPatternImage:[UIImage imageNamed:BAR_PICNAME]];
#define PAGE_LENGTH	10
#define TITLE_HEIGHT 20
#define	BAR_HEIGHT	44
#define PRO_IMAGE_SIZE 120
#define MAIN_BANNER_WIDTH 311
#define LINE_HEIGHT		85

@interface ConstantUtil : NSObject {

}
+(BOOL)instanceNetOK;
+(void) isNetOK:(BOOL) ok;

//自动生成请求地址
+(NSString *) createBaseRequestURL:(NSString *)url;

+(NSString *) createRequestURL:(NSString *)url;

+(NSString *) createRequestURL:(NSString *)url withParam:(NSString *)param;

+(NSString *) createParam:(NSString *)param;

+(NSString *) parseDate:(NSString *)date;

+(NSString *) createPreviewImagePath;
+(NSString *) createImagePath:(NSString *) fileName;
//取Meiju-Info.plist中的键值
+(NSString *) fetchValueFromPlistFile:(NSString *)key;

+ (NSDate *) dateFromString: (NSString *) aString;

+(UIColor *) initSystemBackground;

@end
