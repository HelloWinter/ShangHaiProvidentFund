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
    /**
     *  从普通URL加载网页
     */
    CDWebViewLoadTypeURLString,
    /**
     *  从html内容字符串加载网页
     */
    CDWebViewLoadTypeHTMLContentString,
    /**
     *  从本地html静态页面加载网页
     */
    CDWebViewLoadTypeLocalFilePath
};

@interface CDBaseWKWebViewController : CDBaseViewController

@property (nonatomic, strong, readonly) WKWebView *wkWebView;
/**
 *  何种方法加载网页
 */
@property (nonatomic, assign, readonly) CDWebViewLoadType loadType;
/**
 *  在网页加载完成时要执行的用户脚本
 */
@property (nonatomic, copy) NSArray<WKUserScript *> *arrWKUserScript;
/**
 *  隐藏导航栏
 */
@property (nonatomic, assign, getter=isNavHidden) BOOL navHidden;
/**
 *  是否显示网页加载进度条
 */
@property (nonatomic) BOOL showProgressView;
/**
 *  从普通URL加载网页
 */
@property (nonatomic, copy) NSString *URLString;
/**
 *  从html内容字符串加载网页
 */
@property (nonatomic, copy) NSString *HTMLContentString;
/**
 *  从本地html静态页面加载网页
 */
@property (nonatomic, copy) NSString *localFilePath;

- (void)reload;

@end
