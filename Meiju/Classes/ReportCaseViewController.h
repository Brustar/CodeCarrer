//
//  ReportCaseViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "InsuranceViewController.h"

#define INSURANCE_REPORTCASE    @"车险报案"
#define REPORTCASE_MESSAGE      @"如果发生人伤，请及时送伤者去最近医院抢救。"
#define CALL_120                @"120(急救电话)"
#define CALL_110                @"110(报警电话)"
#define INSURANCE_CALL          @"保险公司报案电话"

@interface ReportCaseViewController : UITableViewController
{
    NSString *callNumber;
}

@end
