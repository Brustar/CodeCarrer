//
//  MasterViewController.h
//  taxMircoBlog
//  首页
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "SessionUtil.h"
#import "WEPopoverController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "EGORefreshTableHeaderView.h"
#import "CustomCell.h"
#import "PropertyButton.h"
#import "CatalogController.h"
#import "SetupController.h"
#import "LoginViewController.h"
#import "Message.h"

#define MASTER_TITLE        @"郭伟"
#define MASTER_SUB_TITLE    @"您的专属私人税务顾问"
#define MASTER_URL          @"message_front_messageFrontList.do"

@interface MasterViewController : UITableViewController<EGORefreshTableHeaderDelegate,MWPhotoBrowserDelegate>
{
    NSMutableArray *messages;
    BOOL isLastPage;
    
    BOOL isReload;  //重新刷新标志
    
    EGORefreshTableHeaderView *refreshHeaderView;
    BOOL reloading;
    
    UIActivityIndicatorView *indicator;
    
    WEPopoverController *popoverController;
    
    int categoryId;
    
    MWPhoto *preImage;
}

@property (strong, nonatomic) WEPopoverController *popoverController;

@property (nonatomic, retain) NSMutableArray *messages;

@property (nonatomic,retain) MWPhoto *preImage;

-(void)loadCatalog:(int)cataId;

@end
