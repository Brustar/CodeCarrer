//
//  TopViewController.m
//  Meiju
//
//  Created by brustar on 12-5-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TopViewController.h"


@implementation UIView (TopViewController) 

- (UIViewController *) firstViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

@end
