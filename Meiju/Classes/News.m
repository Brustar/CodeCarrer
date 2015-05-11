//
//  News.m
//  Meiju
//
//  Created by brustar on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize newsId,title,content,picAddr;

-(id)createNews:(NSString *)json
{	
	self.picAddr=[DataSource fetchValueFormJsonObject:json forKey:@"picAddr"];
	self.title=[DataSource fetchValueFormJsonObject:json forKey:@"title"];
	self.content=[DataSource fetchValueFormJsonObject:json forKey:@"content"];
	return self;
}

+(id)newsWithId:(NSString *)nid
{
	News *news=[[[News alloc] init] autorelease];
	news.newsId=nid;
	return news;
}

@end
