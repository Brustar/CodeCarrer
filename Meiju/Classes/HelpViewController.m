//
//  HelpViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HelpViewController.h"
#import "MoreViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

@synthesize scroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=HELP_TITLE;
    self.scroll=[UIMakerUtil createScrollView];
    self.scroll.contentSize=CGSizeMake(1,750);
    
    NSArray *details=[NSArray arrayWithObjects:@"以图文并茂的形式，介绍本商城最新的特惠活动及公告信息。",@"向用户介绍本商城的合作商户的优惠信息和商户介绍，包括4s店、汽车美容店等。",@"用户可浏览和查询所需汽车用品，包含各种特价、促销、新品等。并提供电话订购和在线订购两种形式进 行商品的及时购买支付。",@"提供用户与用户之间进行商品交易的平台。用户可在该平台上发布预售和求购的商品信息，并直接与其他 用户取得联系，达成交易。",@"供用户查看并编辑个人联系信息、收货地址等。",@"提供其他各种与汽车生活有关的保养常识、车险计算、出险报案理赔等辅助功能。", nil];
    NSArray *titles=[NSArray arrayWithObjects:@"￼￼特惠快讯",@"优惠商户",@"手机商城",@"跳蚤市场",@"帐户设置",@"其他辅助功能", nil];
    
    CGRect rect=CGRectMake(0, 10, 80, 20);
    for (NSString *title in titles) {
       [self.scroll addSubview:[UIMakerUtil createTitleLabel:title frame:rect]]; 
        rect.origin.y+=110;
    }
    
    CGRect detailRect=CGRectMake(0, 40, self.view.frame.size.width, 80);
    for (NSString *detail in details) {
        [self.scroll addSubview:[UIMakerUtil createTextAreaView:detail frame:detailRect]]; 
        detailRect.origin.y+=110;
    }
    [self.view addSubview:scroll];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc
{
    [super dealloc];
    [scroll release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
