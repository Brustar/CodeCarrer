//
//  AddressViewController.h
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
#import "AddressInfo.h"
#import "InsertAddressViewController.h"

#define ADDRESS_URL             @"/getRecAddrsByCusId.do"
#define REMOVE_ADDRESS_URL      @"/deleteRecAddr.do"

@interface AddressViewController : UITableViewController <UIAlertViewDelegate>
{
    NSMutableData *receivedData;
    NSMutableArray *addressArray;
    NSURLConnection *deleteConn,*listConn;
    AddressInfo *removeAddr;
    BOOL isPay;
    id caller;
}

@property(nonatomic,retain) NSMutableData *receivedData;
@property(nonatomic,retain) NSMutableArray *addressArray;
@property(nonatomic,retain) NSURLConnection *deleteConn,*listConn;
@property(nonatomic,retain) AddressInfo *removeAddr;
@property(nonatomic,retain) id caller;
@property(nonatomic) BOOL isPay;

-(NSMutableArray *)fetchAddressFormJson:(NSString *)data;

@end
