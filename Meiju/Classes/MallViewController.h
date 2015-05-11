//
//  MallViewController.h
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
#import "ConstantUtil.h"
#import "UIMakerUtil.h"
#import "ImageHelper.h"
#import "FillString.h"
#import "EGORefreshTableHeaderView.h"
#import "CustomUIBarButtonItem.h"
#import "PopUpBox.h"
#import "Product.h"
#import "Classificatory.h"
#import "ProductDetailViewController.h"
#import "ShopCartViewController.h"

#define MALL_TYPE_URL	@"/allGoodsType.do"
#define MALL_URL		@"/goodsList.do"

#define CLASS_KEY		@"typeName"


@interface MallViewController : UITableViewController<UISearchBarDelegate,EGORefreshTableHeaderDelegate>{
	NSString *MJPara,*parentID;
	IBOutlet UIButton *categoryButton;
	IBOutlet UIButton *sortButton;
	
	NSMutableArray			*listContent;			// The master content.
	
	UIView *disableViewOverlay,*popButtonsView;
	int pageNo,serverPages;		//当前页,服务器上的总页数
	CGRect MallScrollRect;
	UISearchBar *search;
	id categoryBox;     //重要：用id以防止互相嵌套。
    BOOL unshowSearch;    //是否显示搜索栏
	EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
	NSURLConnection *loadConn,*searchConn,*moreConn,*titleConn,*popConn,*sortConn,*classificatoryConn,*classByTypeIdConn;
}

-(id)fetchProductsFormJson:(NSString *) pam;
-(id)fetchClassificatoryFormJsonArray:(NSString *)data;
-(id)fetchClassificatoryFormJsonArray:(NSString *)data parentId:(NSString *)cateId;
-(void) createPopSearchBox;
- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;
-(void) doSearch: (NSString *)text;
-(void)titleClickAction: (NSString *)text;
-(void)loadMore;
-(void) sort:(int) index;
-(void) searchClassificatory:(NSString *) typeId;
-(void) searchByClassificatory:(NSString *) typeId isParent:(BOOL) parent;
-(void) popButtonClick;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@property (nonatomic, retain) IBOutlet UIButton *categoryButton;
@property (nonatomic, retain) IBOutlet UIButton *sortButton;
@property(retain) UIView *disableViewOverlay,*popButtonsView;
@property (nonatomic,retain) UISearchBar *search;
@property(nonatomic,retain) NSString *MJPara,*parentID;
@property(nonatomic) int pageNo,serverPages;
@property(nonatomic) BOOL unshowSearch;
@property (nonatomic, retain) NSMutableArray *listContent;
@property (nonatomic,retain) NSMutableData *receivedData;
@property (nonatomic,retain) id categoryBox;
@property (nonatomic,retain) NSURLConnection *loadConn,*searchConn,*moreConn,*titleConn,*popConn,*sortConn,*classificatoryConn,*classByTypeIdConn;

@end
