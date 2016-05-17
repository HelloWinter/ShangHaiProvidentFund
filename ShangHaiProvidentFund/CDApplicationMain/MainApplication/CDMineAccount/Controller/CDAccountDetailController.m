//
//  CDAccountDetailController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/10.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAccountDetailController.h"
#import "CDProvidentFundDetailHeaderView.h"
#import "CDSlidePageHeaderView.h"
#import "CDHeaderTitleView.h"
#import "CDProvidentFundDetailCell.h"
#import "CDLoginModel.h"
#import "CDAccountInfoItem.h"

static const CGFloat kAccountInfoHeight = 135;
static const CGFloat kPageHeaderHeight = 38;
static const CGFloat kHeaderTitleHeight = 28;

@interface CDAccountDetailController ()<CDSlidePageHeaderViewDelegate>

@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) CDProvidentFundDetailHeaderView *detailHeaderView;
@property (nonatomic, strong) CDSlidePageHeaderView *pageHeaderView;
@property (nonatomic, strong) CDHeaderTitleView *headerTitleView;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) CDLoginModel *loginModel;

@end

@implementation CDAccountDetailController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.selectIndex=0;
        self.hidesBottomBarWhenPushed=YES;
        self.title=@"账户明细";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.detailHeaderView];
    self.tableView.top=self.detailHeaderView.bottom;
    self.tableView.height=self.tableView.height-self.detailHeaderView.height;
    [self refreshTableHeadView];
    [self refreshArrDataWithSelectIndex:self.selectIndex];
    [self refreshHeaderViewDataWithSelectIndex:self.selectIndex];
    self.tableView.tableHeaderView=self.tableHeadView;
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

- (UIView *)tableHeadView{
    if (_tableHeadView==nil) {
        _tableHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width,kPageHeaderHeight+kHeaderTitleHeight)];
    }
    return _tableHeadView;
}

- (CDHeaderTitleView *)headerTitleView{
    if (_headerTitleView==nil) {
        _headerTitleView = [[CDHeaderTitleView alloc]initWithFrame:CGRectMake(0, kPageHeaderHeight, self.view.width, kHeaderTitleHeight)];
        [_headerTitleView setupWithFirstDesc:@"日期" secondDesc:@"业务描述" thirdDesc:@"发生金额"];
    }
    return _headerTitleView;
}

- (CDSlidePageHeaderView *)pageHeaderView {
    if (!_pageHeaderView) {
        _pageHeaderView = [[CDSlidePageHeaderView alloc] initWithFrame:CGRectMake(0,0, self.view.width, kPageHeaderHeight)];
        _pageHeaderView.delegate = self;
        _pageHeaderView.titleColor=[UIColor blackColor];
        _pageHeaderView.sliderColor=ColorFromHexRGB(0x2fa6df);
        _pageHeaderView.titles=@[@"普通公积金",@"补充公积金"];
        [_pageHeaderView setTabSize:CGSizeMake(self.pageHeaderView.width/self.pageHeaderView.titles.count, 2)];
        [_pageHeaderView setSelectedIndex:self.selectIndex];
    }
    return _pageHeaderView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDProvidentFundDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CDProvidentFundDetailCell" owner:nil options:nil]lastObject];
    }
    [cell setCellItem:[self.arrData cd_safeObjectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - CDSlidePageHeaderViewDelegate
- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView didSelectButtonAtIndex:(NSUInteger)index{
    if (headerView==self.pageHeaderView) {
        self.selectIndex=index;
        [self refreshArrDataWithSelectIndex:index];
        [self refreshHeaderViewDataWithSelectIndex:index];
    }
}

- (void)refreshArrDataWithSelectIndex:(NSInteger)selectindex{
    [self.arrData removeAllObjects];
    if (selectindex==0) {
        [self.arrData addObjectsFromArray:self.loginModel.basicpridetail];
    }else if (selectindex==1){
        [self.arrData addObjectsFromArray:self.loginModel.supplypridetail];
    }
    if (self.arrData.count==0) {
        [self.tableView cd_showWatermark:@"no_detail" animated:YES Target:nil Action:nil];
    }else{
        [self.tableView cd_hideWatermark:YES];
    }
    [self.tableView reloadData];
}

- (void)refreshHeaderViewDataWithSelectIndex:(NSInteger)selectindex{
    if (selectindex==0) {
        CDAccountInfoItem *item=[self.loginModel.basic firstObject];
        [self.detailHeaderView setupAccountInfo:item];
    }else if (selectindex==1){
        CDAccountInfoItem *item=[self.loginModel.supply firstObject];
        [self.detailHeaderView setupAccountInfo:item];
    }
    
}

- (void)refreshTableHeadView{
    [self.tableHeadView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.loginModel.basic && self.loginModel.supply) {
        [self.tableHeadView addSubview:self.pageHeaderView];
        self.headerTitleView.top=self.pageHeaderView.bottom;
        [self.tableHeadView addSubview:self.headerTitleView];
        self.tableHeadView.height=self.headerTitleView.bottom;
    }else{
        self.headerTitleView.top=0;
        [self.tableHeadView addSubview:self.headerTitleView];
        self.tableHeadView.height=self.headerTitleView.bottom;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
