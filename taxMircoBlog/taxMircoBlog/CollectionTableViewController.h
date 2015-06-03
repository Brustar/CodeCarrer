//
//  JSONTableTestViewController.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "DataSource.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomCell.h"
#import "DetailViewController.h"

#define COLLECTION_ADDR         @"collect_front_collectFrontList.do"
#define DEL_COLLECTION_ADDR     @"collect_front_delCollectFront.do"

@interface CollectionTableViewController : UITableViewController<MWPhotoBrowserDelegate>
{
    NSMutableArray *messages;
    
    BOOL isLastPage;
    
    BOOL isReload;
    
    UIActivityIndicatorView *indicator;
    
    int delMessNo;
    
    MWPhoto *preImage;
}

@property (nonatomic,retain) NSMutableArray *messages;

@property (nonatomic,retain) MWPhoto *preImage;

@end
