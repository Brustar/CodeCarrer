//
//  Message.m
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize msgID,msgTitle,category,content,issueTime,isTop,collectCount,commentCount,picAddr;

-(NSString *)fetchIcon
{
    NSString *iconName=[NSString stringWithFormat:@""];
    if([self.isTop isEqualToString:@"1"]){
        iconName=@"Stick";
    }else{
        if([self.category isEqualToString:@"1"]){
            iconName=@"comment";
        }else if([self.category isEqualToString:@"2"]){
            iconName=@"PolicyStudies";
        }else if([self.category isEqualToString:@"3"]){
            iconName=@"Taxtittle-tattle";
        }
    }
    return iconName;
}

+(id)fetchMessagesFormJson:(NSArray *) array
{
	
	NSMutableArray *retArray=[[[NSMutableArray alloc] init] autorelease];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
			//stringWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *msgId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"msgId"]];
			Message *mess=[[[Message alloc]init] autorelease];
            mess.msgID=msgId;
            mess.collectCount=[NSString stringWithFormat:@"%@",[dic objectForKey:@"collectCount"]];
            mess.commentCount=[NSString stringWithFormat:@"%@",[dic objectForKey:@"commentCount"]];
            mess.content=[dic objectForKey:@"content"];
            mess.isTop=[NSString stringWithFormat:@"%@",[dic objectForKey:@"isTop"]];
            mess.issueTime=[dic objectForKey:@"issueTime"];
            mess.msgTitle=[dic objectForKey:@"msgTitle"];
            mess.category=[NSString stringWithFormat:@"%@",[dic objectForKey:@"category"]];
            mess.picAddr=[dic objectForKey:PIC_KEY];
			[retArray addObject:mess];
		}
	}
	return retArray;
}

@end
