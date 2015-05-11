//
//  NewsDetailViewController.h
//  Meiju
//
//  Created by brustar on 12-4-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIMakerUtil.h"
#import "ConstantUtil.h"
#import "News.h"
#import "StoreNewsViewController.h"

#define NEWS_IMAGE_SIZE 240

@interface NewsDetailViewController : UIViewController {
	
	News *news;
    UIScrollView *scrollView;
	NSMutableData *receivedData;
    BOOL showRight;
}

-(void) createUI;

@property (nonatomic, retain) News *news;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic) BOOL showRight;

@end
