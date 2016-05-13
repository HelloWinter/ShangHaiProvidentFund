//
//  CDLoginViewController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoginViewController.h"
#import "CDButtonTableFooterView.h"
#import "CDOpinionsSuggestionsItem.h"
#import "CDLoginConfigureModel.h"
#import "CDOpinionsSuggestionsFieldCell.h"
#import "CDBottomButtonView.h"
#import "CDLoginService.h"
#import "UITextField+cellIndexPath.h"
#import "NSString+CDEncryption.h"
#import "CDLoginModel.h"
#import "CDBaseWKWebViewController.h"
#import "CDRegistViewController.h"

@interface CDLoginViewController ()

@property (nonatomic, strong) CDButtonTableFooterView *footerView;
@property (nonatomic, strong) CDLoginConfigureModel *loginConfigureModel;
@property (nonatomic, strong) CDBottomButtonView *bottomButtonView;
@property (nonatomic, strong) CDLoginService *loginService;

@end

@implementation CDLoginViewController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"登录";
        self.showDragView=NO;
        self.hideKeyboradWhenTouch=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(controlTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self cd_showBackButton];
    self.tableView.height+=49;
    self.tableView.tableFooterView=self.footerView;
    [self.view addSubview:self.bottomButtonView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    if (self.loginService.isLoading) {
        [self.loginService cancel];
    }
}

- (CDLoginConfigureModel *)loginConfigureModel{
    if (_loginConfigureModel==nil) {
        _loginConfigureModel=[[CDLoginConfigureModel alloc]init];
    }
    return _loginConfigureModel;
}

- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:@"登录"];
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            [weakSelf login];
        };
    }
    return _footerView;
}

- (CDLoginService *)loginService{
    if (_loginService==nil) {
        _loginService=[[CDLoginService alloc]initWithDelegate:self];
    }
    return _loginService;
}

- (CDBottomButtonView *)bottomButtonView{
    if(_bottomButtonView == nil){
        _bottomButtonView = [[CDBottomButtonView alloc]init];
        _bottomButtonView.frame=CGRectMake(0, 0, 160, 20);
        _bottomButtonView.center=CGPointMake(self.view.width*0.5, self.tableView.bottom-30);
        __weak typeof(self) weakSelf=self;
        _bottomButtonView.forgotPSWBlock=^(){
            [weakSelf pushToWKWebViewControllerWithTitle:@"遗忘密码" javaScriptCode:nil URLString:CDWebURLWithAPI(@"/static/sms/forget-pass.html")];
        };
        _bottomButtonView.registBlock=^(){
            [weakSelf pushToRegistViewController];
        };
    }
    return _bottomButtonView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.loginConfigureModel.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDOpinionsSuggestionsFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDOpinionsSuggestionsFieldCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
    }
    CDOpinionsSuggestionsItem *item=[self.loginConfigureModel.arrData cd_safeObjectAtIndex:indexPath.row];
    [cell setupItem:item indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)requestDidFinished:(CDJSONBaseNetworkService *)service{
    [super requestDidFinished:service];
    if ([self.loginService.loginModel.type isEqualToString:@"S"]) {
        [self finishLogin];
    }
}

- (void)request:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super request:service didFailLoadWithError:error];
}

#pragma mark - Notification
- (void)controlTextDidChange:(NSNotification *)noti{
    UITextField *textField = noti.object;
    CDOpinionsSuggestionsItem *cellItem = [self.loginConfigureModel.arrData cd_safeObjectAtIndex:textField.indexPath.row];
    cellItem.value=textField.text;
}

#pragma mark - override
- (void)cd_backOffAction{
    [self cancelLogin];
}

#pragma mark - Events
- (void)login{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    for (CDOpinionsSuggestionsItem *item in self.loginConfigureModel.arrData) {
        if ([item.paramsubmit isEqualToString:@"passwd"]) {
            item.value=[item.value cd_md5HexDigest];
        }
        [dict cd_safeSetObject:item.value forKey:item.paramsubmit];
    }
    [dict cd_safeSetObject:@"ios" forKey:@"source"];
    [dict cd_safeSetObject:CDAppVersion forKey:@"version"];
    [dict cd_safeSetObject:CDDeviceModel forKey:@"model"];
    [dict cd_safeSetObject:@"apple" forKey:@"manufacturer"];
    [self.loginService loadWithParams:dict showIndicator:YES];
}

- (void)finishLogin {
    [self dismissViewControllerAnimated:YES completion:^{
        if (_delegate && [_delegate respondsToSelector:@selector(userDidLogin)]) {
            [_delegate userDidLogin];
        }
    }];
}

- (void)cancelLogin{
    [self dismissViewControllerAnimated:YES completion:^{
        if (_delegate && [_delegate respondsToSelector:@selector(userCanceledLogin)]) {
            [_delegate userCanceledLogin];
        }
    }];
}

- (void)pushToWKWebViewControllerWithTitle:(NSString *)title javaScriptCode:(NSString *)jsCode URLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=title;
    webViewController.javaScriptCode=jsCode;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)pushToRegistViewController{
    CDRegistViewController *controller=[[CDRegistViewController alloc]initWithTableViewStyle:(UITableViewStyleGrouped)];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
