//
//  ProductDetailViewController.h
//  Meiju
//
//  Created by brustar on 12-5-1.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import "ProDetailImageScrollView.h"
#import "Product.h"
#import "FillString.h"
#import "SessionUtil.h"
#import "UserViewController.h"
#import "ShopCartViewController.h"

#define COLLECT_URL @"/addCollect.do"

@interface ProductDetailViewController : UIViewController <QLPreviewControllerDataSource>{
	UIImage *pic;
	UILabel *proTitle;
	UILabel *proDetail;
	UILabel *markPrice;			//市场价格
	UILabel *mallPrice;		//商城价格
	UILabel *virtualSalesVolume,*invenStatus;
	UIButton *collect;
	UIButton *purchase;
	Product *productData;
    NSURLConnection *collectConn,*productConn;
	
    UIScrollView *proScrollView;
	QLPreviewController *quicklook;
	NSMutableData *receivedData;
}

-(void) createUI;
-(void)ChangeSegmentFont:(UIView *)aView;

@property (nonatomic, retain) UIImage *pic;
@property (nonatomic, retain) UILabel *proTitle;
@property (nonatomic, retain) UILabel *proDetail,*virtualSalesVolume,*invenStatus;
@property (nonatomic, retain) UILabel *markPrice,*mallPrice;
@property (nonatomic, retain) UIButton *collect;
@property (nonatomic, retain) UIButton *purchase;
@property (nonatomic, retain) Product *productData;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) UIScrollView *proScrollView;
@property (nonatomic, retain) NSURLConnection *collectConn,*productConn;

@end
