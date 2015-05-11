//
//  FillString.h
//  Meiju
//
//  Created by brustar on 12-4-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (FillString) 

-(NSString *) fillZeroAtStart;
-(NSString *) RMBFormat;
-(NSString *) trim;
-(NSString *) insertBreakLine:(int) pos;
-(NSString *) insertBreakLine;

@end
