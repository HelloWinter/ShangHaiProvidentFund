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

static const CGFloat headerOriginalHeight=180;

@interface CDQueryAccountInfoController ()<CDLoginViewControllerDelegate>

@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) CDQueryAccountHeaderView *headerView;
@property (nonatomic, strong) CDQueryAccountInfoModel *queryAccountInfoModel;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLoginStateChanged:) name:kUserLoginStateChangedNotification object:nil];
    self.tableView.height+=20;
    self.tableView.tableHeaderView=self.headerView;
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
    if (!CDIsUserLogined() && indexPath.section!=3) {
        [self p_presentLoginViewController];
        return;
    }
    switch (indexPath.section) {
        case 0:
            [self p_pushToAccountDetailController];
            break;
        case 1:{
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
        case 2:{
            [CDAutoHideMessageHUD showMessage:@"暂时无法查询"];
        }break;
        case 3:{
            [self p_pushToAboutUsController];
        }break;
            
        default:
            break;
    }
    
}

#pragma mark - CDLoginViewControllerDelegate
- (void)userDidLogin{
    [self p_reloadHeaderView];
}

- (void)userCanceledLogin{
    
}

#pragma mark - NSNotification
- (void)userLoginStateChanged:(NSNotification *)noti{
    [self p_reloadHeaderView];
}

#pragma mark - private
- (void)p_showRightBarBtn{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(self.view.width-45, 20, 30, 44);
    [barButton setImage:[UIImage imageNamed:@"tab_settingicon"] forState:(UIControlStateNormal)];
    [barButton addTarget:self action:@selector(p_rightBarBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:barButton];
}

- (void)p_rightBarBtnClick{
    [self p_pushToUserManagerController];
}

- (void)p_presentLoginViewController{
    CDLoginViewController *controller=[[CDLoginViewController alloc]init];
    controller.delegate=self;
    CDNavigationController *nav=[[CDNavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
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
        [CDAutoHideMessageHUD showMessage:@"您没有贷款信息"];
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

- (void)p_pushToUserManagerController{
    CDUserManagerController *controller=[[CDUserManagerController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
