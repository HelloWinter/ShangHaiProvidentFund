//
//  SCYBaseWebViewController.h
//  ProvidentFund
//
//  Created by cdd on 16/3/24.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseViewController.h"

@interface SCYBaseWebViewController : CDBaseViewController

@property (nonatomic, strong, readonly) UIWebView *webView;

/**
 *  实例化简单方法
 *
 *  @param url 请求的URL
 *
 *  @return SCYBaseWebViewController对象
 */
+ (SCYBaseWebViewController *)webViewControllerWithURL:(NSURL *)url;

/**
 *  刷新当前页面
 */
- (void)refresh;

/**
 *  加载HTML字符串源码
 *
 *  @param HTMLString HTML字符串源码
 */
- (void)loadHTMLString:(NSString *)HTMLString;

@end
