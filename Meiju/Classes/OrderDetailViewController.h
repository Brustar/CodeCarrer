//
//  OrderDetailViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
#import "UIMakerUtil.h"
#import "DataSource.h"

#define ORDER_DETAIL_URL    @"/getOrderByOrderId.do"
#define REPAY_URL           @"/findOrderDTOByOrderId.do"

@interface OrderDetailViewController : UIViewController
{
    OrderInfo *info;
    NSMutableData *receivedData;
    NSArray *proArray; 
    NSURLConnection *loadConn,*payConn;
}

@property(nonatomic,retain) NSMutableData *receivedData;
@property(nonatomic,retain) OrderInfo *info;
@property(nonatomic,retain) NSArray *proArray; 
@property(nonatomic,retain) NSURLConnection *loadConn,*payConn;

-(void) createUI:(NSString *) json;

@end
