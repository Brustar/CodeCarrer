//
//  DataPickerView.h
//  CocosLuaGame
//
//  Created by zhoukaijun on 15-1-25.
//
//

#import <UIKit/UIKit.h>

@protocol DataPickerViewDelegate<NSObject>
@optional
-(void)sureItemCall:(NSDate*)date;
-(void)cancelItemCall:(NSDate*)date;
@end

@interface DataPickerView : UIView<DataPickerViewDelegate>

@property(nonatomic, assign)id<DataPickerViewDelegate> delegate;
@property (nonatomic, assign) int scriptHandler;

+(CGSize)getShowSize;
-(id)initWithFrame:(CGRect)frame;

@end
