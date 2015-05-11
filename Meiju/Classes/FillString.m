//
//  FillString.m
//  Meiju
//
//  Created by brustar on 12-4-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FillString.h"


@implementation  NSString (FillString)

-(NSString *) fillZeroAtStart
{
	if ([self hasPrefix:@"."]) {
		return [[[NSString alloc] initWithFormat:@"0%@",self] autorelease];
	}
	return self;	
}

-(NSString *) RMBFormat
{
	return [[[NSString alloc] initWithFormat:@"￥%@ 元",self] autorelease];
}

-(NSString *) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *) insertBreakLine
{
    return [self insertBreakLine:18];
}

-(NSString *) insertBreakLine:(int) pos
{
    if ([self length]>pos) {
        return [NSString stringWithFormat:@"%@\n%@",[self substringToIndex:pos],[self substringFromIndex:pos]];
    }else {
        return self;
    }
}

@end
