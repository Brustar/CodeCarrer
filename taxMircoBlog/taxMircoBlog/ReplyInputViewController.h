//
//  ReplyInputViewController.h
//  taxMircoBlog
//
//  Created by Brustar XRL on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "DataSource.h"
#import "SessionUtil.h"
#import "Comment.h"

#define REPLY_URL  @"comment_front_addCommentFront.do"

@interface ReplyInputViewController : UIViewController<UITextViewDelegate>
{
    UILabel *tips;
    UITextView *content;
    Message *mess;
    NSString *cusId;
}

@property (strong, nonatomic) Message *mess;
@property (strong, nonatomic) NSString *cusId;

@end
