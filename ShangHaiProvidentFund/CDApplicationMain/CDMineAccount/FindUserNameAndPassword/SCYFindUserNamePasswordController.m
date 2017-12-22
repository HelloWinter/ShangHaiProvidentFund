//
//  SCYFindUserNamePasswordController.m
//  ProvidentFund
//
//  Created by cdd on 16/9/22.
//  Copyright © 2016年 9188. All rights reserved.
//
/*

#import "SCYFindUserNamePasswordController.h"
#import "SCYFindUserNamePasswordModel.h"
#import "SCYNormalTextFieldCell.h"
#import "SCYVerificationCodeCell.h"
#import "SCYFundBingdingTFConfigureItem.h"
#import "SCYButtonTableFooterView.h"
#import "SCYFindUserNamePasswordService.h"
#import "SCYFindUserNamePasswordVerCodeService.h"
#import "SCYFundAccountNumQueryController.h"

@interface SCYFindUserNamePasswordController ()

@property (nonatomic, strong) SCYFindUserNamePasswordVerCodeService *getVerCodeService;
@property (nonatomic, strong) SCYFindUserNamePasswordService *findUserNamePasswordService;
@property (nonatomic, strong) SCYButtonTableFooterView *tableFooterView;
@property (nonatomic, strong) SCYFindUserNamePasswordModel *model;

@property (nonatomic, weak) UILabel *lbTips;

@end

@implementation SCYFindUserNamePasswordController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title=@"找回用户名和密码";
        self.tableViewStyle=(UITableViewStyleGrouped);
        self.showDragView=NO;
        self.hideKeyboradWhenTouch=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=46;
    self.tableView.tableFooterView=self.tableFooterView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (SCYFindUserNamePasswordVerCodeService *)getVerCodeService{
    if (_getVerCodeService==nil) {
        _getVerCodeService=[[SCYFindUserNamePasswordVerCodeService alloc]initWithDelegate:self];
    }
    return _getVerCodeService;
}

- (SCYFindUserNamePasswordService *)findUserNamePasswordService{
    if (_findUserNamePasswordService==nil) {
        _findUserNamePasswordService=[[SCYFindUserNamePasswordService alloc]initWithDelegate:self];
    }
    return _findUserNamePasswordService;
}

- (SCYButtonTableFooterView *)tableFooterView{
    if (_tableFooterView==nil) {
        CGFloat lbHeight=40;
        _tableFooterView = [[SCYButtonTableFooterView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 80+lbHeight)];
        [_tableFooterView setupBtnTitle:@"确认"];
        [_tableFooterView setBtnTop:lbHeight+20];
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(kLeftAndRightMargin, 0, _tableFooterView.width-kLeftAndRightMargin*2, lbHeight);
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=[UIColor redColor];
        label.numberOfLines=0;
        label.lineBreakMode=NSLineBreakByWordWrapping;
        label.text=@"用户名和密码将以短信的形式发送到您的手机，请注意查收，若未收到请再重复操作一次。";
        [_tableFooterView addSubview:label];
        self.lbTips=label;
        
        WS(weakSelf);
        _tableFooterView.buttonClickBlock=^(UIButton *sender){
            [weakSelf findUserNamePassword];
        };
    }
    return _tableFooterView;
}

- (SCYFindUserNamePasswordModel *)model{
    if (_model==nil) {
        _model=[[SCYFindUserNamePasswordModel alloc]init];
    }
    return _model;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCYFundBingdingTFConfigureItem *item=[self.model.arrData cd_safeObjectAtIndex:indexPath.row];
    if (![item.type isEqualToString:@"2"]) {
        static NSString *cellidentifier = @"cellidentifier";
        SCYNormalTextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!cell) {
            cell = [[SCYNormalTextFieldCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
            WS(weakSelf);
            cell.buttonClickBlock=^(NSIndexPath *path){
                [weakSelf pushToQueryAccountNumController];
            };
        }
        [cell setupItem:item indexPath:indexPath];
        return cell;
    }else{
        static NSString *VerCodecellidentifier = @"VerCodecellidentifier";
        SCYVerificationCodeCell *cell=[tableView dequeueReusableCellWithIdentifier:VerCodecellidentifier];
        if (!cell) {
            cell = [[SCYVerificationCodeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:VerCodecellidentifier];
            __weak typeof(self) weakSelf=self;
            cell.getVerCodeBlock=^BOOL(){
                return [weakSelf getVerCode];
            };
        }
        [cell setupItem:item indexPath:indexPath];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SCYBaseNetworkServiceDelegate
- (void)serviceDidFinished:(SCYBaseNetworkService *)service{
    [super serviceDidFinished:service];
    if ([service isKindOfClass:[SCYFindUserNamePasswordVerCodeService class]]) {
        if (service.returnCode==1) {
            [CDAutoHideMessageHUD showMessage:service.desc];
        }
    }else if([service isKindOfClass:[SCYFindUserNamePasswordService class]]){
        [self.tableFooterView activityIndicatorStopAnimate];
        if (service.returnCode==1) {
            [CDAutoHideMessageHUD showMessage:service.desc];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)service:(SCYBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super service:service didFailLoadWithError:error];
    [self.tableFooterView activityIndicatorStopAnimate];
}

- (void)serviceDidCancel:(SCYBaseNetworkService *)service{
    [super serviceDidCancel:service];
    [self.tableFooterView activityIndicatorStopAnimate];
}

#pragma mark - NSNotification
- (void)textFieldDidChanged:(NSNotification *)noti{
    UITextField *textField=noti.object;
    NSIndexPath *path=textField.indexPath;
    SCYFundBingdingTFConfigureItem *item = [self.model.arrData cd_safeObjectAtIndex:path.row];
    item.value=textField.text;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    [super keyboardWillShow:notification];
    UIEdgeInsets insets=self.tableView.contentInset;
    insets.bottom=_keyboardBounds.size.height;
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (void)keyboardWillHide:(NSNotification *)notification{
    [super keyboardWillHide:notification];
    [UIView animateWithDuration:_keybardAnmiatedTimeinterval animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
    }];
}

#pragma mark - private
//查询公积金账号(上海)
- (void)pushToQueryAccountNumController{
    SCYFundAccountNumQueryController *controller=[[SCYFundAccountNumQueryController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)findUserNamePassword{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    for (SCYFundBingdingTFConfigureItem *item in self.model.arrData) {
        if (item.value.length==0) {
            [CDAutoHideMessageHUD showMessage:@"请输入必填信息"];
            return;
        }
        if ([item.paramsubmit isEqualToString:@"cardNo"] && !verifyIDCard(item.value)) {
            [CDAutoHideMessageHUD showMessage:@"身份证输入不合法"];
            return;
        }
        if ([item.paramsubmit isEqualToString:@"mobileNo"] && item.value.length!=11) {
            [CDAutoHideMessageHUD showMessage:@"手机号输入不合法"];
            return;
        }
        [dict cd_safeSetObject:item.value forKey:item.paramsubmit];
    }
    [self.findUserNamePasswordService loadWithParams:dict showIndicator:NO];
    [self.tableFooterView activityIndicatorStartAnimate];
}

- (NSString *)getMobileNum{
    for (SCYFundBingdingTFConfigureItem *item in self.model.arrData) {
        if ([item.paramsubmit isEqualToString:@"mobileNo"]) {
            if (item.value.length==0) {
                [CDAutoHideMessageHUD showMessage:@"请输入手机号"];
                return nil;
            }
            return item.value;
        }
    }
    return nil;
}

- (BOOL)getVerCode{
    NSString *mobileNum =[self getMobileNum];
    if (!mobileNum) {
        [CDAutoHideMessageHUD showMessage:@"请输入手机号"];
        return NO;
    }
    if (mobileNum.length!=11) {
        [CDAutoHideMessageHUD showMessage:@"手机号输入不正确"];
        return NO;
    }
    [self.getVerCodeService loadWithMobileNum:mobileNum showIndicator:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
 */
