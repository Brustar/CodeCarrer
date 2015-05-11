//
//  NewsNavigateController.h
//  Meiju
//
//  Created by brustar on 12-4-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
#import "UIMakerUtil.h"
#import "ConstantUtil.h"
#import "NewsDetailViewController.h"
#import "News.h"

#define	NEWSURL	@"/newsListFromFront.do"  //快讯地址

@interface NewsViewController : UITableViewController {
	NSArray *arrNews;
	NSMutableArray *items;
	NewsDetailViewController *details;
	int start;
	
	NSMutableData *receivedData;
}

@property (nonatomic, retain) NewsDetailViewController *details;
@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,retain) NSArray *arrNews;

@end
