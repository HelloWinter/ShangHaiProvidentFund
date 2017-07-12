//
//  CDBaseWKWebViewController.m
//  CDAppDemo
//
//  Created by cdd on 16/9/24.
//  Copyright (c) 2016年 Cheng. All rights reserved.
//

#import "CDBaseWKWebViewController.h"
#import "UIBarButtonItem+CDCategory.h"

static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface CDBaseWKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate>

@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation CDBaseWKWebViewController
@synthesize wkWebView=_wkWebView;

- (instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isNavHidden == YES) {
        self.navigationController.navigationBarHidden = YES;
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
        statusBarView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:statusBarView];
    }else{
        self.navigationController.navigationBarHidden = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@""];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        _Configuration = [[WKWebViewConfiguration alloc]init];
        // 允许在线播放
        _Configuration.allowsInlineMediaPlayback = YES;
        // web内容处理池
        _Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
//        [UserContentController addScriptMessageHandler:self name:@""];
        // 是否支持记忆读取
        _Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        _Configuration.userContentController = UserContentController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) configuration:_Configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //KVO 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.view.frame.size.width, 2);
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        _progressView.progressTintColor = [UIColor colorWithRed:45.0f/255 green:142.0f/255 blue:255.0f/255 alpha:1];
    }
    return _progressView;
}

#pragma mark - public
- (void)setURLString:(NSString *)URLString{
    _loadType=CDWebViewLoadTypeURLString;
    _URLString = [URLString copy];
}

- (void)setHTMLContentString:(NSString *)HTMLContentString{
    _loadType=CDWebViewLoadTypeHTMLContentString;
    _HTMLContentString=[HTMLContentString copy];
}

- (void)reload{
    [self.wkWebView reload];
}

#pragma mark - override
- (void)scy_backOffAction {
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    }else{
        [super cd_backOffAction];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    [self updateNavigationItems];
    if ([navigationAction.request.URL.scheme hasPrefix:@"tmast"]) {
        [CDAutoHideMessageHUD showMessage:@"不支持的网路协议"];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    self.progressView.hidden = NO;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    self.title = self.wkWebView.title;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
}

//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//}

#pragma mark - WKUIDelegate
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
}

-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
}

-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        if(self.wkWebView.estimatedProgress >= 1.0f) {
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

#pragma mark - private
- (void)loadWebView{
    switch (self.loadType) {
        case CDWebViewLoadTypeURLString:{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            [self.wkWebView loadRequest:request];
        }
            break;
        case CDWebViewLoadTypeHTMLContentString:{
            [self.wkWebView loadHTMLString:self.HTMLContentString baseURL:[[NSBundle mainBundle] bundleURL]];
        }
            break;
        default:
            break;
    }
}

- (void)backToOriginalViewController{
    [super cd_backOffAction];
}

-(void)updateNavigationItems{
    UIBarButtonItem *leftItem = [UIBarButtonItem cd_ItemWidth:20 imageName:@"navigation_backOff" target:self action:@selector(scy_backOffAction)];
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *leftItemClose = [UIBarButtonItem cd_ItemWidth:30 imageName:@"navigation_backOff" target:self action:@selector(backToOriginalViewController)];
        self.navigationItem.leftBarButtonItems = @[leftItem,leftItemClose];
    }else{
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

@end
