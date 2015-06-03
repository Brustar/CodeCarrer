//
//  HeaderSelectViewController.m
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-13.
//
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController ()

@end

@implementation ImagePickerViewController

@synthesize datasource,delegate;

- (id)initWithDatasource:(NSArray *)data
{
    self = [self init];
    if (self) {
        self.datasource = [NSMutableArray arrayWithArray:data];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=SYS_BG;
    [self createUI];
}

- (void)createUI
{
    for (int j=0; j<[self.datasource count]/5+1; j++) {
        for (int i=0; i < 5 && j*5+i<[self.datasource count]; i++) {
            CGRect rect=CGRectMake(10+(50 * i + 10 * i), 10+(50 * j + 10 * j), 50, 50);
            UIButton *headView = [UIMakerUtil createImageButton:[self.datasource objectAtIndex:j*5+i] light:nil frame:rect];
            headView.tag = j*5+i;
            [headView addTarget:self action:@selector(imageSelect:) forControlEvents:UIControlEventTouchUpInside];
            UIView *view=[UIMakerUtil createRoundedRectView:rect];
            [[view layer] setCornerRadius:1.0];
            [self.view addSubview:view];
            [self.view addSubview:headView];
        }
    }
}

-(IBAction)imageSelect:(UIButton *)sender
{
    [self.delegate imagePicker:self didChoose:sender.tag];
}

- (void)presentModallyOn:(UIViewController *)parent
{
    UINavigationController *nav;
    // Create a navigation controller with us as its root.
    nav = [[[UINavigationController alloc] initWithRootViewController:self] autorelease];
    assert(nav != nil);
    // Set up the Cancel button on the left of the navigation bar.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)] autorelease];
    assert(self.navigationItem.leftBarButtonItem != nil);
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    // Present the navigation controller on the specified parent
    // view controller.
    
    [parent presentModalViewController:nav animated:YES];
}

- (void)cancelAction:(id)sender
{
    // Tell the delegate about the cancellation.
    if ( (self.delegate != nil) && [self.delegate respondsToSelector:@selector(imagePicker:didChoose:)] ) {
        [self.delegate imagePicker:self didChoose:-1];
    }
}

@end
