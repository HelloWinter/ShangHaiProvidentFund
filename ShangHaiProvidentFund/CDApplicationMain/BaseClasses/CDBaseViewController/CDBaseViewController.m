//
//  CDBaseViewController.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "CDBaseViewController.h"
#import "UIViewController+CDVCAdditions.h"
#import "UIImage+CDImageAdditions.h"
#import "CDNavigationController.h"
#import "UIBarButtonItem+CDCategory.h"

@interface CDBaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIColor *navBarCurrentColor;

@end

@implementation CDBaseViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupInit];
}

- (instancetype)init{
    self =[super init];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (void)setupInit{
    self.statusBarHidden=NO;
    self.backImageName = @"navigation_backOff";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=colorForHex(@"#f5f5f5");
    [self cd_addTapGestureRecognizerIfNeeded];
    [self setupBackBarButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //使用自定义返回按钮时添加返回手势
    if (self.navigationController && [[self.navigationController viewControllers] count] > 1) {
        //自定义leftBarButtonItem返回手势失效的处理办法
        self.navigationController.interactivePopGestureRecognizer.enabled=YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;//(id UIGestureRecognizerDelegate)
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.delegate=nil;
}

- (BOOL)prefersStatusBarHidden{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];已经不起作用了
    return self.statusBarHidden;
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)serviceDidStart:(CDJSONBaseNetworkService *)service{
    
}

- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    
}

- (void)serviceDidCancel:(CDJSONBaseNetworkService *)service{
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController isKindOfClass:[CDNavigationController class]]) {
        CDNavigationController *cdNavigationController = (CDNavigationController *)navigationController;
        [cdNavigationController setNavigationBarHidden:viewController.hidesNavigationBarWhenPushed animated:animated];
    }
    if ([navigationController isKindOfClass:[CDNavigationController class]]) {
        [navigationController setNavigationBarHidden:viewController.hidesNavigationBarWhenPushed animated:animated];
        if (viewController.navigationBarColor && !CGColorEqualToColor(self.navBarCurrentColor.CGColor, viewController.navigationBarColor.CGColor)) {
            self.navBarCurrentColor = viewController.navigationBarColor;
            [navigationController.navigationBar setBackgroundImage:[UIImage cd_imageWithColor:viewController.navigationBarColor] forBarMetrics:UIBarMetricsDefault];
        }
    }
}

#pragma mark - public
//如果自定义返回按钮
- (void)cd_showBackButton{
    UIBarButtonItem *leftItem = [UIBarButtonItem cd_ItemWidth:20 imageName:@"navigation_backOff" target:self action:@selector(cd_backOffAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)cd_backOffAction {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        return;
    }
}

#pragma mark - private
/**
 *  返回按钮
 */
- (void)setupBackBarButton{
    if (self.navigationController && [[self.navigationController viewControllers] count] > 1) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self cd_showBackButton];
        }
    }
}

- (void)cd_addTapGestureRecognizerIfNeeded {
    if (_hideKeyboradWhenTouch) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cd_hideKeyboard)];
        tapGesture.numberOfTapsRequired=1;
        tapGesture.cancelsTouchesInView=NO;
        [self.view addGestureRecognizer:tapGesture];
    }
}

- (void)cd_hideKeyboard{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
