//
//  InsertAddressViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartViewController.h"
#import "UIMakerUtil.h"

#define INSERT_ADDRESS_URL  @"/addRecAddr.do"
#define UPDATE_ADDRESS_URL  @"/updateRecAddr.do"

@interface InsertAddressViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableData *receivedData;
    AddressInfo *address;
    BOOL isPay;
    id caller;
}

@property(nonatomic,retain) NSMutableData *receivedData;
@property(nonatomic,retain) AddressInfo *address;
@property(nonatomic,retain) id caller;
@property(nonatomic) BOOL isPay;

@end
