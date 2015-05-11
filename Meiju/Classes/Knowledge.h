//
//  Knowledge.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "News.h"

@interface Knowledge : News
{
    NSString *cate;
}

@property (nonatomic, copy) NSString *cate;

@end
