//
//  CDOpinionsSuggestionsController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDOpinionsSuggestionsController.h"
#import "CDOpinionsSuggestionsItem.h"
#import "CDOpinionsSuggestionsModel.h"
#import "CDOpinionsSuggestionsFieldCell.h"
#import "CDOpinionsSuggestionsViewCell.h"
#import "UITextField+cellIndexPath.h"
#import "UITextView+CDCategory.h"
#import "CDButtonTableFooterView.h"
#import "CDCommitMessageService.h"

@interface CDOpinionsSuggestionsController ()

@property (nonatomic, strong) CDOpinionsSuggestionsModel *opinionsSuggestionsModel;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;
@property (nonatomic, strong) CDCommitMessageService *commitMessageService;

@end

@implementation CDOpinionsSuggestionsController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"在线留言";
        self.showDragView=NO;
        self.hideKeyboradWhenTouch=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=self.footerView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(controlTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(controlTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (CDButtonTableFooterView *)footerView{
    if(_footerView == nil){
        _footerView = [CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:@"提交"];
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            [weakSelf CommitMessage];
        };
    }
    return _footerView;
}

- (CDOpinionsSuggestionsModel *)opinionsSuggestionsModel{
    if(_opinionsSuggestionsModel == nil){
        _opinionsSuggestionsModel = [[CDOpinionsSuggestionsModel alloc]init];
    }
    return _opinionsSuggestionsModel;
}

- (CDCommitMessageService *)commitMessageService{
    if(_commitMessageService == nil){
        _commitMessageService = [[CDCommitMessageService alloc]initWithDelegate:self];
    }
    return _commitMessageService;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.opinionsSuggestionsModel.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CDOpinionsSuggestionsItem *item=[self.opinionsSuggestionsModel.arrData cd_safeObjectAtIndex:indexPath.row];
    if ([item.type isEqualToString:@"1"]) {
        static NSString *textViewCellIdentifier=@"textViewCellIdentifier";
        CDOpinionsSuggestionsViewCell *cell=[tableView dequeueReusableCellWithIdentifier:textViewCellIdentifier];
        if (!cell) {
            cell=[CDOpinionsSuggestionsViewCell textViewCell];
        }
        [cell setupCellItem:item indexPath:indexPath];
        return cell;
    }else{
        static NSString *cellidentifier = @"cellidentifier";
        CDOpinionsSuggestionsFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (nil == cell) {
            cell = [[CDOpinionsSuggestionsFieldCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
        }
        [cell setupItem:item indexPath:indexPath];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CDOpinionsSuggestionsItem *item=[self.opinionsSuggestionsModel.arrData cd_safeObjectAtIndex:indexPath.row];
    return ([item.type isEqualToString:@"1"]) ? 100 : 46;
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
    if ([self.commitMessageService.type isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super service:service didFailLoadWithError:error];
}

#pragma mark - Notification
- (void)controlTextDidChange:(NSNotification *)noti{
    if ([noti.object isKindOfClass:[UITextField class]]) {
        UITextField *textField = noti.object;
        CDOpinionsSuggestionsItem *cellItem = [self.opinionsSuggestionsModel.arrData cd_safeObjectAtIndex:textField.indexPath.row];
        cellItem.value=textField.text;
    }else if ([noti.object isKindOfClass:[UITextView class]]){
        UITextView *textView = noti.object;
        CDOpinionsSuggestionsItem *cellItem = [self.opinionsSuggestionsModel.arrData cd_safeObjectAtIndex:textView.indexPath.row];
        cellItem.value=textView.text;
    }
}

#pragma mark - private
- (void)CommitMessage{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    for (CDOpinionsSuggestionsItem *item in self.opinionsSuggestionsModel.arrData) {
        if (item.value.length==0) {
            [CDAutoHideMessageHUD showMessage:@"请输入必要信息"];
            return;
        }
        [dict cd_safeSetObject:item.value forKey:item.paramsubmit];
    }
    [self.commitMessageService loadWithParams:dict showIndicator:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
