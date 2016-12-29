//
//  CDRepaymentInfoController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/10.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDRepaymentInfoController.h"
#import "CDRepayInfoService.h"
#import "CDBaseTableViewCell.h"
#import "CDAboutUsItem.h"

@interface CDRepaymentInfoController ()

@property (nonatomic, strong) CDRepayInfoService *repayInfoService;

@end

@implementation CDRepaymentInfoController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"冲还贷信息";
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.repayInfoService loadWithAccountNum:self.accountNum ignoreCache:NO showIndicator:YES];
}

- (CDRepayInfoService *)repayInfoService{
    if (_repayInfoService==nil) {
        _repayInfoService=[[CDRepayInfoService alloc]initWithDelegate:self];
    }
    return _repayInfoService;
}

#pragma mark - override
- (void)startPullRefresh{
    [self.repayInfoService loadWithAccountNum:self.accountNum ignoreCache:YES showIndicator:NO];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.repayInfoService.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=[self.repayInfoService.arrData cd_safeObjectAtIndex:section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDBaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDBaseTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellidentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    }
    NSArray *arr=[self.repayInfoService.arrData cd_safeObjectAtIndex:indexPath.section];
    CDAboutUsItem *item=[arr cd_safeObjectAtIndex:indexPath.row];
    cell.textLabel.text=item.titleText;
    cell.detailTextLabel.text=item.detailText.length!=0 ? item.detailText : @"无";
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"   基本信息";
    }else if (section==1){
        return @"   参与还贷人员信息";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    [super serviceDidFinished:service];
    if (self.repayInfoService.returnCode==0) {
        [self.tableView reloadData];
    }else if (self.repayInfoService.returnCode ==1){
        [CDAutoHideMessageHUD showMessage:@"没有查询到冲还贷信息"];
//        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super service:service didFailLoadWithError:error];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
