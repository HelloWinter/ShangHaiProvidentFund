//
//  CDForgotPasswordResetController.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/9/12.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDForgotPasswordResetController.h"
#import "CDForgotPasswordResetModel.h"
#import "CDButtonTableFooterView.h"
#import "CDForgotPWDResetService.h"
#import "CDOpinionsSuggestionsFieldCell.h"
#import "CDNormalTextFieldConfigureItem.h"
#import "UITextField+cellIndexPath.h"
#import "NSString+CDEncryption.h"

@interface CDForgotPasswordResetController ()

@property (nonatomic, strong) CDForgotPasswordResetModel *forgotPasswordResetModel;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;
@property (nonatomic, strong) CDForgotPWDResetService *forgotPWDResetService;

@end

@implementation CDForgotPasswordResetController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title=@"遗忘密码";
        self.hidesBottomBarWhenPushed=YES;
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=self.footerView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cellTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    if (self.forgotPWDResetService.isLoading) {
        [self.forgotPWDResetService cancel];
    }
}

- (CDForgotPasswordResetModel *)forgotPasswordResetModel{
    if (!_forgotPasswordResetModel) {
        _forgotPasswordResetModel=[[CDForgotPasswordResetModel alloc]init];
    }
    return _forgotPasswordResetModel;
}

- (CDForgotPWDResetService *)forgotPWDResetService{
    if (!_forgotPWDResetService) {
        _forgotPWDResetService=[[CDForgotPWDResetService alloc]initWithDelegate:self];
    }
    return _forgotPWDResetService;
}

- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:@"提交"];
        [_footerView setupBtnBackgroundColor:ColorFromHexRGB(0x36c362)];////ColorFromHexRGB(0xfe6565)
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            [weakSelf p_footerViewButtonClicked];
        };
    }
    return _footerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.forgotPasswordResetModel.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDOpinionsSuggestionsFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDOpinionsSuggestionsFieldCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
    }
    CDNormalTextFieldConfigureItem *item=[self.forgotPasswordResetModel.arrData cd_safeObjectAtIndex:indexPath.row];
    [cell setupItem:item indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

#pragma mark - NSNotification
- (void)cellTextDidChange:(NSNotification *)noti{
    UITextField *textField = noti.object;
    CDNormalTextFieldConfigureItem *cellItem = [self.forgotPasswordResetModel.arrData cd_safeObjectAtIndex:textField.indexPath.row];
    cellItem.value=textField.text;
}

#pragma mark - CDJSONBaseNetworkService
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    [super serviceDidFinished:service];
    if (self.forgotPWDResetService.returnCode==1) {
        [CDAutoHideMessageHUD showMessage:@"重置密码成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [CDAutoHideMessageHUD showMessage:@"重置密码失败"];
    }
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [CDAutoHideMessageHUD showMessage:error.description];
}

#pragma mark - private
- (void)p_footerViewButtonClicked{
    [self.view endEditing:YES];
    NSString *new_pwd=nil;
    NSString *repwd=nil;
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict cd_safeSetObject:@"21" forKey:@"ID"];
    for (CDNormalTextFieldConfigureItem *item in self.forgotPasswordResetModel.arrData) {
        if (item.value.length==0) {
            [CDAutoHideMessageHUD showMessage:@"请输入必填信息"];
            return;
        }
        if ([item.paramsubmit isEqualToString:@"repwd"]) {
            repwd=item.value;
        }else{
            NSString *value=item.value;
            if ([item.paramsubmit isEqualToString:@"newpwd_md5"]) {
                new_pwd=item.value;
                if (new_pwd.length<6 || new_pwd.length>15) {
                    [CDAutoHideMessageHUD showMessage:@"密码应为6-15位字母或数字组合"];
                    return;
                }
                value = [item.value cd_md5HexDigest].uppercaseString;
            }
            if ([item.paramsubmit isEqualToString:@"pri_account"]) {
                if (item.value.length==9) {
                    value = [value stringByAppendingString:@"205"];
                }
                if (value.length!=12 || (![value hasPrefix:@"0"] && ![value hasPrefix:@"1"]) || ![value hasSuffix:@"205"]) {
                    [CDAutoHideMessageHUD showMessage:@"公积金账号输入不合法"];
                    return;
                }
            }
            if ([item.paramsubmit isEqualToString:@"id_card_num"]) {
                if (!verifyIDCard(item.value)) {
                    [CDAutoHideMessageHUD showMessage:@"身份证号不合法"];
                    return;
                }
            }
            [dict cd_safeSetObject:value forKey:item.paramsubmit];
        }
    }
    if (![new_pwd isEqualToString:repwd]) {
        [CDAutoHideMessageHUD showMessage:@"两次密码输入不一致"];
        return;
    }
    [self.forgotPWDResetService loadResetServiceWithParams:dict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
