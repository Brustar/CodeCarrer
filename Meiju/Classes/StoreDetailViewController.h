//
//  StoreDetailViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "RoundedCornerView.h"
#import "PhoneCallsViewController.h"
#import "Store.h"

#define STORE_DETAIL_URL    @"getDetailsFromFront.do"

@interface StoreDetailViewController : UIViewController
{
    Store *storeData;
    NSMutableData *receivedData;
    UIScrollView *scroll;
}

@property(nonatomic,retain) Store *storeData;

@end
