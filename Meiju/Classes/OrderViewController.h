//
//  OrderViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionUtil.h"
#import "UIMakerUtil.h"
#import "ConstantUtil.h"
#import "DataSource.h"
#import "OrderInfo.h"
#import "OrderDetailViewController.h"

@interface OrderViewController : UITableViewController
{
    NSMutableData *receivedData;
    NSMutableArray *orderArray;
    NSInteger cate;
    int pageNo,serverPages;		//当前页,服务器上的总页数
    NSURLConnection *loadConn,*moreConn;
}

@property(nonatomic,retain) NSMutableData *receivedData;
@property(nonatomic,retain) NSMutableArray *orderArray;
@property(nonatomic,retain) NSURLConnection *loadConn,*moreConn;
@property(nonatomic) NSInteger cate;
@property(nonatomic) int pageNo,serverPages;

-(id)fetchOrdersFormJson:(NSString *) data;

@end
