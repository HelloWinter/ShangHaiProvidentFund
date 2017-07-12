//
//  CDBaseWKWebViewController.h
//  CDAppDemo
//
//  Created by cdd on 16/9/24.
//  Copyright (c) 2016年 Cheng. All rights reserved.
//

/**
 *  iOS8以上适用
 */

#import "CDBaseViewController.h"
#import <WebKit/WebKit.h>

typedef NS_ENUM(NSInteger,CDWebViewLoadType) {
    CDWebViewLoadTypeURLString,
    CDWebViewLoadTypeHTMLContentString
};

@interface CDBaseWKWebViewController : CDBaseViewController

@property (nonatomic, strong) WKWebViewConfiguration *Configuration;
@property (nonatomic, strong, readonly) WKWebView *wkWebView;
@property (nonatomic, assign, readonly) CDWebViewLoadType loadType;
@property (nonatomic, assign, getter=isNavHidden) BOOL navHidden;
@property (nonatomic, copy) NSString *URLString;
@property (nonatomic, copy) NSString *HTMLContentString;

- (void)reload;

@end
