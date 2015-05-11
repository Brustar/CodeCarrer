//
//  Advertisement.m
//  Meiju
//
//  Created by brustar on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Advertisement.h"


@implementation Advertisement

@synthesize adId,isShow,adName,link,picAddr;

-(int) forwardNumber
{
	if ([self.link hasPrefix:@"http"]) {
		return 1;
	}
	else if ([self.link hasPrefix:@"goods"]) {
		return 2;
	}
	else if ([self.link hasPrefix:@"news"]) {
		return 3;
	}
	else if ([self.link hasPrefix:@"shop"]) {
		return 4;
	}
	else if ([self.link hasPrefix:@"shopInfo"]) {
		return 5;
	}
	return 0;
}

@end
