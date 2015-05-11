//
//  KnowledgeViewController.h
//  Meiju
//
//  Created by Brustar XRL on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "NewsDetailViewController.h"
#import "Classificatory.h"
#import "PopUpBox.h"
#import "Knowledge.h"

#define KNOWLEDGE_URL           @"comsenseListFromFront.do"
#define KNOWLEDGE_CATE_URL      @"allSeseTypesFromFront.do"
#define CAR_KNOWLEDGE           @"汽车常识"

@interface KnowledgeViewController : UITableViewController
{
    NSMutableData *receivedData;
    NSURLConnection *cateConn,*listConn,*moreConn,*filteConn;
    NSMutableArray *knowledgeArray;
    int pageNo,serverPages;		//当前页,服务器上的总页数
    NSString *param;
    
    NewsDetailViewController *details;
    id categoryBox;     //重要：用id以防止互相嵌套。
}

@property(nonatomic,retain) NSURLConnection *cateConn,*listConn,*moreConn,*filteConn;
@property(nonatomic,retain) NSMutableArray *knowledgeArray;
@property(nonatomic,retain) NSString *param;
@property(nonatomic,retain) NewsDetailViewController *details;
@property(nonatomic,retain) id categoryBox;     //重要：用id以防止互相嵌套。
@property(nonatomic) int pageNo,serverPages;		//当前页,服务器上的总页数

-(NSMutableArray *)fetchKnowledgeArrayFromJSON:(NSString *)data;
-(void)searchClassificatory:(NSString *) typeId;

@end
