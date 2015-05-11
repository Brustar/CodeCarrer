//
//  News.h
//  Meiju
//
//  Created by brustar on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantUtil.h"
#import "DataSource.h"

#define NEWS_DETAIL_URL @"/newsDetailsFront.do"
#define NEWS_ID		@"newsId"

@interface News : NSObject {

	NSString *newsId;
	NSString *title;
	NSString *content;
	NSString *picAddr;
	
}

-(id)createNews:(NSString *)nid;
+(id)newsWithId:(NSString *)nid;

@property (nonatomic, retain) NSString *newsId,*title,*content,*picAddr;

@end
