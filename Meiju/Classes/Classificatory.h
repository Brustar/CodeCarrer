//
//  Category.h
//  Meiju
//
//  Created by brustar on 12-5-8.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Classificatory : NSObject {
	NSString *typeId,*typeName,*parentId;
}

+ (id)categoryWithId:(NSString *)categoryId name:(NSString *)categoryName parentId:(NSString *)parentId;

@property (nonatomic, copy) NSString *typeId,*typeName,*parentId;

@end
