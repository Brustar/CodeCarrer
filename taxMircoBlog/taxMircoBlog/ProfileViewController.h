//
//  ProfileViewController.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-11-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "SessionUtil.h"
#import "CookieUtil.h"
#import "OptionViewController.h"
#import "UpdatePWDViewController.h"
#import "ImagePickerViewController.h"

#define REG_URL             @"customer_front_registerCustomer.do"
#define UPDATE_USERINFO_URL @"customer_front_updateCustomer.do"
#define TITLE_ARRAY         [NSArray arrayWithObjects:@"邮箱",@"姓名",@"性别",@"手机",@"行业",@"公司",@"职位", nil]
#define PROFESSION_ARRAY    [NSArray arrayWithObjects:@"计算机/互联网/通信/电子",@"会计/金融/银行/保险",@"贸易/消费/制造/营运",@"制药/医疗",@"广告/媒体",@"房地产/建筑",@"专业服务/教育/培训",@"服务业",@"物流/运输",@"能源/原材料",@"政府/非赢利机构/其他",nil]
#define SEX_ARRAY           [NSArray arrayWithObjects:@"女",@"男",nil]

@interface ProfileViewController : UIViewController<SelectOptionDelegate,PickerDelegate,UITextFieldDelegate>
{
    NSArray *details;
    UIScrollView *scroll;
    UITableViewCell *selCell;
    //UIControl *control;         //键盘的控制
    UserInfo *userinfo;
    BOOL logoned;
}
    
@property(nonatomic,retain) UIScrollView *scroll;
@property (strong, nonatomic) NSArray *details;
@property(nonatomic,retain) UserInfo *userinfo;

@end
