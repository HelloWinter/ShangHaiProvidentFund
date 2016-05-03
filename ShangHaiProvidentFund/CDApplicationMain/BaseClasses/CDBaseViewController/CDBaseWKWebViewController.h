//
//  CDBaseWKWebViewController.h
//  CDAppDemo
//
//  Created by cdd on 15/9/24.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

/**
 *  iOS8以上适用
 */

#import "CDBaseViewController.h"
#import <WebKit/WebKit.h>

@interface CDBaseWKWebViewController : CDBaseViewController

@property (nonatomic, strong, readonly) WKWebView *webView;

+ (instancetype)webViewWithURL:(NSURL *)url;

+ (instancetype)webViewWithURL:(NSURL *)url Configuration:(WKWebViewConfiguration*)configuration;

/**
 *  刷新网页
 */
- (void)refresh;


- (void)loadHTMLString:(NSString *)HTMLString;

@end
