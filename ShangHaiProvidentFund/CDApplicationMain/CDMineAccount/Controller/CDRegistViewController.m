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
#import "CDRegistFooterView.h"
#import "CDBaseWKWebViewController.h"
#import "UITextField+cellIndexPath.h"
#import "CDVerificationCodeCell.h"
#import "CDRegistGetVerCodeService.h"

@interface CDRegistViewController ()

@property (nonatomic, strong) CDRegistConfigureModel *registConfigureModel;
@property (nonatomic, strong) CDRegistFooterView *footerView;
@property (nonatomic, strong) CDRegistService *registService;
@property (nonatomic, strong) CDRegistGetVerCodeService *getVerCodeService;

@end

@implementation CDRegistViewController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"个人注册";
        self.showDragView=NO;
        self.hideKeyboradWhenTouch=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.height+=49;
    self.tableView.tableFooterView=self.footerView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(controlTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.registService.isLoading) {
        [self.registService cancel];
    }
    if (self.getVerCodeService.isLoading) {
        [self.getVerCodeService cancel];
    }
}

- (CDRegistService *)registService{
    if (_registService==nil) {
        _registService=[[CDRegistService alloc]initWithDelegate:self];
    }
    return _registService;
}

- (CDRegistGetVerCodeService *)getVerCodeService{
    if (_getVerCodeService==nil) {
        _getVerCodeService=[[CDRegistGetVerCodeService alloc]initWithDelegate:self];
    }
    return _getVerCodeService;
}

- (CDRegistConfigureModel *)registConfigureModel{
    if(_registConfigureModel == nil){
        _registConfigureModel = [[CDRegistConfigureModel alloc]init];
    }
    return _registConfigureModel;
}

- (CDRegistFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[[CDRegistFooterView alloc]init];
        _footerView.frame=CGRectMake(0, 0, self.tableView.width, 140);
        __weak typeof(self) weakSelf=self;
        _footerView.showProtocolBlock=^(){
            [weakSelf pushToWKWebViewControllerWithTitle:@"个人用户协议" javaScriptCode:nil URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=yhxy")];
        };
        _footerView.registBlock=^(){
            [weakSelf regist];
        };
        _footerView.showProblemBlock=^(){
            [weakSelf showProbilemActionSheet];
        };
    }
    return _footerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.registConfigureModel.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CDOpinionsSuggestionsItem *item=[self.registConfigureModel.arrData cd_safeObjectAtIndex:indexPath.row];
    if ([item.type isEqualToString:@"2"]) {
        static NSString *vercellidentifier = @"vercellidentifier";
        CDVerificationCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:vercellidentifier];
        if (nil == cell) {
            cell = [[CDVerificationCodeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:vercellidentifier];
            __weak typeof(self) weakSelf=self;
            cell.getVerCodeBlock=^BOOL(){
                return [weakSelf getVerCode];
            };
        }
        [cell setupItem:(item) indexPath:indexPath];
        return cell;
    }else{
        static NSString *cellidentifier = @"cellidentifier";
        CDOpinionsSuggestionsFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (nil == cell) {
            cell = [[CDOpinionsSuggestionsFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
        }
        [cell setupItem:(item) indexPath:indexPath];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    [super serviceDidFinished:service];
    if ([service isKindOfClass:[CDRegistGetVerCodeService class]]) {
        if (![self.getVerCodeService.code isEqualToString:@"0"]) {
            [CDAutoHideMessageHUD showMessage:self.getVerCodeService.msg];
        }
    }else if ([service isKindOfClass:[CDRegistService class]]){
        
    }
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super service:service didFailLoadWithError:error];
}

#pragma mark - Notification
- (void)controlTextDidChange:(NSNotification *)noti{
    UITextField *textField = noti.object;
    CDOpinionsSuggestionsItem *cellItem = [self.registConfigureModel.arrData cd_safeObjectAtIndex:textField.indexPath.row];
    cellItem.value=textField.text;
}

#pragma mark - Events
- (void)pushToWKWebViewControllerWithTitle:(NSString *)title javaScriptCode:(NSString *)jsCode URLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=title;
    webViewController.javaScriptCode=jsCode;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)showProbilemActionSheet{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *actionProbilem=[UIAlertAction actionWithTitle:@"常见问题" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSString *jsCode=[CDUtilities jsCodeDeleteHTMLNodeWith:@"element" tagName:@"link"];
        [self pushToWKWebViewControllerWithTitle:@"常见问题" javaScriptCode:jsCode URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=cjwt")];
    }];
    UIAlertAction *actionQuery=[UIAlertAction actionWithTitle:@"个人公积金账号查询" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self pushToWKWebViewControllerWithTitle:@"个人公积金账号查询" javaScriptCode:nil URLString:@"http://m.shgjj.com/verifier/verifier/index"];
    }];
    [alert addAction:actionCancel];
    [alert addAction:actionProbilem];
    [alert addAction:actionQuery];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)regist{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    NSString *psw=nil;
    NSString *repsw=nil;
    for (CDOpinionsSuggestionsItem *item in self.registConfigureModel.arrData) {
        if (item.value.length==0) {
            [CDAutoHideMessageHUD showMessage:@"请输入必填信息"];
            return;
        }
        if ([item.paramsubmit isEqualToString:@"pwd"]) {
            psw=item.value;
        }
        if ([item.paramsubmit isEqualToString:@"repwd"]) {
            repsw=item.value;
        }
        if (![item.paramsubmit isEqualToString:@"repwd"]) {
            [dict cd_safeSetObject:item.value forKey:item.paramsubmit];
        }
    }
    if (![psw isEqualToString:repsw]) {
        [CDAutoHideMessageHUD showMessage:@"密码不一致"];
        return;
    }
    [self.registService loadWithParams:dict showIndicator:YES];
}

- (NSString *)getMobileNum{
    for (CDOpinionsSuggestionsItem *item in self.registConfigureModel.arrData) {
        if ([item.paramsubmit isEqualToString:@"mobile"]) {
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
}

@end
