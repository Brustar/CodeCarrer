//
//  Catalog.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "MasterViewController.h"

@interface CatalogController : UITableViewController
{
    NSArray *catas,*icons; 
    id master;              //此处不能与MasterViewController互相嵌套所以用id
}

@property (strong, nonatomic) NSArray *catas;
@property (strong, nonatomic) NSArray *icons;
@property (nonatomic,retain) id master;

@end
