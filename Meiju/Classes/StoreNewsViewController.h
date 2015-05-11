//
//  StoreNewsViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "NewsDetailViewController.h"
#import "Classificatory.h"
#import "PopUpBox.h"

#define STORE_NEWS_URL          @"shopInfoList.do"
#define STORE_NEWS_CATE_URL     @"getAllShopFromFront.do"
#define STORE_NEWS_TITLE        @"促销资讯"

@interface StoreNewsViewController : UITableViewController
{
    NSMutableData *receivedData;
    NSURLConnection *cateConn,*listConn,*moreConn,*filteConn;
    NSMutableArray *listArray;
    int pageNo,serverPages;		//当前页,服务器上的总页数
    NSString *param;
    
    id details;
    id categoryBox;     //重要：用id以防止互相嵌套。
}

@property(nonatomic,retain) NSURLConnection *cateConn,*listConn,*moreConn,*filteConn;
@property(nonatomic,retain) NSMutableArray *listArray;
@property(nonatomic,retain) NSString *param;
@property(nonatomic,retain) id details;
@property(nonatomic,retain) id categoryBox;     //重要：用id以防止互相嵌套。
@property(nonatomic) int pageNo,serverPages;		//当前页,服务器上的总页数

-(NSMutableArray *)fetchListArrayFromJSON:(NSString *)data;
-(void)searchClassificatory:(NSString *) typeId;
@end
