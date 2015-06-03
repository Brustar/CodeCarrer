//
//  Device.m
//  HelloLua
//
//  Created by lexun05 on 15/3/24.
//
//

#import "Device.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <netdb.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <AdSupport/ASIdentifierManager.h> 
#import <SystemConfiguration/SystemConfiguration.h>

#import "runtime/Runtime.h"

@implementation Device

+ (NSString *) imei
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (int) kindofNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);    
    SCNetworkReachabilityFlags flags;
    
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        //return @"NONETWORK";
    }

    int type = 0;
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        type = 2;
    }

    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            type = 2;
        }
    }

    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        type = 1;
    }
    return type;
}

+ (NSString *) OSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *) ip
{
    return [NSString stringWithUTF8String:getIPAddress().c_str()];
}

+ (NSString *) macAddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex errorn");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1n");
        return NULL;
    }
    
    if ((buf = (char *)malloc(len)) == NULL) {
        printf("Could not allocate memory. error!n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%X:%X:%X:%X:%X:%X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (BOOL) networkReachable
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);    
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) 
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (void) showPage:(NSDictionary *)dict
{
    NSString *aUrl=[dict objectForKey:@"url"];
    NSString* title=[dict objectForKey:@"title"];
    
    OAuthViewController *oauthViewController = [[OAuthViewController alloc] initWithUrl:aUrl title:title];
    //[[WebViewController shared] setScriptHandler:[[dict objectForKey:@"callBack"] intValue]];
    
    UINavigationController *controller = [[[UINavigationController alloc] initWithRootViewController:oauthViewController] autorelease];
    
    oauthViewController.navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    oauthViewController.navigationController.navigationBarHidden = NO;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController dismissModalViewControllerAnimated:NO];
    [rootViewController presentModalViewController:controller animated:YES];
}

+ (void) showDate:(NSDictionary *)dict
{
    int scriptHandler = [[dict objectForKey:@"callBack"] intValue];
    
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    CGSize showSize = [DataPickerView getShowSize];
    CGRect rect = CGRectMake((winSize.width - showSize.width)/2, (winSize.height - showSize.height)/2, showSize.width, showSize.height);
    DataPickerView *datePicker = [[[DataPickerView alloc] initWithFrame:rect] autorelease];
    [datePicker setScriptHandler:scriptHandler];
    CCEAGLView *eaglView = (CCEAGLView*)cocos2d::Director::getInstance()->getOpenGLView()->getEAGLView();
    [eaglView addSubview:datePicker];
}

@end