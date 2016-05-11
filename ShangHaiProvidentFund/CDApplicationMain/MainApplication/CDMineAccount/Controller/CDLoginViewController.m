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

@interface CDLoginViewController ()

@property (nonatomic, strong) CDButtonTableFooterView *footerView;
@property (nonatomic, strong) CDLoginConfigureModel *loginConfigureModel;

@end

@implementation CDLoginViewController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"登录";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=self.footerView;
    [self cd_showBackButton];
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
        _footerView.buttonClickBlock=^(UIButton *sender){
            
        };
    }
    return _footerView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)layoutButtonBottomViews{
    UIButton *btnForgetPSW=[UIButton buttonWithType:(UIButtonTypeCustom)];
    btnForgetPSW.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.view.bottom-45, 80, 20);
    [btnForgetPSW setTitle:@"忘记密码" forState:(UIControlStateNormal)];
    [btnForgetPSW setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btnForgetPSW.titleLabel.font=[UIFont systemFontOfSize:13];
    btnForgetPSW.backgroundColor=[UIColor clearColor];
    [btnForgetPSW addTarget:self action:@selector(btnForgetPSWTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//    [btnForgetPSW setBorderColor:[UIColor whiteColor]];
//    [btnForgetPSW setBorderWidth:0.5f];
//    [btnForgetPSW setCustomBorderStyle:(SCYBorderStyleRight)];
    btnForgetPSW.centerX=(self.view.width-btnForgetPSW.width)*0.5f;
    [self.tableView addSubview:btnForgetPSW];
    
    UIButton *btnRegist =[UIButton buttonWithType:(UIButtonTypeCustom)];
    [btnRegist setFrame:CGRectMake(btnForgetPSW.right,btnForgetPSW.top, btnForgetPSW.width, btnForgetPSW.height)];
    [btnRegist setTitle:@"注册账号" forState:(UIControlStateNormal)];
    [btnRegist setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btnRegist.titleLabel.font=[UIFont systemFontOfSize:13];
    btnRegist.backgroundColor=[UIColor clearColor];
    [btnRegist addTarget:self action:@selector(btnRegistTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.tableView addSubview:btnRegist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
