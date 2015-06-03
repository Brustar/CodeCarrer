//
//  Comment.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
{
    NSString *commentId;            //评论ID
    NSString *picHead;              //头像
    NSString *cusId;                //评论人ID
    NSString *nickName;             //评论人名字
    NSString *cusReplyName;         //回复评论名字
    NSString *content;              //内容
    NSString *issueTime;            //发布时间
}

@property (nonatomic, copy) NSString *commentId,*picHead,*cusId,*nickName,*cusReplyName,*content,*issueTime;

@end
