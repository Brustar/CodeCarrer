//
//  Advertisement.h
//  Meiju
//
//  Created by brustar on 12-5-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Advertisement : NSObject {
	NSString *adId;
	NSString *isShow;
	NSString *adName;
	NSString *link;
	NSString *picAddr;
}

-(int) forwardNumber;

@property (nonatomic, copy) NSString *adId,*isShow,*adName,*link,*picAddr;

@end
