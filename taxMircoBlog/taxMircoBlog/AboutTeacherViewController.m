//
//  AboutTeacherViewController.m
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-7.
//
//

#import "AboutTeacherViewController.h"

@interface AboutTeacherViewController ()

@end

@implementation AboutTeacherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title=@"关于郭伟";
    self.view.backgroundColor=SYS_BG;
    [self createUI];
}

- (void) createUI
{
    UILabel *des=[UIMakerUtil createLabel:INTRODUCE frame:CGRectMake(10, 60, 300, 300)];
    des.numberOfLines=0;
    //des.textColor=[UIColor grayColor];
    des.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:des];
    
    UIImageView *headImage=[UIMakerUtil createImageView:@"face" frame:CGRectMake(135, 20, 50, 50)];
    [self.view addSubview:headImage];
}

@end
