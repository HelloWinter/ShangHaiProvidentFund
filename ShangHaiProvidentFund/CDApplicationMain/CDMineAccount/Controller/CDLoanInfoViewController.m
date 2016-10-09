//
//  CDLoanInfoViewController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/10.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoanInfoViewController.h"
#import "CDProvidentFundDetailHeaderView.h"
#import "CDHeaderTitleView.h"
#import "CDLoginModel.h"
#import "CDPayAccountItem.h"
#import "CDDynamicdetailItem.h"

static const CGFloat kAccountInfoHeight = 135;
static const CGFloat kHeaderTitleHeight = 28;

@interface CDLoanInfoViewController ()

@property (nonatomic, strong) CDProvidentFundDetailHeaderView *detailHeaderView;
@property (nonatomic, strong) CDHeaderTitleView *headerTitleView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) CDLoginModel *loginModel;

@end

@implementation CDLoanInfoViewController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
        self.title=@"贷款信息";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.detailHeaderView];
    self.tableView.top=self.detailHeaderView.bottom;
    self.tableView.height-=self.detailHeaderView.height+64;
    self.tableView.tableHeaderView=self.headerTitleView;
    [self refreshArrData];
    [self refreshHeaderView];
}

- (CDLoginModel *)loginModel{
    if (_loginModel==nil) {
        NSString *file=[CDAPPURLConfigure filePathforLoginInfo];
        _loginModel=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    }
    return _loginModel;
}

- (NSMutableArray *)arrData{
    if (_arrData==nil) {
        _arrData=[[NSMutableArray alloc]init];
    }
    return _arrData;
}

- (CDProvidentFundDetailHeaderView *)detailHeaderView{
    if (_detailHeaderView==nil) {
        _detailHeaderView = [[CDProvidentFundDetailHeaderView alloc]init];
        _detailHeaderView.frame=CGRectMake(0, 0, self.view.width, kAccountInfoHeight);
    }
    return _detailHeaderView;
}

- (CDHeaderTitleView *)headerTitleView{
    if (_headerTitleView==nil) {
        _headerTitleView = [[CDHeaderTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderTitleHeight)];
        _headerTitleView.cellLayoutType=CDCellLayoutTypeLoanDetail;
        [_headerTitleView setupWithFirstDesc:@"业务描述" secondDesc:@"本金" thirdDesc:@"利息"];
    }
    return _headerTitleView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDProvidentFundDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDProvidentFundDetailCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
        cell.cellLayoutType=CDCellLayoutTypeLoanDetail;
    }
    [cell setupLoanDetailItem:[self.arrData cd_safeObjectAtIndex:indexPath.section]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CDDynamicdetailItem *item=[self.arrData cd_safeObjectAtIndex:section];
    return [NSString stringWithFormat:@"    %@",item.happendate ? : @"--"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kHeaderTitleHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Events
- (void)refreshArrData{
    [self.arrData removeAllObjects];
    [self.arrData addObjectsFromArray:self.loginModel.dynamicdetail];
    if (self.arrData.count==0) {
        [self.tableView showWatermark:@"no_detail" target:nil action:nil];
    }else{
        [self.tableView hideWatermark];
    }
    [self.tableView reloadData];
}

- (void)refreshHeaderView{
    CDPayAccountItem *item=[self.loginModel.account firstObject];
    [self.detailHeaderView setupLoanInfo:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
