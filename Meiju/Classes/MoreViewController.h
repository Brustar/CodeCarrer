//
//  MoreViewController.h
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "UserViewController.h"
#import "AboutViewController.h"
#import "HelpViewController.h"
#import "FeedBackViewController.h"
#import "SessionUtil.h"
#import "UserDelegate.h"
#import "KnowledgeViewController.h"
#import "ReportCaseViewController.h"
#import "StoreViewController.h"
#import "TencentOAuth.h"
#import "WBEngine.h"

#define BANNER_HEIGHT   41

#define INSURANCE_CALCULATE     @"车险计算"
#define MINI_MARKET             @"跳蚤市场"

#define HELP_TITLE      @"使用帮助"
#define FEEDBACK_TITLE  @"问题反馈"
#define SOFT_SHARE      @"软件分享"

#define ABOUT_TITLE     @"关于"
#define EXIT_TITLE      @"注销"
#define EXIT_MESSAGE    @"确定要退出吗?"
#define APPSTORE_LINK_URL         @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=534461785"
#define ICON_URL    @"http://a4.mzstatic.com/us/r30/Purple/v4/08/a6/b3/08a6b3f0-60ff-b44b-2b5f-37bdd65bd83b/liwB9UMJQ8biw03jeuUJhg-temp-upload.stbrzerz.175x175-75.jpg"
#define COMMENT_CONTENT [NSString stringWithFormat:@"Hi,我正在玩：%@ 可能对您有用，推荐给您！请访问：%@",[ConstantUtil fetchValueFromPlistFile:APP_NAME_KEY],APPSTORE_LINK_URL]

@interface MoreViewController : UITableViewController<UIActionSheetDelegate,UserDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate> {

}

- (void)presentModally;

@end
