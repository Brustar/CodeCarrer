//
//  CustomUIBarButtonItem.h
//  Meiju
//
//  Created by brustar on 12-4-29.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBarButtonItem (CustomUIBarButtonItem) 

+(UIBarButtonItem*)barButtonItemWithTint:(UIColor*)color andTitle:(NSString*)itemTitle andTarget:(id)theTarget andSelector:(SEL)selector;  
+(UIBarButtonItem*)barButtonItemWithTint:(UIColor*)color andImage:(UIImage*)img andTarget:(id)theTarget andSelector:(SEL)selector;  

@end  