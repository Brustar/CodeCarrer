//
//  FavoritesViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "DataSource.h"
#import "FillString.h"
#import "FavoriteInfo.h"

#define FAVORITES_URL           @"/collectFrontList.do"
#define REMOVE_FAVORITES_URL     @"/delCollect.do"

@interface FavoritesViewController : UITableViewController
{
    NSMutableData *receivedData;
    NSMutableArray *favoritesArray;
    FavoriteInfo *removeInfo;
    NSURLConnection *removeConn,*listConn;
}

@property(nonatomic,retain) NSMutableData *receivedData;
@property(nonatomic,retain) NSMutableArray *favoritesArray;
@property(nonatomic,retain) FavoriteInfo *removeInfo;
@property(nonatomic,retain) NSURLConnection *removeConn,*listConn;

-(NSMutableArray *)fetchFavoritesFormJson:(NSString *)data;

@end
