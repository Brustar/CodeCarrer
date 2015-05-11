//
//  TopViewController.h
//  Meiju
//
//  Created by brustar on 12-5-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (TopViewController) 

- (UIViewController *) firstViewController;
- (id) traverseResponderChainForUIViewController;
@end
