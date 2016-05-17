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
    self.tableView.height=self.tableView.height-self.detailHeaderView.height;
//    [self refreshTableHeadView];
//    [self refreshArrDataWithSelectIndex:self.selectIndex];
//    [self refreshHeaderViewDataWithSelectIndex:self.selectIndex];
    self.tableView.tableHeaderView=self.headerTitleView;
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
        [_headerTitleView setupWithFirstDesc:@"日期" secondDesc:@"业务描述" thirdDesc:@"发生金额"];
    }
    return _headerTitleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
