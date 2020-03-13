//
//  CDBaseWKWebViewController.m
//  CDAppDemo
//
//  Created by cdd on 16/9/24.
//  Copyright (c) 2016年 Cheng. All rights reserved.
//

#import "CDBaseWKWebViewController.h"
#import "UIBarButtonItem+CDCategory.h"
#import "SCYActivityIndicatorView.h"

static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface CDBaseWKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate>

@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation CDBaseWKWebViewController
@synthesize wkWebView=_wkWebView;

- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    //    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@""];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    if ([SCYActivityIndicatorView isAnimating]) {
        [SCYActivityIndicatorView stopAnimating];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    [self.view addSubview:self.wkWebView];
    if (self.showProgressView) {
        [self.view addSubview:self.progressView];
    }
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

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        // 允许在线播放
        configuration.allowsInlineMediaPlayback = YES;
        // web内容处理池
        configuration.processPool = [[WKProcessPool alloc] init];
        // 是否支持记忆读取
        configuration.suppressesIncrementalRendering = YES;
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController *userContentController = [[WKUserContentController alloc]init];
//        NSString *cookie=[NSString stringWithFormat:@"document.cookie='APPID=%@';document.cookie='SOURCE=App';document.cookie='TOKEN=%@';document.cookie='VERSION=%@'",];
//        WKUserScript *cookieScript=[[WKUserScript alloc] initWithSource:cookie injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
//        [userContentController addUserScript:cookieScript];
        
        NSString *document=@"metaEl=window.document.createElement('meta');metaEl.setAttribute('name','viewport');window.document.head.appendChild(metaEl);metaEl.setAttribute('content','width=device-width,user-scalable=no,initial-scale=1,maximum-scale=1,minimum-scale=1');";
        WKUserScript *documentScript=[[WKUserScript alloc] initWithSource:document injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [userContentController addUserScript:documentScript];
        
        for (WKUserScript *script in self.arrWKUserScript) {
            [userContentController addUserScript:script];
        }
        
        //移除节点
        //NSString *removeTab=@"var element=document.getElementsByClassName(\"nav\")[0];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
//        NSString *removeTab=@"document.querySelector('.nav').remove()";
        
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
//        [userContentController addScriptMessageHandler:self name:@""];
        
        // 允许用户更改网页的设置
        configuration.userContentController = userContentController;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) configuration:configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //KVO 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.scrollView.showsVerticalScrollIndicator=NO;
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

- (void)setLocalFilePath:(NSString *)localFilePath{
    _loadType=CDWebViewLoadTypeLocalFilePath;
    _localFilePath=[localFilePath copy];
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
    if([self isJumpToExternalAppWithURL:navigationAction.request.URL] && [[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        [self updateNavigationItems];
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if (self.showProgressView) {
        self.progressView.hidden = NO;
    }else{
        [SCYActivityIndicatorView startAnimating];
    }
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
    if (self.title.length==0 && self.wkWebView.title.length!=0) {
        self.title = self.wkWebView.title;
    }
    [self updateNavigationItems];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (!self.showProgressView) {
        [SCYActivityIndicatorView stopAnimating];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (!self.showProgressView) {
        [SCYActivityIndicatorView stopAnimating];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text=defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
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
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
            [self.wkWebView loadRequest:request];
        }
            break;
        case CDWebViewLoadTypeHTMLContentString:{
            [self.wkWebView loadHTMLString:self.HTMLContentString baseURL:[[NSBundle mainBundle] bundleURL]];
        }
            break;
        case CDWebViewLoadTypeLocalFilePath:{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.localFilePath] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
            [self.wkWebView loadRequest:request];
        }break;
        default:
            break;
    }
}

- (void)backToOriginalViewController{
    [super cd_backOffAction];
}

- (void)updateNavigationItems{
    UIBarButtonItem *leftItem = [UIBarButtonItem cd_ItemWidth:20 imageName:@"navigation_blue_backOff" target:self action:@selector(scy_backOffAction)];
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *leftItemClose = [UIBarButtonItem cd_ItemWidth:20 imageName:@"navgation_blue_close" target:self action:@selector(backToOriginalViewController)];
        self.navigationItem.leftBarButtonItems = @[leftItem,leftItemClose];
    }else{
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

/**
 *  url是否是跳转APP类型的
 */
- (BOOL)isJumpToExternalAppWithURL:(NSURL *)URL{
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
    return ![validSchemes containsObject:URL.scheme];
}

@end
