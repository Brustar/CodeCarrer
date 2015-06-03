//
//  OAuthViewController.h
//  UniSocial
//
//  Created by Ren Chonghui on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAuthViewController : UIViewController <UIWebViewDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *oauthUrl;
@property (nonatomic, retain) NSString *html;

@property (nonatomic, retain) NSArray *platformNameArray;
@property (nonatomic, retain) NSArray *platformGameObjectArray;
@property (nonatomic, retain) UIActivityIndicatorView *waitingIndicator;

- (id)initWithHtml:(NSString *)html;
- (id)initWithUrl:(NSString *)aUrl title:(NSString *)title;

@end
