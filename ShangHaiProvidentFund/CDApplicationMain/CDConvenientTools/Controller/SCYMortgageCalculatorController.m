//
//  SCYMortgageCalculatorController.m
//  ProvidentFund
//
//  Created by cdd on 16/3/17.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYMortgageCalculatorController.h"
#import "SCYLoanRateItem.h"
#import "SCYMortgageCalculatorService.h"
#import "SCYMortgageCalculatorModel.h"
#import "SCYMeasurementTextFieldCell.h"
#import "SCYMortgageCalculatorCellItem.h"
#import "SCYMortgageCalculatorSelectCell.h"
#import "SCYPopTableView.h"
#import "SCYMortgageCalculatorResultCell.h"
#import "SCYMortgageCalculatorSourceItem.h"
#import "SCYMortgageCalculatorResultItem.h"
#import "UITextField+cellIndexPath.h"
#import "CDButtonTableFooterView.h"

static const CGFloat topHeight=50;

@interface SCYMortgageCalculatorController ()

@property (nonatomic, strong) SCYMortgageCalculatorService *mortgageCalculatorService;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) SCYMortgageType mortgageType;
@property (nonatomic, strong) SCYMortgageCalculatorModel *mortgageCalculatorModel;
@property (nonatomic, strong) SCYPopTableView *popTableView;
@property (nonatomic, strong) SCYMortgageCalculatorResultItem *resultItem;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;

@end

@implementation SCYMortgageCalculatorController

- (instancetype)init{
    self =[super init];
    if (self) {
        self.tableViewStyle=UITableViewStyleGrouped;
        self.title=@"房贷计算";
        self.mortgageType=SCYMortgageTypeProvidentFundLoan;
        self.hideKeyboradWhenTouch=YES;
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    self.tableView.frame=CGRectMake(0, topHeight, self.view.width, self.view.height-topHeight-64);
    [self.mortgageCalculatorService loadWithIgnoreCache:NO showIndicator:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (int i=0; i<self.arrData.count; i++) {
        UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if ([cell isKindOfClass:[SCYMeasurementTextFieldCell class]]) {
            SCYMeasurementTextFieldCell *textfieldCell=(SCYMeasurementTextFieldCell *)cell;
            [textfieldCell textfieldBecomeFirstResponder];
            return;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        _footerView.size=CGSizeMake(self.tableView.width, 82);
        _footerView.backgroundColor=[UIColor whiteColor];
        [_footerView setupBtnTitle:@"开始计算"];
        [_footerView setupBtnBackgroundColor:ColorFromHexRGB(0x38ca73)];
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            [weakSelf p_startCalculator];
        };
    }
    return _footerView;
}

- (SCYMortgageCalculatorModel *)mortgageCalculatorModel{
    if (_mortgageCalculatorModel==nil) {
        _mortgageCalculatorModel=[[SCYMortgageCalculatorModel alloc]init];
    }
    return _mortgageCalculatorModel;
}

- (SCYMortgageCalculatorService *)mortgageCalculatorService{
    if (_mortgageCalculatorService==nil) {
        _mortgageCalculatorService=[[SCYMortgageCalculatorService alloc]initWithDelegate:self];
    }
    return _mortgageCalculatorService;
}

- (SCYPopTableView *)popTableView{
    if (_popTableView==nil) {
        _popTableView=[[SCYPopTableView alloc]init];
        __weak typeof(self) weakSelf=self;
        _popTableView.cellTouched=^(NSInteger index,SCYMortgageCalculatorCellItem *item){
            weakSelf.resultItem=nil;
            [weakSelf.tableView reloadData];
        };
    }
    return _popTableView;
}

- (NSMutableArray *)arrData{
    if (_arrData==nil) {
        _arrData=[[NSMutableArray alloc]init];
    }
    return _arrData;
}

- (UIView*)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, topHeight)];
        _headerView.backgroundColor = [UIColor whiteColor];
         UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"公积金贷款",@"商业贷款",@"组合贷款", nil]];
        segmentControl.bounds=CGRectMake(0, 0, self.view.width-20, 30);
        segmentControl.center=CGPointMake(_headerView.width*0.5, _headerView.height*0.5);
        [segmentControl addTarget:self action:@selector(p_segmentAction:) forControlEvents:UIControlEventValueChanged];
        segmentControl.selectedSegmentIndex = 0;
        segmentControl.tintColor = NAVIGATION_COLOR;
        [_headerView addSubview:segmentControl];
    }
    return _headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.mortgageCalculatorService.isLoaded) {
        return 0;
    }
    if (section==0) {
        return self.arrData.count;
    }else if (section==1){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SCYMortgageCalculatorCellItem *item=[self.arrData cd_safeObjectAtIndex:indexPath.row];
        if ([item.paramtype isEqualToString:@"0"]) {
            static NSString *cellidentifier = @"cellidentifier";
            SCYMeasurementTextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
            if (!cell) {
                cell = [[SCYMeasurementTextFieldCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
            }
            [cell setupMortgageCalculatorCellItem:item IndexPath:indexPath];
            return cell;
        }else if ([item.paramtype isEqualToString:@"1"]){
            static NSString *subCityIdentifier = @"subCityIdentifier";
            SCYMortgageCalculatorSelectCell *cell=[tableView dequeueReusableCellWithIdentifier:subCityIdentifier];
            if (!cell) {
                cell=[[SCYMortgageCalculatorSelectCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:subCityIdentifier];
            }
            [cell setupCellItem:item indexPath:indexPath];
            return cell;
        }
    }else if (indexPath.section==1){
        static NSString *resultCellIdentifier=@"resultCellIdentifier";
        SCYMortgageCalculatorResultCell *cell=[tableView dequeueReusableCellWithIdentifier:resultCellIdentifier];
        if (!cell) {
            cell = [SCYMortgageCalculatorResultCell resultCell];
        }
        [cell setupPayAllMoney:self.resultItem.totalRepayment monthNumber:self.resultItem.duetime interest:self.resultItem.totalInterest monthPay:self.resultItem.monthlyRepayment payType:self.resultItem.payType];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (!self.mortgageCalculatorService.isLoaded) {
        return nil;
    }
    return (section==0) ? self.footerView : nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==1 ? 160 : 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0 ? 0.01 : 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (section==0) ? 82 : 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        SCYMortgageCalculatorCellItem *item=[self.arrData cd_safeObjectAtIndex:indexPath.row];
        if ([item.paramtype isEqualToString:@"1"] && [item.paramselect isEqualToString:@"1"]) {
            if ([item.paramkey isEqualToString:@"paytype"]) {
                [self.popTableView setupViewData:item popType:(SCYPopTableViewTypePayType) indexPath:indexPath];
            }else{
                [self.popTableView setupViewData:item popType:(SCYPopTableViewTypeSelectRate) indexPath:indexPath];
            }
            [self.popTableView show:YES];
        }
    }
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    [super serviceDidFinished:service];
    if (self.mortgageCalculatorService.returnCode==1) {
        [self p_recombinationData];
    }
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super service:service didFailLoadWithError:error];
}

#pragma mark - override
- (void)startPullRefresh{
    [self.mortgageCalculatorService loadWithIgnoreCache:YES showIndicator:NO];
}

#pragma mark - NSNotification
- (void)textFieldDidChanged:(NSNotification *)noti{
    UITextField *textField=noti.object;
    NSIndexPath *path=textField.indexPath;
    SCYMortgageCalculatorCellItem *rowItem=[self.arrData cd_safeObjectAtIndex:path.row];
    if ([rowItem.paramtype isEqualToString:@"0"]) {
        rowItem.paramvalue=textField.text;
    }
}

#pragma mark - private
- (void)p_segmentAction:(UISegmentedControl*)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.mortgageType=SCYMortgageTypeProvidentFundLoan;
            break;
        case 1:
            self.mortgageType=SCYMortgageTypeCommercialLoan;
            break;
        case 2:
            self.mortgageType=SCYMortgageTypeCombinedLoan;
            break;
        default:
            break;
    }
    [self p_refreshArrData];
}

/**
 *  重组数据，用动态数据修改内存中模型
 */
- (void)p_recombinationData{
    for (SCYMortgageCalculatorCellItem *item in self.mortgageCalculatorModel.businessloan) {
        if ([item.paramkey isEqualToString:@"businessloanrate"]) {
            SCYLoanRateItem *rateItem = [self.mortgageCalculatorService.businessloan cd_safeObjectAtIndex:0];
            item.paramvalue=rateItem.rate;
            [item.paramsubitemsdata removeAllObjects];
            [item.paramsubitemsdata addObjectsFromArray:self.mortgageCalculatorService.businessloan];
        }
    }
    for (SCYMortgageCalculatorCellItem *item in self.mortgageCalculatorModel.combinedloan) {
        if ([item.paramkey isEqualToString:@"businessloanrate"]) {
            SCYLoanRateItem *rateItem = [self.mortgageCalculatorService.businessloan cd_safeObjectAtIndex:0];
            item.paramvalue=rateItem.rate;
            [item.paramsubitemsdata removeAllObjects];
            [item.paramsubitemsdata addObjectsFromArray:self.mortgageCalculatorService.businessloan];
        }
    }
    [self p_refreshArrData];
}

- (void)p_refreshArrData{
    [self.arrData removeAllObjects];
    if (self.mortgageType==SCYMortgageTypeProvidentFundLoan) {
        [self.arrData addObjectsFromArray:self.mortgageCalculatorModel.providentfundloan];
    }else if (self.mortgageType==SCYMortgageTypeCommercialLoan){
        [self.arrData addObjectsFromArray:self.mortgageCalculatorModel.businessloan];
    }else if (self.mortgageType==SCYMortgageTypeCombinedLoan){
        [self.arrData addObjectsFromArray:self.mortgageCalculatorModel.combinedloan];
    }
    self.resultItem=nil;
    [self.tableView reloadData];
}

- (void)p_startCalculator{
    [self.view endEditing:YES];
    
    SCYMortgageCalculatorSourceItem *sourceItemfund = [[SCYMortgageCalculatorSourceItem alloc]init];
    SCYMortgageCalculatorSourceItem *sourceItembusiness = [[SCYMortgageCalculatorSourceItem alloc]init];
    
    for (SCYMortgageCalculatorCellItem *item in self.arrData) {
        if (![item.paramkey isEqualToString:@"fundloanrate"] && ![item.paramkey isEqualToString:@"paytype"]) {
            if (item.paramvalue.length==0 || [item.paramvalue doubleValue]==0) {
                [CDAutoHideMessageHUD showMessage:item.paramemptytip];
                return;
            }
        }
        if ([item.paramkey isEqualToString:@"fundloanmoney"]) {
            sourceItemfund.capitalization=[item.paramvalue floatValue] * [item.paramunitvalue floatValue];
        }else if ([item.paramkey isEqualToString:@"fundloanterm"]){
            if ([item.paramvalue doubleValue]>30) {
                [CDAutoHideMessageHUD showMessage:@"贷款年限最多30年"];
                return;
            }
            sourceItemfund.duetime=[item.paramvalue floatValue] * [item.paramunitvalue floatValue];
        }else if ([item.paramkey isEqualToString:@"fundloanrate"]) {
            sourceItemfund.rate=(sourceItemfund.duetime > 5) ? [self.mortgageCalculatorService.morefive floatValue] : [self.mortgageCalculatorService.lessfive floatValue];
        }else if ([item.paramkey isEqualToString:@"paytype"]){
            sourceItemfund.payType=[item.paramvalue floatValue];
            sourceItembusiness.payType=[item.paramvalue floatValue];
        }else if ([item.paramkey isEqualToString:@"businessloanmoney"]) {
            sourceItembusiness.capitalization=[item.paramvalue floatValue] * [item.paramunitvalue floatValue];
        }else if ([item.paramkey isEqualToString:@"businessloanterm"]){
            if ([item.paramvalue doubleValue]>30) {
                [CDAutoHideMessageHUD showMessage:@"贷款年限最多30年"];
                return;
            }
            sourceItembusiness.duetime=[item.paramvalue floatValue] * [item.paramunitvalue floatValue];
        }else if ([item.paramkey isEqualToString:@"businessloanrate"]) {
            sourceItembusiness.rate=[item.paramvalue floatValue];
        }
    }
    
    if (self.mortgageType==SCYMortgageTypeCombinedLoan) {
        sourceItemfund.rate=(sourceItemfund.duetime > 5) ? [self.mortgageCalculatorService.morefive floatValue] : [self.mortgageCalculatorService.lessfive floatValue];
    }
    
    switch (self.mortgageType) {
        case SCYMortgageTypeProvidentFundLoan:
            self.resultItem=[self p_resultWithCalculateSourceItem:sourceItemfund];
            break;
        case SCYMortgageTypeCommercialLoan:
            self.resultItem=[self p_resultWithCalculateSourceItem:sourceItembusiness];
            break;
        case SCYMortgageTypeCombinedLoan:{
            SCYMortgageCalculatorResultItem *resultItemFund = [self p_resultWithCalculateSourceItem:sourceItemfund];
            SCYMortgageCalculatorResultItem *resultItemBusiness = [self p_resultWithCalculateSourceItem:sourceItembusiness];
            
            self.resultItem = [[SCYMortgageCalculatorResultItem alloc]init];
            self.resultItem.capitalization=resultItemFund.capitalization+resultItemBusiness.capitalization;
            self.resultItem.duetime=resultItemFund.duetime>resultItemBusiness.duetime ? resultItemFund.duetime : resultItemBusiness.duetime;
            self.resultItem.totalInterest=resultItemFund.totalInterest+resultItemBusiness.totalInterest;
            self.resultItem.totalRepayment=resultItemFund.totalRepayment+resultItemBusiness.totalRepayment;
            self.resultItem.monthlyRepayment=resultItemFund.monthlyRepayment+resultItemBusiness.monthlyRepayment;
            self.resultItem.payType=resultItemFund.payType;
        }
            break;
        default:
            break;
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
}

/**
 *  贷款计算方法
 *
 *  @param sourceItem 源贷款信息
 */
- (SCYMortgageCalculatorResultItem *)p_resultWithCalculateSourceItem:(SCYMortgageCalculatorSourceItem *)sourceItem {
    CGFloat capitalization = sourceItem.capitalization;// * 10000
    CGFloat rateOfMonth = sourceItem.rate / 12 * 0.01;
    NSInteger months = sourceItem.duetime;//*12
    
    CGFloat monthlyRepayment = 0;
    CGFloat totalInterest = 0;
    CGFloat totalRepayment = 0;
    
    //等额本息
    if (sourceItem.payType == 0) {
        //月供
        monthlyRepayment = capitalization * rateOfMonth * pow((1 + rateOfMonth), months) / (pow((1 + rateOfMonth), months) - 1);
        totalRepayment = months * monthlyRepayment;
        totalInterest = totalRepayment - capitalization;
    } else {//等额本金
        //首月
        monthlyRepayment = capitalization / sourceItem.duetime + capitalization * rateOfMonth;
        totalInterest = (months + 1) * capitalization * rateOfMonth * 0.5;
        totalRepayment = totalInterest + capitalization;
    }
    SCYMortgageCalculatorResultItem *resultItem = [[SCYMortgageCalculatorResultItem alloc]init];
    resultItem.capitalization = capitalization;
    resultItem.duetime = months;
    resultItem.monthlyRepayment = monthlyRepayment;
    resultItem.totalInterest = totalInterest;
    resultItem.totalRepayment = totalRepayment;
    resultItem.payType=sourceItem.payType;
    return resultItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
