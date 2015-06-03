//
//  UpdatePWDViewController.h
//  taxMircoBlog
//
//  Created by XRL Brustar on 12-11-8.
//
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "SessionUtil.h"
#import "DataSource.h"
#import "Md5Util.h"
#import "CustomCell.h"

#define UPDATE_PWD_URL  @"customer_front_updateCustomerPwd.do"

@interface UpdatePWDViewController : UITableViewController
{
    NSArray *titles;
}

@property (strong, nonatomic) NSArray *titles;

@end
