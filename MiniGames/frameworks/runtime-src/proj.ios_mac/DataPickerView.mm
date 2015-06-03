//
//  DataPickerView.m
//  CocosLuaGame
//
//  Created by zhoukaijun on 15-1-25.
//
//

#import "DataPickerView.h"

#include "cocos2d.h"
#include "CCEAGLView-ios.h"
#include "CCLuaEngine.h"
#include "CCLuaBridge.h"
using namespace cocos2d;

#define ShowSize CGSizeMake(280, 200)
#define BtnSize CGSizeMake(80, 30)

@interface DataPickerView()
@property (nonatomic,assign)UIDatePicker *datePicker;
@end

@implementation DataPickerView
@synthesize delegate;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

-(id)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if(self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView *view = [[[UIView alloc] initWithFrame:frame] autorelease];
        [self addSubview:view];
        
        [view setClipsToBounds:YES];
        [view setBackgroundColor:[UIColor lightGrayColor]];
        
        CGRect rect = CGRectMake(0, 0, ShowSize.width, 20);
        UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];
        [label setText:@"选择日期"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:label];
        
        rect = CGRectMake(-ShowSize.width/2, 20, 0, 0);
        UIDatePicker *datePicker = [[[UIDatePicker alloc] initWithFrame:rect] autorelease];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [view addSubview:datePicker];
        self.datePicker = datePicker;
        
        CGSize btnSize = BtnSize;
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rect = CGRectMake(ShowSize.width/4 - btnSize.width/2, ShowSize.height - btnSize.height, btnSize.width, btnSize.height);
        [sureBtn setFrame:rect];
//        [sureBtn setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
        [sureBtn addTarget:self action:@selector(sureCall:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:sureBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rect = CGRectMake(ShowSize.width/4*3 - btnSize.width/2, ShowSize.height - btnSize.height, btnSize.width, btnSize.height);
        [cancelBtn setFrame:rect];
//        [cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:btnSize.height]];
//        [cancelBtn setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
        [cancelBtn addTarget:self action:@selector(cancelCall:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cancelBtn];
        self.delegate=self;
        [self zoomIn:view andAnimationDuration:0.5];
    }
    return self;
}

-(void)sureCall:(id)sender
{
    NSDate *date = self.datePicker ? self.datePicker.date : Nil;
    [delegate sureItemCall:date];
    [self removeFromSuperview];
}

-(void)cancelCall:(id)sender
{
    NSDate *date = self.datePicker ? self.datePicker.date : Nil;
    [delegate cancelItemCall:date];
    [self removeFromSuperview];
}

-(void)zoomIn:(UIView *)view andAnimationDuration:(float)duration
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [view.layer addAnimation:animation forKey:nil];
}

-(NSDate*)getDataPickerDate
{
    if(self.datePicker)
    {
        return self.datePicker.date;
    }
    return nil;
}

+(CGSize)getShowSize
{
    return ShowSize;
}

+(void)showView:(NSDictionary*)dict
{
    CGSize size = [[[UIApplication sharedApplication] keyWindow] rootViewController].view.bounds.size;
    CCEAGLView *glView = (CCEAGLView*)Director::getInstance()->getOpenGLView()->getEAGLView();
    CGSize showSize = ShowSize;
    CGRect rect = CGRectMake((size.width - showSize.width)/2, (size.height - showSize.height)/2, showSize.width, showSize.height);
    DataPickerView *view = [[[DataPickerView alloc] initWithFrame:rect] autorelease];
    [glView addSubview:view];
}

-(void)scriptHandlerCall:(NSString*)data
{
    if(self.scriptHandler)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            const char *dataStr = [data UTF8String];
            LuaBridge::pushLuaFunctionById(self.scriptHandler);
            LuaStack *stack = LuaBridge::getStack();
            stack->pushString(dataStr);
            stack->executeFunction(1);
        });
    }
}

-(void)sureItemCall:(NSDate*)date
{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dataStr = [formatter stringFromDate:date];
    [self scriptHandlerCall:dataStr];
}

-(void)cancelItemCall:(NSDate*)date
{
}

@end
