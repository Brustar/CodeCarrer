//
//  Area.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject
{
    NSString *areaId;
    NSString *areaName;
    NSString *parentId;
    NSString *remark;
}

@property (nonatomic, retain) NSString *areaId,*areaName,*parentId,*remark;

@end
