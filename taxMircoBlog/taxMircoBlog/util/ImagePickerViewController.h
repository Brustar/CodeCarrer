//
//  HeaderSelectViewController.h
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-13.
//
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"

@protocol PickerDelegate;

@interface ImagePickerViewController : UIViewController
{
    NSMutableArray *datasource;
    id<PickerDelegate> delegate;
}

@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) id<PickerDelegate> delegate;

- (id)initWithDatasource:(NSArray *)data;
- (void)presentModallyOn:(UIViewController *)parent;

@end

@protocol PickerDelegate <NSObject>

@required

- (void)imagePicker:(ImagePickerViewController *)view didChoose:(int)tag;

@end