//
//  ThreeChessGameAppDelegate.h
//  ThreeChessGame
//
//  Created by brustar on 12-6-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThreeChessGameViewController;

@interface ThreeChessGameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ThreeChessGameViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ThreeChessGameViewController *viewController;

@end

