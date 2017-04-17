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


- (void)loadWithURL:(NSURL *)URL;
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
