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
#import "CDBottomButtonView.h"

@interface CDLoginViewController ()

@property (nonatomic, strong) CDButtonTableFooterView *footerView;
@property (nonatomic, strong) CDLoginConfigureModel *loginConfigureModel;
@property (nonatomic, strong) CDBottomButtonView *bottomButtonView;

@end

@implementation CDLoginViewController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"登录";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cd_showBackButton];
    self.tableView.height+=49;
    self.tableView.tableFooterView=self.footerView;
    [self.view addSubview:self.bottomButtonView];
//    [_bottomButtonView setNeedsDisplay];
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

- (CDBottomButtonView *)bottomButtonView{
    if(_bottomButtonView == nil){
        _bottomButtonView = [[CDBottomButtonView alloc]init];
        _bottomButtonView.frame=CGRectMake(0, 0, 160, 20);
        _bottomButtonView.center=CGPointMake(self.view.width*0.5, self.tableView.bottom-30);
        _bottomButtonView.forgotPSWBlock=^(){
            
        };
        _bottomButtonView.registBlock=^(){
            
        };
//        [_bottomButtonView setNeedsDisplay];
    }
    return _bottomButtonView;
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
    btnForgetPSW.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.tableView.bottom-45, 80, 20);
    [btnForgetPSW setTitle:@"忘记密码" forState:(UIControlStateNormal)];
    [btnForgetPSW setTitleColor:ColorFromHexRGB(0x01b2d3) forState:(UIControlStateNormal)];
    btnForgetPSW.titleLabel.font=[UIFont systemFontOfSize:13];
    btnForgetPSW.backgroundColor=[UIColor clearColor];
    [btnForgetPSW addTarget:self action:@selector(btnForgetPSWTapped:) forControlEvents:(UIControlEventTouchUpInside)];
//    [btnForgetPSW setBorderColor:[UIColor whiteColor]];
//    [btnForgetPSW setBorderWidth:0.5f];
//    [btnForgetPSW setCustomBorderStyle:(SCYBorderStyleRight)];
    btnForgetPSW.centerX=(self.view.width-btnForgetPSW.width)*0.5f;
    [self.view addSubview:btnForgetPSW];
    
    UIButton *btnRegist =[UIButton buttonWithType:(UIButtonTypeCustom)];
    [btnRegist setFrame:CGRectMake(btnForgetPSW.right,btnForgetPSW.top, btnForgetPSW.width, btnForgetPSW.height)];
    [btnRegist setTitle:@"注册账号" forState:(UIControlStateNormal)];
    [btnRegist setTitleColor:ColorFromHexRGB(0x01b2d3) forState:(UIControlStateNormal)];
    btnRegist.titleLabel.font=[UIFont systemFontOfSize:13];
    btnRegist.backgroundColor=[UIColor clearColor];
    [btnRegist addTarget:self action:@selector(btnRegistTapped:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btnRegist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
