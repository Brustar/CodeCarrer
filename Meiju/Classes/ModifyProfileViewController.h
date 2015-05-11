//
//  ModifyProfileController.h
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstantUtil.h"
#import "UIMakerUtil.h"

#define MODIFY_PROFILE_URL  @"/updateCustmInfo.do"

@interface ModifyProfileViewController : UIViewController <UITextFieldDelegate>
{
    NSMutableData *receivedData;
}

@property(nonatomic,retain) NSMutableData *receivedData;

-(void) updateProfile;

@end
