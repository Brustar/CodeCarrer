//
//  Message.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantUtil.h"

@interface Message : NSObject
{
    NSString *msgID;            //消息ID
    NSString *msgTitle;         //标题
    NSString *category;         //消息类别
    NSString *content;          //内容
    NSString *issueTime;        //发布时间
    NSString *isTop;            //置顶
    NSString *collectCount;      //收藏人数
    NSString *commentCount;     //评论人数
    NSString *picAddr;          //图片地址
}

@property (nonatomic, copy) NSString *msgID,*msgTitle,*category, *content,*issueTime,*isTop,*collectCount,*commentCount,*picAddr;

-(NSString *)fetchIcon;
+(id)fetchMessagesFormJson:(NSArray *) array;

@end
