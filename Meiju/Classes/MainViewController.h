//
//  FirstViewController.h
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "DataSource.h"
#import "EGORefreshTableHeaderView.h"
#import "AdScrollView.h"
#import "MallScrollView.h"
#import "RoundedCornerView.h"
#import "MallViewController.h"

//新品上架
#define NEWPROS_PARAM	@"pageNo=1&isNew=1"

//热卖专区
#define HOTSALE_PARAM	@"pageNo=1&isBestSellers=1"

//特价促销
#define FAVOURS_PARAM	@"pageNo=1&isPromot=1"

#define PIC_HEIGHT	100
#define LABEL_HEIGHT 36
#define TITLE_WIDTH 80

@interface MainViewController : UIViewController<UIScrollViewDelegate,UISearchBarDelegate,EGORefreshTableHeaderDelegate>
{
    UIScrollView *mainScrollView;
	UIScrollView *adScrollView;
	UIView *disableViewOverlay;
	
	NSMutableData *receivedData;
	CGRect MallScrollRect;

	NSURLConnection *adConn,*proConn,*hotProConn,*favorConn;
	UIButton *proButton,*hotButton,*favorButton;
    BOOL isConnected;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;
-(NSURLConnection *) createScroll:(CGRect)frame param:(NSString *)param;
-(void) addScroll:(NSString *)json;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@property (nonatomic,retain) UIScrollView  *mainScrollView;
@property(retain) UIView *disableViewOverlay;
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) NSURLConnection *adConn,*proConn,*hotProConn,*favorConn;
@property (nonatomic,retain) UIButton *proButton,*hotButton,*favorButton;
@property (nonatomic) BOOL isConnected; 

@end
