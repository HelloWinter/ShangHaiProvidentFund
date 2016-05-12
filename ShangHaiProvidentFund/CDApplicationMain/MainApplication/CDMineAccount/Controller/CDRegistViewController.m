//
//  CDRegistViewController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/10.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDRegistViewController.h"
#import "CDButtonTableFooterView.h"
#import "CDOpinionsSuggestionsItem.h"
#import "CDRegistConfigureModel.h"
#import "CDOpinionsSuggestionsFieldCell.h"
#import "CDRegistGetVerCodeService.h"
#import "CDRegistService.h"

@interface CDRegistViewController ()

@property (nonatomic, strong) CDRegistConfigureModel *registConfigureModel;

@property (nonatomic, strong) CDButtonTableFooterView *footerView;
@property (nonatomic, strong) UIButton *btnProtocol;

@end

@implementation CDRegistViewController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"个人注册";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.height+=49;
    self.tableView.tableFooterView=self.footerView;
}

- (CDRegistConfigureModel *)registConfigureModel{
    if(_registConfigureModel == nil){
        _registConfigureModel = [[CDRegistConfigureModel alloc]init];
    }
    return _registConfigureModel;
}



- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:@"注册"];
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            
        };
    }
    return _footerView;
}

- (UIButton *)btnProtocol{
    if (!_btnProtocol) {
        CGFloat btnHeight=25;
        _btnProtocol =[UIButton buttonWithType:(UIButtonTypeCustom)];
        [_btnProtocol setFrame:CGRectMake(LEFT_RIGHT_MARGIN,10, 170, btnHeight)];
        [_btnProtocol setTitle:@"  我已阅读并同意用户协定" forState:(UIControlStateNormal)];
        [_btnProtocol setTitleColor:ColorFromHexRGB(0xbdc0c2) forState:(UIControlStateNormal)];
        _btnProtocol.titleLabel.font=[UIFont systemFontOfSize:13];
        [_btnProtocol setImage:[UIImage imageNamed:@"checkmark"] forState:(UIControlStateNormal)];
        [_btnProtocol addTarget:self action:@selector(btnReadedProtocol:) forControlEvents:(UIControlEventTouchUpInside)];
        _btnProtocol.hidden=YES;
    }
    return _btnProtocol;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.registConfigureModel.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDOpinionsSuggestionsFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (nil == cell) {
        cell = [[CDOpinionsSuggestionsFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
    }
    CDOpinionsSuggestionsItem *item=[self.registConfigureModel.arrData cd_safeObjectAtIndex:indexPath.row];
    [cell setupItem:(item) indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
