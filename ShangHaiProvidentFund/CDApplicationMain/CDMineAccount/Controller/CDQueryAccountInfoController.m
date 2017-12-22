//
//  CDQueryAccountInfoController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDQueryAccountInfoController.h"
#import "CDQueryAccountInfoCell.h"
#import "CDConvenientToolsItem.h"
#import "CDQueryAccountInfoModel.h"
#import "CDAccountInfoItem.h"
//#import "CDAccountBasicInfoCell.h"
#import "CDAccountDetailController.h"
#import "CDUserManagerController.h"
#import "CDLoginViewController.h"
#import "CDNavigationController.h"
#import "CDLoginModel.h"
#import "UIBarButtonItem+CDCategory.h"
#import "CDAboutUsController.h"
#import "CDLoanInfoViewController.h"
#import "CDRepaymentInfoController.h"
#import "UIViewController+CDVCAdditions.h"
#import "CDQueryAccountHeaderView.h"
#import "CDButtonTableFooterView.h"
#import "CDChangePasswordController.h"
#import "CDForgotPasswordResetController.h"
#import "CDBaseWKWebViewController.h"

static const CGFloat headerOriginalHeight=180;

@interface CDQueryAccountInfoController ()<CDLoginViewControllerDelegate>

@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) CDQueryAccountHeaderView *headerView;
@property (nonatomic, strong) CDQueryAccountInfoModel *queryAccountInfoModel;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;

@end

@implementation CDQueryAccountInfoController

- (instancetype)init{
    self =[super init];
    if (self) {
        self.tableViewStyle=UITableViewStyleGrouped;
        self.showDragView=NO;
        self.hidesNavigationBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.height+=20;
    self.tableView.tableHeaderView=self.headerView;
    self.tableView.tableFooterView=self.footerView;
    [self.tableView insertSubview:self.zoomImageView atIndex:0];
    [self p_showRightBarBtn];
    [self p_reloadHeaderView];
}

- (CDQueryAccountInfoModel *)queryAccountInfoModel{
    if (_queryAccountInfoModel==nil) {
        _queryAccountInfoModel=[[CDQueryAccountInfoModel alloc]init];
    }
    return _queryAccountInfoModel;
}

- (UIImageView *)zoomImageView{
    if (_zoomImageView==nil) {
        _zoomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 180)];
        _zoomImageView.image = [UIImage imageNamed:@"account_manage_cellBG"];
    }
    return _zoomImageView;
}

- (CDQueryAccountHeaderView *)headerView{
    if (_headerView==nil) {
        _headerView=[[CDQueryAccountHeaderView alloc]init];
        _headerView.frame=CGRectMake(0, 0, self.view.width, headerOriginalHeight);
        __weak typeof(self) weakSelf=self;
        _headerView.viewTappedBlock=^(){
            if (!CDIsUserLogined()) {
                [weakSelf p_presentLoginViewController];
            }
        };
    }
    return _headerView;
}

- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:(CDIsUserLogined() ? @"退出登录" : @"登录")];
        [_footerView setupBtnBackgroundColor:(CDIsUserLogined() ? ColorFromHexRGB(0xfe6565) : ColorFromHexRGB(0x36c362))];
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            [weakSelf footerViewButtonClicked];
        };
    }
    return _footerView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat height=headerOriginalHeight-(offsetY);
    if (height>headerOriginalHeight) {
        CGRect frame = self.zoomImageView.frame;
        frame.origin.y = offsetY;
        frame.size.height = height;
        self.zoomImageView.frame = frame;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.queryAccountInfoModel.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=[self.queryAccountInfoModel.arrData cd_safeObjectAtIndex:section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr=[self.queryAccountInfoModel.arrData cd_safeObjectAtIndex:indexPath.section];
    CDConvenientToolsItem *item=[arr cd_safeObjectAtIndex:indexPath.row];
    static NSString *cellidentifier = @"cellidentifier";
    CDQueryAccountInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDQueryAccountInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
    }
    [cell setupCellItem:(CDConvenientToolsItem *)item];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            if (!CDIsUserLogined()) {
                [self p_presentLoginViewController];
                return;
            }
            [self p_pushToAccountDetailController];
        }
            break;
        case 1:{
            if (!CDIsUserLogined()) {
                [self p_presentLoginViewController];
                return;
            }
            switch (indexPath.row) {
                case 0:
                    [self p_pushToLoanDetailController];
                    break;
                case 1:
                    [self p_pushToRepaymentInfoController];
                    break;
                default:
                    break;
            }
        }break;
//        case 2:{//贷款进度
//            [CDAutoHideMessageHUD showMessage:@"暂时无法查询"];
//        }break;
        case 2:{
            switch (indexPath.row) {
                case 0://修改密码需要登录
                {
                    if (!CDIsUserLogined()) {
                        [self p_presentLoginViewController];
                        return;
                    }
                    [self p_pushToChangePWDController];
                }
                    break;
                case 1://遗忘密码不需要登录
                {
                    [self p_pushToForgotPasswordResetController];
                }
                    break;
                case 2://手机号取回用户名和密码,不需要登录
                {
                    NSString *strurl=@"http://m.shgjj.com/gjjwx/jsp/get_pass.jsp";
                    
                    NSArray *arrJSCode=@[@"document.querySelector('.ctitle').remove();",@"document.querySelector('.headblank').remove();",@"document.querySelector('.nav').remove();"];
                    [self p_pushToWKWebViewControllerWithTitle:@"手机取回用户名和密码" URLString:strurl jsCode:arrJSCode];
                }
                    break;
                case 3://个人公积金账号查询，不需要登录
                {
                    NSString *str=@"var element=document.getElementsByClassName('notes')[1];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
                    NSString *strRemoveTitle=@"document.querySelector('.text-center').remove();";
                    [self p_pushToWKWebViewControllerWithTitle:@"个人公积金账号查询" URLString:@"http://m.shgjj.com/verifier/verifier/index" jsCode:@[str,strRemoveTitle]];
                }
                    break;
                    
                default:
                    break;
            }
        }break;
            
        default:
            break;
    }
    
}

#pragma mark - CDLoginViewControllerDelegate
- (void)userDidLogin{
    [self refreshHeaderAndFooterView];
}

- (void)userCanceledLogin{
    
}

#pragma mark - private
- (void)p_showRightBarBtn{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(self.view.width-45, 20, 30, 44);
    [barButton setImage:[UIImage imageNamed:@"mine_account_settingicon"] forState:(UIControlStateNormal)];
    [barButton addTarget:self action:@selector(p_rightBarBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:barButton];
}

- (void)p_rightBarBtnClick{
    [self p_pushToAboutUsController];
}

- (void)p_presentLoginViewController{
    CDLoginViewController *controller=[[CDLoginViewController alloc]init];
    controller.delegate=self;
    CDNavigationController *nav=[[CDNavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)p_pushToAboutUsController{
    CDAboutUsController *fourVC = [[CDAboutUsController alloc]init];
    [self.navigationController pushViewController:fourVC animated:YES];
}

- (void)p_pushToAccountDetailController{
    CDAccountDetailController *controller=[[CDAccountDetailController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)p_pushToLoanDetailController{
    NSString *file=[CDAPPURLConfigure filePathforLoginInfo];
    CDLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (model.account.count==0 || model.dynamicdetail.count==0) {
        [CDAutoHideMessageHUD showMessage:@"没有查询到贷款信息"];
        return;
    }
    CDLoanInfoViewController *controller=[[CDLoanInfoViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)p_pushToRepaymentInfoController{
    CDRepaymentInfoController *controller= [[CDRepaymentInfoController alloc]init];
    NSString *file=[CDAPPURLConfigure filePathforLoginInfo];
    CDLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    CDAccountInfoItem *accountInfoItem=[model.basic firstObject];
    controller.accountNum=accountInfoItem.pri_account;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)p_pushToWKWebViewControllerWithTitle:(NSString *)title URLString:(NSString *)urlstr jsCode:(NSArray<NSString *> *)arrjsCode{
    CDBaseWKWebViewController *webViewController=[[CDBaseWKWebViewController alloc]init];
    webViewController.title=title;
    webViewController.URLString=urlstr;
    if (arrjsCode && arrjsCode.count!=0) {
        NSMutableArray *arrScript=[NSMutableArray array];
        for (NSString *jsCode in arrjsCode) {
            if (jsCode.length != 0) {
                WKUserScript *script= [[WKUserScript alloc]initWithSource:jsCode injectionTime:(WKUserScriptInjectionTimeAtDocumentEnd) forMainFrameOnly:NO];
                [arrScript addObject:script];
            }
        }
        webViewController.arrWKUserScript=arrScript;
    }
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)footerViewButtonClicked{
    if (CDIsUserLogined()) {
        CDSaveUserLogined(NO);
        [self refreshHeaderAndFooterView];
    }else{
        [self p_presentLoginViewController];
    }
}

- (void)p_reloadHeaderView{
    if (CDIsUserLogined()) {
        NSString *file=[CDAPPURLConfigure filePathforLoginInfo];
        if (file) {
            CDLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
            CDAccountInfoItem *accountInfoItem=[model.basic firstObject];
            [self.headerView setupViewItem:accountInfoItem isLogined:CDIsUserLogined()];
        }
    }else{
        [self.headerView setupViewItem:nil isLogined:CDIsUserLogined()];
    }
}

- (void)refreshFooterView{
    [self.footerView setupBtnTitle:(CDIsUserLogined() ? @"退出登录" : @"登录")];
    [self.footerView setupBtnBackgroundColor:(CDIsUserLogined() ? ColorFromHexRGB(0xfe6565) : ColorFromHexRGB(0x36c362))];
}

- (void)refreshHeaderAndFooterView{
    [self p_reloadHeaderView];
    [self refreshFooterView];
}

- (void)p_pushToChangePWDController{
    CDChangePasswordController *controller=[[CDChangePasswordController alloc]init];
    controller.userName=CDUserNickName();
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)p_pushToForgotPasswordResetController{
    CDForgotPasswordResetController *controller=[[CDForgotPasswordResetController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
