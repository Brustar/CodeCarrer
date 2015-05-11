//
//  ShopCartViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "DataSigner.h"
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "ShopCart.h"
#import "Product.h"
#import "FillString.h"
#import "CustomUIBarButtonItem.h"
#import "UserRegViewController.h"
#import "AddressViewController.h"
#import "AddressInfo.h"
#import "SessionUtil.h"
#import "UserDelegate.h"

#define ADDORDER_URL        @"/addOrder.do"

@interface ShopCartViewController : UITableViewController<NSFetchedResultsControllerDelegate,UITextFieldDelegate,UserDelegate>
{
    NSManagedObjectContext *context;
    NSFetchedResultsController *results;
    NSMutableData *receivedData;
    
    AddressInfo *address;
}

@property(nonatomic,retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSFetchedResultsController *results;
@property (nonatomic, retain) AddressInfo *address;


- (void) initCoreData;
- (BOOL) addObject:(Product *)product;

-(int) payAction:(NSString *) json;
-(void) addOrder;

@end
