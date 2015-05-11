//
//  StoreViewController.h
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "ImageHelper.h"
#import "PopUpBox.h"
#import "StoreDetailViewController.h"
#import "Store.h"

#define CONTRACT_STORE          @"签约商户"
#define STORE_URL               @"shopList.do"
#define AREA_URL                @"getAllArea.do"
#define STORE_NEWS_URL          @"shopInfoList.do"

@interface StoreViewController : UITableViewController<UISearchBarDelegate> {
    id categoryBox;     //重要：用id以防止互相嵌套。
    NSURLConnection *areaConn,*listConn,*moreConn,*filteConn,*areaByParentIdConn,*storeByParentIdConn,*searchConn;
    NSMutableArray *storeArray;
    NSString *param,*parentID;
    int pageNo,serverPages;		//当前页,服务器上的总页数
    UISearchBar *search;
    UIView *disableViewOverlay;
    NSMutableData *receivedData;
}

@property(nonatomic,retain) id categoryBox;
@property(nonatomic,retain) NSURLConnection *areaConn,*listConn,*moreConn,*filteConn,*areaByParentIdConn,*storeByParentIdConn,*searchConn;
@property(nonatomic,retain) NSMutableArray *storeArray;
@property(nonatomic,retain) NSString *param,*parentID;
@property(nonatomic) int pageNo,serverPages;
@property (nonatomic,retain) UISearchBar *search;
@property(retain) UIView *disableViewOverlay;

@end
