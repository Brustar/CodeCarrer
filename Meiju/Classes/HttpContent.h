//
//  PostWebContentViewController.h
//  PostWebContent
//

#import <UIKit/UIKit.h>
#import "UIMakerUtil.h"
#import "ConstantUtil.h"

@interface HttpContent : NSObject {
	
}

+(HttpContent *) sharedHttpContent;
-(NSURLConnection *)createPostConnection:(NSURL *)url param:(NSString *)param delegate:(id) obj;
-(NSURLConnection *)createGetConnection:(NSURL *)url delegate:(id) obj;
@end

