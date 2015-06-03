//
//  UDMacros.h
//
//  Created by Rolandas Razma on 11/14/09.
//  Copyright 2009 UD7. All rights reserved.
//
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON ) 

static BOOL isDeviceIPad(){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        return YES;
    }
#endif
    return NO;
}
