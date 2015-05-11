//
//  MeijuAppDelegate.m
//  Meiju
//
//  Created by brustar on 12-4-11.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MeijuAppDelegate.h"

@implementation MeijuAppDelegate

@synthesize window;
@synthesize tabBarController;

- (BOOL)isSingleTask{
	struct utsname name;
	uname(&name);
	float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
	if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0) {
		return YES;
	}
	else {
		return NO;
	}
}

- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result) {
		//是否支付成功
		if (9000 == result.statusCode) {
			/*用公钥验证签名*/
			id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
			if ([verifier verifyString:result.resultString withSign:result.signString]) {
                [UIMakerUtil alert:@"支付成功。" title:@"提示"];
			}
			else //验签错误
            {
                [UIMakerUtil alert:@"签名错误" title:@"提示"];
			}
		}
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
            [UIMakerUtil alert:result.statusMessage title:@"提示"];
		}
		
	}	
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parseURL:url application:application];
	return YES;
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {        
    // Override point for customization after application launch.
	// Set the tab bar controller as the window's root view controller and display.
    //self.tabBarController.tabBar.selectedImageTintColor=ORANGE_BG;
    [UIMakerUtil checkNetworkConnected];
    
    self.window.rootViewController = self.tabBarController;
	//Cannot manually set the delegate on a UINavigationBar managed by a controller,when navigate back.
    //self.tabBarController.delegate=self;
    [self.window makeKeyAndVisible];
    
    [self autoLoginFromCookie];
    /* 单任务handleURL处理 */
	if ([self isSingleTask]) {
		NSURL *url = [launchOptions objectForKey:@"UIApplicationLaunchOptionsURLKey"];
		
		if (nil != url) {
			[self parseURL:url application:application];
		}
	}
    
    return YES;
}

-(void) autoLoginFromCookie
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        if ([cookie.domain isEqualToString:APP_HOST]) {
            [dic setObject:cookie.value forKey:cookie.name];
        }
    }

    if ([dic count]==5) {
        [UserViewController loginWithCookie:dic];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //[[[[viewController childViewControllers] allObjects] objectAtIndex:0] viewDidLoad];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

