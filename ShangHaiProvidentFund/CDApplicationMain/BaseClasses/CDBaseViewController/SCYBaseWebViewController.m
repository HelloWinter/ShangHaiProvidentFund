//
//  SCYBaseWebViewController.m
//  ProvidentFund
//
//  Created by cdd on 16/3/24.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYBaseWebViewController.h"
#import "UIBarButtonItem+CDCategory.h"

#define kLeftAndRightMargin 15

@interface SCYBaseWebViewController ()<UIWebViewDelegate>{
    NSTimer *_fakeProgressTimer;
}

/**
 *  进度条颜色,默认系统TintColor
 */
@property (nonatomic, strong) UIColor *progressViewTintColor;

/**
 *  是否在导航条显示URL,默认隐藏(NO)
 */
@property (nonatomic, assign) BOOL showURLInNavigationBar;

/**
 *  是否在导航条显示网页的PageTitle,默认隐藏(NO)
 */
@property (nonatomic, assign) BOOL showPageTitleInNavigationBar;

/**
 *  是否在顶部显示域名Host
 */
@property (nonatomic, assign) BOOL showHostURL;

/**
 *  UIWebView的url
 */
@property (nonatomic, strong) NSURL *url;

/**
 *  保存前一个视图控制器navbar的状态
 */
@property (nonatomic, assign) BOOL previousNavigationBarHiddenState;

@property (nonatomic, strong) NSURL *webViewCurrentURL;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UILabel *lblinkURL;

@end

@implementation SCYBaseWebViewController
@synthesize webView=_webView;

+ (SCYBaseWebViewController *)webViewControllerWithURL:(NSURL *)url{
    SCYBaseWebViewController *webViewVC=[[self alloc]init];
    webViewVC.url=url;
    return webViewVC;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.showURLInNavigationBar = NO;
        self.showPageTitleInNavigationBar = NO;
        self.showHostURL=NO;
        self.hidesBottomBarWhenPushed=YES;
        self.progressViewTintColor=ColorFromHexRGB(0x37cb74);
    }
    return self;
}

- (void)viewDidLoad{
    self.previousNavigationBarHiddenState = self.navigationController.navigationBarHidden;
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    [self.view addSubview:self.webView];
    if (self.showHostURL) {
        [self.webView insertSubview:self.lblinkURL belowSubview:self.webView.scrollView];
    }
    
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
    [self.webView setDelegate:nil];
    [self.progressView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:self.previousNavigationBarHiddenState animated:animated];
    [self invalidateTimer];
}

- (UIWebView *)webView{
    if (_webView==nil) {
        _webView = [[UIWebView alloc] init];
        [_webView setFrame:self.view.bounds];
        [_webView setDelegate:self];
        [_webView setMultipleTouchEnabled:YES];
        [_webView setScalesPageToFit:YES];
        [_webView.scrollView setAlwaysBounceVertical:YES];
        _webView.scrollView.backgroundColor=[UIColor clearColor];
    }
    return _webView;
}

- (UILabel *)lblinkURL{
    if (_lblinkURL == nil) {
        _lblinkURL=[[UILabel alloc]initWithFrame:CGRectMake(kLeftAndRightMargin, 69, self.webView.scrollView.width-kLeftAndRightMargin*2, 20)];
        _lblinkURL.textColor=[UIColor whiteColor];
        _lblinkURL.font=[UIFont systemFontOfSize:13];
        _lblinkURL.textAlignment=NSTextAlignmentCenter;
    }
    return _lblinkURL;
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
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    [self.webView loadHTMLString:HTMLString baseURL:nil];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.webViewCurrentURL = request.URL;
    if(![self isJumpToExternalAppWithURL:request.URL]) {
        return YES;
    }
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self updateNavTitle];
    [self fakeProgressViewStartLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView == self.webView) {
        if (self.showHostURL && [self.webView.request.URL host]!=nil && [self.webView.request.URL host].length!=0) {
            self.lblinkURL.text=[NSString stringWithFormat:@"网页由 %@ 提供",[self.webView.request.URL host]];
        }
        [self updateNavTitle];
        [self updateNavgationLeftBtn];
        [self fakeProgressBarStopLoading];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if(webView == self.webView) {
        [self updateNavTitle];
        [self updateNavgationLeftBtn];
        [self fakeProgressBarStopLoading];
        [CDAutoHideMessageHUD showMessage:@"出错了,请稍后再试"];
    }
}

- (void)scy_backOffAction {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [super cd_backOffAction];
    }
}

#pragma mark - Events
- (void)refresh{
    [self.webView stopLoading];
    [self.webView reload];
}

/**
 *  进度条开始加载
 */
- (void)fakeProgressViewStartLoading {
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    
    if(!_fakeProgressTimer) {
        _fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire) userInfo:nil repeats:YES];
    }
}

/**
 *  进度条停止
 */
- (void)fakeProgressBarStopLoading {
    [self invalidateTimer];
    [self.progressView setProgress:1.0f animated:YES];
    [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.progressView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [self.progressView setProgress:0.0f animated:NO];
    }];
}

- (void)invalidateTimer{
    if(_fakeProgressTimer.isValid) {
        [_fakeProgressTimer invalidate];
        _fakeProgressTimer=nil;
    }
}

/**
 *  更新进度条状态
 */
- (void)fakeProgressTimerDidFire{
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if([self.webView isLoading]) {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if(self.progressView.progress < 0.95) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

/**
 *  更新title
 */
- (void)updateNavTitle{
    if(self.webView.isLoading) {
        if(self.showURLInNavigationBar) {
            NSString *URLString = [self.webViewCurrentURL absoluteString];
            URLString = [URLString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
            URLString = [URLString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
            URLString = [URLString substringToIndex:[URLString length]-1];
            self.navigationItem.title = URLString;
        }
    }else{
        if(self.showPageTitleInNavigationBar) {
            self.navigationItem.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        }
    }
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

/**
 *  更新导航栏左侧按钮
 */
- (void)updateNavgationLeftBtn{
    if (self.webView.canGoBack) {
        UIBarButtonItem *leftItem = [UIBarButtonItem cd_barButtonWidth:20 Title:nil ImageName:@"navigation_backOff" Target:self Action:@selector(scy_backOffAction)];
        UIBarButtonItem *leftItemClose = [UIBarButtonItem cd_barButtonWidth:40 Title:@"关闭" ImageName:nil Target:self Action:@selector(backToOriginalViewController)];
        self.navigationItem.leftBarButtonItems = @[leftItem,leftItemClose];
    }else{
        UIBarButtonItem *leftItem = [UIBarButtonItem cd_barButtonWidth:20 Title:nil ImageName:@"navigation_backOff" Target:self Action:@selector(scy_backOffAction)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)backToOriginalViewController{
    [super cd_backOffAction];
}

@end
