//
//  SCYGuideMeasurementController.m
//  ProvidentFund
//
//  Created by cdd on 15/12/23.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "SCYMeasurementResultController.h"
#import "CDBaseTableViewCell.h"
#import "CDBaseWKWebViewController.h"
//#import "SCYGeneralLoanMeasurementController.h"
//#import "SCYGeneralExtractMeasurementController.h"
#import "CDMeasurementGuideModel.h"
#import "SCYLinkItem.h"


@interface SCYMeasurementResultController ()

@property (nonatomic, strong) CDMeasurementGuideModel *measurementGuideModel;

@end

@implementation SCYMeasurementResultController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.showDragView=NO;
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.guideMeasurementType==SCYGuideMeasurementTypeExtract) {
        self.title=@"提取指南";
    }else if (self.guideMeasurementType==SCYGuideMeasurementTypeLoan){
        self.title=@"贷款指南";
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (CDMeasurementGuideModel *)measurementGuideModel{
    if (_measurementGuideModel==nil) {
        _measurementGuideModel=[[CDMeasurementGuideModel alloc]initWithGuideType:self.guideMeasurementType];
    }
    return _measurementGuideModel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.measurementGuideModel.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    CDBaseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDBaseTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    SCYLinkItem *item=[self.measurementGuideModel.arrData cd_safeObjectAtIndex:indexPath.row];
    cell.textLabel.text=item.lname;
    return cell;
    
//    return [[UITableViewCell alloc]init];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SCYLinkItem *item=[self.measurementGuideModel.arrData cd_safeObjectAtIndex:indexPath.row];
    if (item.llink.length!=0) {
        [self pushToWebViewControllerWithTitle:item.lname URLString:item.llink];
    }else{
        
    }
    
}

#pragma mark - Events


- (void)reMeasurement:(UIButton *)sender{
    if (self.guideMeasurementType==SCYGuideMeasurementTypeLoan) {
//        [self pushToGeneralLoanMeasurementVC];
    }else if (self.guideMeasurementType==SCYGuideMeasurementTypeExtract){
//        [self pushToGeneralExtractMeasurement];
    }
}

- (void)pushToWebViewControllerWithTitle:(NSString *)title URLString:(NSString *)strURL{
    if (strURL==nil || strURL.length==0) {
        return;
    }
    NSURL *url = [NSURL URLWithString:strURL];
    CDBaseWKWebViewController *normalWebController = [CDBaseWKWebViewController webViewWithURL:url];
    normalWebController.title = title;
    [self.navigationController pushViewController:normalWebController animated:YES];
}

/**
 *  通用贷款测算
 */
//- (void)pushToGeneralLoanMeasurementVC{
//    SCYGeneralLoanMeasurementController *loanGuideVC=[[SCYGeneralLoanMeasurementController alloc]initWithTableViewStyle:(UITableViewStyleGrouped)];
//    loanGuideVC.paramDict=[[NSMutableDictionary alloc]init];
//    loanGuideVC.loanMeasurementStep=SCYGeneralLoanMeasurementStepOwnerInfo;
//    [self.navigationController pushViewController:loanGuideVC animated:YES];
//}

/**
 *  通用提取测算
 */
//- (void)pushToGeneralExtractMeasurement{
//    SCYGeneralExtractMeasurementController *extractMeasurementController=[[SCYGeneralExtractMeasurementController alloc]initWithTableViewStyle:(UITableViewStyleGrouped)];
//    extractMeasurementController.cityCode=SCYCityCode();
//    extractMeasurementController.strBalance=self.strBalance;
//    [self.navigationController pushViewController:extractMeasurementController animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
