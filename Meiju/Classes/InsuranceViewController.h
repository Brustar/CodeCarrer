//
//  InsuranceViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"

#define LOG_REPORT_URL          @"submitReportedRecord.do"
#define INSURANCE_CALL_TITLE    @"保险公司报案"

@interface InsuranceViewController : UITableViewController
{
    NSArray *insuranceArray;
    NSArray *telNumberArray;
    NSString *callNumber;
    
    NSMutableData *receivedData;
}

@property(nonatomic,retain) NSArray *insuranceArray,*telNumberArray;

@end
