//
//  UserDelegate.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserDelegate <NSObject>

@required

- (void)forward:(UIViewController *)controller;

@end
