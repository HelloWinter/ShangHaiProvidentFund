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
- (void)requestDidStart:(CDJSONBaseNetworkService *)service{
    
}

- (void)requestDidFinished:(CDJSONBaseNetworkService *)service{
    
}

- (void)request:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    
}

- (void)requestDidCancel:(CDJSONBaseNetworkService *)service{
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController isKindOfClass:[CDNavigationController class]]) {
        CDNavigationController *cdNavigationController = (CDNavigationController *)navigationController;
        [cdNavigationController setNavigationBarHidden:viewController.hidesNavigationBarWhenPushed animated:animated];
    }
}

#pragma mark - Events
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

//如果自定义返回按钮
- (void)cd_showBackButton{
    UIBarButtonItem *leftItem = [UIBarButtonItem cd_barButtonWidth:20 Title:nil ImageName:@"navigation_backOff" Target:self Action:@selector(cd_backOffAction)];
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
