//
//  CustomUIBarButtonItem.m
//  Meiju
//
//  Created by brustar on 12-4-29.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomUIBarButtonItem.h"


@implementation UIBarButtonItem (CustomUIBarButtonItem)  

+(UIBarButtonItem *)barButtonItemWithTint:(UIColor*)color andTitle:(NSString*)itemTitle andTarget:(id)theTarget andSelector:(SEL)selector  
{  
    UISegmentedControl *button = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:itemTitle, nil]] autorelease];  
    button.momentary = YES;  
    button.segmentedControlStyle = UISegmentedControlStyleBar;  
    button.tintColor = color;  
    [button addTarget:theTarget action:selector forControlEvents:UIControlEventValueChanged];  
	
    UIBarButtonItem *removeButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];  
	
    return removeButton;  
}  

+(UIBarButtonItem *)barButtonItemWithTint:(UIColor*)color andImage:(UIImage*)img andTarget:(id)theTarget andSelector:(SEL)selector  
{  
    UISegmentedControl *button = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:img, nil]] autorelease];  
    button.momentary = YES;  
    button.segmentedControlStyle = UISegmentedControlStyleBar;  
    button.tintColor = color;  
    [button addTarget:theTarget action:selector forControlEvents:UIControlEventValueChanged];  
	
    UIBarButtonItem *removeButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];  
	
    return removeButton;  
}  

@end