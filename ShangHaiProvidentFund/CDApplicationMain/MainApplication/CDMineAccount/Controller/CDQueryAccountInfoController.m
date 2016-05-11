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
#import "CDButtonTableFooterView.h"
#import "CDLoginViewController.h"
#import "CDNavigationController.h"

@interface CDQueryAccountInfoController ()<CDLoginViewControllerDelegate>

@property (nonatomic, strong) CDQueryAccountInfoModel *queryAccountInfoModel;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;

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
    [self refreshTableFooterView];
}

- (CDQueryAccountInfoModel *)queryAccountInfoModel{
    if (_queryAccountInfoModel==nil) {
        _queryAccountInfoModel=[[CDQueryAccountInfoModel alloc]init];
    }
    return _queryAccountInfoModel;
}

- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:@"登录"];
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            [weakSelf presentLoginViewController];
        };
    }
    return _footerView;
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
    
}

#pragma mark - CDLoginViewControllerDelegate
- (void)userDidLogin{
    
}

- (void)userCanceledLogin{
    
}

#pragma mark - Events{
- (void)refreshTableFooterView{
    self.tableView.tableFooterView=CDIsUserLogined() ? nil : self.footerView;
}

- (void)presentLoginViewController{
    CDLoginViewController *controller=[[CDLoginViewController alloc]initWithTableViewStyle:(UITableViewStyleGrouped)];
    controller.delegate=self;
    CDNavigationController *nav=[[CDNavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
