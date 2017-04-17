//
//  CDBaseWKWebViewController.m
//  CDAppDemo
//
//  Created by cdd on 15/9/24.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "CDBaseWKWebViewController.h"
#import "UIBarButtonItem+CDCategory.h"

static void *CDWebBrowserContext = &CDWebBrowserContext;

@interface CDBaseWKWebViewController ()<WKNavigationDelegate,WKUIDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,WKScriptMessageHandler>

/**
 *  是否在导航条显示URL,默认(NO)
 */
//@property (nonatomic, assign) BOOL showURLInNavigationBar;

/**
 *  是否在导航条显示PageTitle,默认(NO)
 */
//@property (nonatomic, assign) BOOL showPageTitleInNavigationBar;

/**
 *  UIWebView的url
 */
//@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) WKWebViewConfiguration *configuration;

@property (nonatomic, copy) NSString *javaScriptCode;

/**
 *  进度条颜色
 */
@property (nonatomic, strong) UIColor *progressViewTintColor;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation CDBaseWKWebViewController
@synthesize webView=_webView;

- (void)dealloc {
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

//+ (instancetype)webViewWith{
//    return [self webViewWithURL:url Configuration:nil];
//}
//
//+ (instancetype)webViewWithConfiguration:(WKWebViewConfiguration *)configuration{
//    CDBaseWKWebViewController *webView=[[self alloc]init];
//    webView.configuration=configuration;
//    return webView;
//}

- (instancetype)init{
    self =[super init];
    if (self) {
//        self.showURLInNavigationBar = NO;
//        self.showPageTitleInNavigationBar = NO;
        
    }
    return self;
}

- (instancetype)initWithConfiguration:(WKWebViewConfiguration *)configuration{
    self = [super init];
    if (self) {
        if (configuration) {
            self.configuration=configuration;
        }
        self.hidesBottomBarWhenPushed=YES;
        self.progressViewTintColor=[UIColor greenColor];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
//    if (self.url) {
//        [self loadWithURL:self.url];
//    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    }
    [self.progressView removeFromSuperview];
}

- (WKWebView *)webView{
    if (_webView==nil) {
        if (self.configuration) {
            _webView =[[WKWebView alloc]initWithFrame:self.view.bounds configuration:self.configuration];
        }else{
            //        WKUserScript *script=[[WKUserScript alloc]initWithSource:self.javaScriptCode injectionTime:(WKUserScriptInjectionTimeAtDocumentEnd) forMainFrameOnly:YES];
            //        WKUserContentController *contentController=[[WKUserContentController alloc]init];
            //        [contentController addUserScript:script];
            //        WKWebViewConfiguration *configure=[[WKWebViewConfiguration alloc]init];
            //        configure.userContentController=contentController;
            _webView = [[WKWebView alloc] init];
            _webView.frame=self.view.bounds;
        }
        if (!self.navigationController.navigationBarHidden) {
            _webView.height-=64;
        }
        _webView.navigationDelegate=self;
        _webView.UIDelegate=self;
        [_webView setMultipleTouchEnabled:YES];
        [_webView.scrollView setAlwaysBounceVertical:YES];
        [_webView sizeToFit];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:CDWebBrowserContext];
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (_progressView==nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [_progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
        [_progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
        if (self.progressViewTintColor) {
            [_progressView setTintColor:self.progressViewTintColor];
        }
        [_progressView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-_progressView.frame.size.height, self.view.frame.size.width, _progressView.frame.size.height)];
    }
    return _progressView;
}

#pragma mark - WKNavigationDelegate
///**
// *  决定是否允许或取消导航
// */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    if(webView == self.webView) {
//        NSURL *URL = navigationAction.request.URL;
//        if(![self isJumpToExternalAppWithURL:URL]) {
//            if(!navigationAction.targetFrame) {
//                [self loadWithURL:URL];
//                decisionHandler(WKNavigationActionPolicyCancel);
//                return;
//            }
//        }
//        //        else if([[UIApplication sharedApplication] canOpenURL:URL]) {
//        //            [self launchExternalAppWithURL:URL];
//        //            decisionHandler(WKNavigationActionPolicyCancel);
//        //            return;
//        //        }
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//}

/**
 *  确定在响应已知后是否允许或取消导航
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
}

/**
 *  main frame开始加载时调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self updateNavgationLeftBtn];
}

/**
 *  当接收到main frame的服务器重定向时调用
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

/**
 *  在开始加载主框架的数据时发生错误时调用
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self updateNavgationLeftBtn];
}

/**
 *  Invoked when content starts arriving for the main frame
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}

/**
 *  Invoked when a main frame navigation completes
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self updateNavgationLeftBtn];
}

/**
 *  Invoked when an error occurs during a committed main frame navigation.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [self updateNavgationLeftBtn];
}

#pragma mark - Estimated Progress KVO (WKWebView)
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - override
- (void)cd_backOffAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [super cd_backOffAction];
    }
}

#pragma mark - public
- (void)loadWithURL:(NSURL *)URL {
    NSURLRequest *request=[NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    [self.webView loadRequest:request];
}

- (void)loadWithHTMLString:(NSString *)HTMLString {
    [self.webView loadHTMLString:HTMLString baseURL:nil];
}

- (void)refreshWebView{
    [self.webView reload];
}

#pragma mark - private
/**
 *  更新导航栏左侧按钮
 */
- (void)updateNavgationLeftBtn{
    if (self.webView.canGoBack) {
        UIBarButtonItem *leftItem = [UIBarButtonItem cd_ItemWidth:20 imageName:@"navigation_backOff" target:self action:@selector(cd_backOffAction)];
        
        UIBarButtonItem *leftItemClose = [UIBarButtonItem cd_ItemWidth:40 title:@"关闭" titleColor:[UIColor whiteColor] target:self action:@selector(backToOriginalViewController)];
        self.navigationItem.leftBarButtonItems = @[leftItem,leftItemClose];
    }else{
        UIBarButtonItem *leftItem = [UIBarButtonItem cd_ItemWidth:20 imageName:@"navigation_backOff" target:self action:@selector(cd_backOffAction)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)backToOriginalViewController{
    [super cd_backOffAction];
}

/**
 *  url是否是跳转APP类型的
 *
 *  @param URL
 *
 *  @return BOOL
 */
//- (BOOL)isJumpToExternalAppWithURL:(NSURL *)URL{
//    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
//    return ![validSchemes containsObject:URL.scheme];
//}

@end
