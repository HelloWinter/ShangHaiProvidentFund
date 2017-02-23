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

/**
 *  网页加载完成后可调用执行的js代码
 */
@property (nonatomic, copy) NSString *javaScriptCode;

/**
 *  快速创建网页控制器实例
 */
+ (instancetype)webViewWithURL:(NSURL *)url;

/**
 *  快速创建网页控制器实例
 */
+ (instancetype)webViewWithURL:(NSURL *)url Configuration:(WKWebViewConfiguration*)configuration;

/**
 *  加载网页源代码
 *
 *  @param HTMLString 网页源代码
 */
- (void)loadWithHTMLString:(NSString *)HTMLString;

/**
 *  刷新网页
 */
- (void)refreshWebView;

@end
