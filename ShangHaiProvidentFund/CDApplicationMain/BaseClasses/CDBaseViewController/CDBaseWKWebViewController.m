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

@interface CDBaseWKWebViewController ()<WKNavigationDelegate,UIActionSheetDelegate>

/**
 *  进度条颜色,默认系统TintColor
 */
@property (nonatomic, strong) UIColor *progressViewTintColor;

/**
 *  是否在导航条显示URL,默认显示(YES)
 */
@property (nonatomic, assign) BOOL showURLInNavigationBar;

/**
 *  是否在导航条显示PageTitle,默认显示(YES)
 */
@property (nonatomic, assign) BOOL showPageTitleInNavigationBar;

/**
 *  UIWebView的url
 */
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) WKWebViewConfiguration *configuration;

/**
 *  保存前一个视图控制器navbar的状态
 */
@property (nonatomic, assign) BOOL previousNavigationBarHidden;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation CDBaseWKWebViewController
@synthesize webView=_webView;

#pragma mark - Dealloc
- (void)dealloc {
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

+ (instancetype)webViewWithURL:(NSURL *)url{
    return [self webViewWithURL:url Configuration:nil];
}

+ (instancetype)webViewWithURL:(NSURL *)url Configuration:(WKWebViewConfiguration *)configuration{
    CDBaseWKWebViewController *webView=[[self alloc]init];
    webView.url=url;
    webView.configuration=configuration;
    return webView;
}

- (instancetype)init{
    self =[super init];
    if (self) {
        self.showURLInNavigationBar = YES;
        self.showPageTitleInNavigationBar = YES;
        self.hidesBottomBarWhenPushed=YES;
        self.progressViewTintColor=[UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad{
    self.previousNavigationBarHidden = self.navigationController.navigationBarHidden;
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view addSubview:self.webView];
    if (self.url!=nil) {
        [self loadURL:self.url];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView stopLoading];
    [self.progressView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:self.previousNavigationBarHidden animated:animated];
}

- (WKWebView *)webView{
    if (_webView==nil) {
        if (self.configuration) {
            _webView =[[WKWebView alloc]initWithFrame:CGRectZero configuration:self.configuration];
        }else{
            _webView = [[WKWebView alloc] init];
        }
        [_webView setFrame:self.view.bounds];
        [_webView setNavigationDelegate:self];
        [_webView setMultipleTouchEnabled:YES];
        [_webView.scrollView setAlwaysBounceVertical:YES];
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

- (void)loadRequest:(NSURLRequest *)request {
    [self.webView loadRequest:request];
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    [self loadURL:[NSURL URLWithString:URLString]];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    [self.webView loadHTMLString:HTMLString baseURL:nil];
}

- (void)refresh{
    [self.webView stopLoading];
    [self.webView reload];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self updateNavTitle];
    [self updateNavgationLeftBtn];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self updateNavTitle];
    [self updateNavgationLeftBtn];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [self updateNavTitle];
    [self updateNavgationLeftBtn];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [self updateNavTitle];
    [self updateNavgationLeftBtn];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView == self.webView) {
        NSURL *URL = navigationAction.request.URL;
        if(![self isJumpToExternalAppWithURL:URL]) {
            if(!navigationAction.targetFrame) {
                [self loadURL:URL];
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
        }
//        else if([[UIApplication sharedApplication] canOpenURL:URL]) {
//            [self launchExternalAppWithURL:URL];
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
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

- (void)cd_backOffAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [super cd_backOffAction];
    }
}

/**
 *  更新title
 */
- (void)updateNavTitle{
    if(self.webView.isLoading) {
        if(self.showURLInNavigationBar) {
            NSString *URLString = [self.webView.URL absoluteString];
            URLString = [URLString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
            URLString = [URLString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
            URLString = [URLString substringToIndex:[URLString length]-1];
            self.navigationItem.title = URLString;
        }
    }else{
        if(self.showPageTitleInNavigationBar) {
            self.navigationItem.title = self.webView.title;
        }
    }
}

/**
 *  更新导航栏左侧按钮
 */
- (void)updateNavgationLeftBtn{
    if (self.webView.canGoBack) {
        UIBarButtonItem *leftItem = [UIBarButtonItem cd_barButtonWidth:20 Title:nil ImageName:@"navigation_backOff" Target:self Action:@selector(cd_backOffAction)];
        UIBarButtonItem *leftItemClose = [UIBarButtonItem cd_barButtonWidth:40 Title:@"关闭" ImageName:nil Target:self Action:@selector(backToOriginalViewController)];
        self.navigationItem.leftBarButtonItems = @[leftItem,leftItemClose];
    }else{
        UIBarButtonItem *leftItem = [UIBarButtonItem cd_barButtonWidth:20 Title:nil ImageName:@"navigation_backOff" Target:self Action:@selector(cd_backOffAction)];
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
- (BOOL)isJumpToExternalAppWithURL:(NSURL *)URL{
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
    return ![validSchemes containsObject:URL.scheme];
}

@end
