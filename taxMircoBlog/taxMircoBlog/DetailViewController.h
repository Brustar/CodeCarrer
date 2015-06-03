//
//  DetailViewController.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "SessionUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MWPhotoBrowser.h"
#import "DataSource.h"
#import "CustomCell.h"
#import "Message.h"
#import "Comment.h"
#import "ReplyInputViewController.h"
#import "LoginViewController.h"

#define COMMET_URL          @"comment_front_commentFrontList.do"
#define COLLECT_URL         @"collect_front_addCollectFront.do"
#define COMMET_TITLE        @"评论"
#define COLLECT_SUCCESS     @"添加收藏成功"

@interface DetailViewController : UITableViewController<MWPhotoBrowserDelegate>
{
    Message *mess;
    int tableTop;
    NSMutableArray *comments;
    BOOL isLastPage;
    BOOL isReload;  //重新刷新标志
    
    UIActivityIndicatorView *indicator;

    MWPhoto *preImage;
}

@property (strong, nonatomic) Message *mess;

@property (nonatomic) int tableTop;

@property (strong, nonatomic) NSMutableArray *comments;

@property (nonatomic, retain) MWPhoto *preImage;

@end
