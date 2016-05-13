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
#import "CDAccountBasicInfoCell.h"

#import "CDLoginViewController.h"
#import "CDNavigationController.h"
#import "CDLoginModel.h"
#import "UIBarButtonItem+CDCategory.h"
#import "CDAboutUsController.h"

@interface CDQueryAccountInfoController ()<CDLoginViewControllerDelegate>

@property (nonatomic, strong) CDQueryAccountInfoModel *queryAccountInfoModel;


@end

@implementation CDQueryAccountInfoController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"账户查询";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLoginStateChanged:) name:kUserLoginStateChangedNotification object:nil];
    [self showRightBarBtn];
    [self reloadTableViewSection0];
}

- (CDQueryAccountInfoModel *)queryAccountInfoModel{
    if (_queryAccountInfoModel==nil) {
        _queryAccountInfoModel=[[CDQueryAccountInfoModel alloc]init];
    }
    return _queryAccountInfoModel;
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
    CDBaseItem *item=[arr cd_safeObjectAtIndex:indexPath.row];
    if ([item isKindOfClass:[CDAccountInfoItem class]]) {
        static NSString *accountInfoIdentifier = @"accountInfoIdentifier";
        CDAccountBasicInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:accountInfoIdentifier];
        if (!cell) {
            cell = [CDAccountBasicInfoCell basicInfoCell];
        }
        [cell setupCellItem:(CDAccountInfoItem *)item isLogined:CDIsUserLogined()];
        return cell;
    }else if ([item isKindOfClass:[CDConvenientToolsItem class]]){
        static NSString *cellidentifier = @"cellidentifier";
        CDQueryAccountInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!cell) {
            cell = [[CDQueryAccountInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
        }
        [cell setupCellItem:(CDConvenientToolsItem *)item];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr=[self.queryAccountInfoModel.arrData cd_safeObjectAtIndex:indexPath.section];
    CDBaseItem *item=[arr cd_safeObjectAtIndex:indexPath.row];
    if ([item isKindOfClass:[CDAccountInfoItem class]]){
        return [CDAccountBasicInfoCell tableView:tableView rowHeightForObject:item];
    }else if ([item isKindOfClass:[CDConvenientToolsItem class]]){
        return [CDQueryAccountInfoCell tableView:tableView rowHeightForObject:item];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!CDIsUserLogined()) {
        [self presentLoginViewController];
        return;
    }
}

#pragma mark - CDLoginViewControllerDelegate
- (void)userDidLogin{
    [self reloadTableViewSection0];
}

- (void)userCanceledLogin{
    
}

#pragma mark - NSNotification
- (void)userLoginStateChanged:(NSNotification *)noti{
    [self reloadTableViewSection0];
}

#pragma mark - Events{
- (void)showRightBarBtn{
//    shareScheme_questionMark //
    UIBarButtonItem *btn=[UIBarButtonItem cd_barButtonWidth:30 Title:nil ImageName:@"tab_settingicon" Target:self Action:@selector(rightBarBtnClick)];
    [self.navigationItem setRightBarButtonItem:btn];
}

- (void)rightBarBtnClick{
    [self pushToAboutUsController];
}

- (void)presentLoginViewController{
    CDLoginViewController *controller=[[CDLoginViewController alloc]initWithTableViewStyle:(UITableViewStyleGrouped)];
    controller.delegate=self;
    CDNavigationController *nav=[[CDNavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)reloadTableViewSection0{
    if (CDIsUserLogined()) {
        NSString *file=[CDAPPURLConfigure filePathforLoginInfo];
        if (file) {
            CDLoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
            CDAccountInfoItem *accountInfoItem=[model.basic firstObject];
            NSArray *arr=[self.queryAccountInfoModel.arrData cd_safeObjectAtIndex:0];
            CDBaseItem *item=[arr cd_safeObjectAtIndex:0];
            if ([item isKindOfClass:[CDAccountInfoItem class]]) {
                CDAccountInfoItem *accountItem=(CDAccountInfoItem *)item;
                accountItem.name=accountInfoItem.name;
                accountItem.surplus_def=accountInfoItem.surplus_def;
                accountItem.state=accountInfoItem.state;
            }
        }
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationFade)];
}

- (void)pushToAboutUsController{
    CDAboutUsController *fourVC = [[CDAboutUsController alloc]initWithTableViewStyle:(UITableViewStyleGrouped)];
    [self.navigationController pushViewController:fourVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
