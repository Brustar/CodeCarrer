//
//  Category.m
//  Meiju
//
//  Created by brustar on 12-5-8.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Classificatory.h"


@implementation Classificatory

@synthesize typeId,typeName,parentId;

+ (id)categoryWithId:(NSString *)categoryId name:(NSString *)categoryName parentId:(NSString *)parentId
{
	Classificatory *newCategory = [[[self alloc] init] autorelease];
	newCategory.typeId = categoryId;
	newCategory.typeName = categoryName;
	newCategory.parentId = parentId;
	return newCategory;
}

@end
