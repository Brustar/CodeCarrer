//
//  ThreeLib.m
//  threeUniversal
//
//  Created by 肖智伟 on 13-4-11.
//
//

#import "ThreeLib.h"

@implementation ThreeLib

+ (NSString *)textureName {
    if( [[CCDirector sharedDirector] contentScaleFactor] > 1.0f ){
        return @"sprites~ipad.png";
    }
    
    return [NSString stringWithFormat:@"sprites%@.png", (isDeviceIPad()?@"~ipad":@"")];
}

+ (NSString *)texturePlistName {
    if( [[CCDirector sharedDirector] contentScaleFactor] > 1.0f ) {
        return @"sprites~ipad.plist";
    }
    
    return [NSString stringWithFormat:@"sprites%@.plist", (isDeviceIPad()?@"~ipad":@"")];
}

@end
