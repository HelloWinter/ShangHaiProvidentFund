//
//  CDChangePasswordController.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/7/21.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDChangePasswordController.h"
#import "CDChangePasswordModel.h"
#import "CDOpinionsSuggestionsFieldCell.h"
#import "CDNormalTextFieldConfigureItem.h"
#import "CDButtonTableFooterView.h"
#import "UITextField+cellIndexPath.h"
#import "NSString+CDEncryption.h"
#import "CDChangePSWService.h"

@interface CDChangePasswordController ()

@property (nonatomic, strong) CDChangePasswordModel *changePasswordModel;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;
@property (nonatomic, strong) CDChangePSWService *changePSWService;

@end

@implementation CDChangePasswordController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title=@"修改密码";
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
    if (self.changePSWService.isLoading) {
        [self.changePSWService cancel];
    }
}

- (CDChangePasswordModel *)changePasswordModel{
    if (!_changePasswordModel) {
        _changePasswordModel=[[CDChangePasswordModel alloc]init];
    }
    return _changePasswordModel;
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

- (CDChangePSWService *)changePSWService{
    if (!_changePSWService) {
        _changePSWService=[[CDChangePSWService alloc]initWithDelegate:self];
    }
    return _changePSWService;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.changePasswordModel.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDOpinionsSuggestionsFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDOpinionsSuggestionsFieldCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
    }
    CDNormalTextFieldConfigureItem *item=[self.changePasswordModel.arrData cd_safeObjectAtIndex:indexPath.row];
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
    CDNormalTextFieldConfigureItem *cellItem = [self.changePasswordModel.arrData cd_safeObjectAtIndex:textField.indexPath.row];
    cellItem.value=textField.text;
}

#pragma mark - CDJSONBaseNetworkService
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    [super serviceDidFinished:service];
    NSDictionary *dict = (NSDictionary *)self.changePSWService.rootData;
    NSString *strResult=[dict objectForKey:@"result"];
    if ([strResult isEqualToString:@"0"]) {
        [CDAutoHideMessageHUD showMessage:@"修改密码成功,下次登录请使用新密码"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [CDAutoHideMessageHUD showMessage:@"修改密码失败"];
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
    if (self.userName==nil || self.userName.length==0) {
        [CDAutoHideMessageHUD showMessage:@"缺少必要参数"];
        return;
    }
    [dict cd_safeSetObject:self.userName forKey:@"userid"];
    for (CDNormalTextFieldConfigureItem *item in self.changePasswordModel.arrData) {
        if (item.value.length==0) {
            [CDAutoHideMessageHUD showMessage:@"请输入必填信息"];
            return;
        }
        if ([item.paramsubmit isEqualToString:@"new_pwd"]) {
            new_pwd=item.value;
            if (new_pwd.length<6 || new_pwd.length>15) {
                [CDAutoHideMessageHUD showMessage:@"密码应为6-15位字母或数字组合"];
                return;
            }
        }
        if ([item.paramsubmit isEqualToString:@"repwd"]) {
            repwd=item.value;
        }else{
            [dict cd_safeSetObject:[item.value cd_md5HexDigest].uppercaseString forKey:item.paramsubmit];
        }
    }
    if (![new_pwd isEqualToString:repwd]) {
        [CDAutoHideMessageHUD showMessage:@"新密码不一致"];
        return;
    }
    [self.changePSWService loadChangePWDWith:dict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
