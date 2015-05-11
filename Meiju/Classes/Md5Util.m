//
//  Md5Util.m
//  Meiju
//
//  Created by Simon Zhou on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Md5Util.h"

@implementation Md5Util

+(NSString *)md5:(NSString *)str { 
    
    const char *cStr = [str UTF8String]; 
    
    unsigned char result[32]; 
    
    CC_MD5( cStr, strlen(cStr), result ); 
    
    return [NSString stringWithFormat: 
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3], 
            
            result[4], result[5], result[6], result[7], 
            
            result[8], result[9], result[10], result[11], 
            
            result[12], result[13], result[14], result[15] 
            
            ]; 
    
    
    
}

@end
