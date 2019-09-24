//
//  SCYAnnualBonusCalculatorController.m
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusCalculatorController.h"
#import "SCYButtonTableFooterView.h"
#import "SCYAnnualBonusCalculatorCell.h"
#import "SCYAnnualBonusCalculateResultController.h"
#import "SCYAnnualBonusCalculateTool.h"
#import "SCYAnnualBonusCalculateResultItem.h"



static const CGFloat topHeight=50;

@interface SCYAnnualBonusCalculatorController ()

@property (nonatomic, assign) SCYAnnualBonusCalculateType annualBonusCalculateType;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) SCYButtonTableFooterView *tableFooterView;

@end

@implementation SCYAnnualBonusCalculatorController

- (instancetype)init{
    self =[super init];
    if (self) {
        self.tableViewStyle=UITableViewStyleGrouped;
        self.title=@"年终奖计算器";
        self.showDragView=NO;
        self.hidesBottomBarWhenPushed=YES;
        self.hideKeyboradWhenTouch=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    self.tableView.rowHeight=44;
    self.tableView.frame=CGRectMake(0, topHeight, self.view.width, self.view.height-topHeight-64);
    self.tableView.tableFooterView=self.tableFooterView;
}

- (UIView*)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, topHeight)];
        UIColor *bgColor = [UIColor whiteColor];
        if (@available(iOS 13.0, *)) {
            bgColor = [UIColor systemBackgroundColor];
        }
        _headerView.backgroundColor = bgColor;
        UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"计算税后",@"反推税前", nil]];
        segmentControl.bounds=CGRectMake(0, 0, self.view.width-20, 30);
        segmentControl.center=CGPointMake(_headerView.width*0.5, _headerView.height*0.5);
        [segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        segmentControl.selectedSegmentIndex = 0;
        segmentControl.tintColor = NAVIGATION_COLOR;
        [_headerView addSubview:segmentControl];
    }
    return _headerView;
}

- (SCYButtonTableFooterView *)tableFooterView{
    if (_tableFooterView==nil) {
        _tableFooterView = [[SCYButtonTableFooterView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 80)];
        [_tableFooterView setupBtnTitle:@"开始计算"];
        __weak typeof(self) weakSelf=self;
        _tableFooterView.buttonClickBlock=^(UIButton *sender){
            [weakSelf p_startCalculate];
        };
    }
    return _tableFooterView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    SCYAnnualBonusCalculatorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (nil == cell) {
        cell = [[SCYAnnualBonusCalculatorCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
    }
    NSString *leftText=(self.annualBonusCalculateType==SCYAnnualBonusCalculateType1) ? @"请输入税前年终奖" : @"请输入税后年终奖";
    [cell setupLeftText:leftText indexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ACTION
- (void)segmentAction:(UISegmentedControl*)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.annualBonusCalculateType=SCYAnnualBonusCalculateType1;
            break;
        case 1:
            self.annualBonusCalculateType=SCYAnnualBonusCalculateType2;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - private
- (void)p_startCalculate{
    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:0];
    SCYAnnualBonusCalculatorCell *cell=[self.tableView cellForRowAtIndexPath:path];
    NSString *cellT = [cell cellText];
    
    SCYAnnualBonusCalculateResultController *controller=[[SCYAnnualBonusCalculateResultController alloc]init];
    controller.bonusCalculateType=self.annualBonusCalculateType;
    
    switch (self.annualBonusCalculateType) {
        case SCYAnnualBonusCalculateType1:
            controller.arrData=[self p_getAfterTaxBonusWithBeforeBonus:cellT.doubleValue];
            break;
        case SCYAnnualBonusCalculateType2:
            controller.arrData=[self p_getBeforeBonusWithAfterTaxBonus:cellT.doubleValue];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

/**
 *  计算税后结果,税后=税前-税前*税率+速算扣除
 *
 *  @param before 税前年终奖
 *
 *  @return 税后年终奖所得
 */
- (NSArray *)p_getAfterTaxBonusWithBeforeBonus:(double)before{
    double rate=0.00;
    double addition=0.00;
    double singleMonth=before/12.00;
    if (singleMonth<=1500.00) {
        rate=0.03;
        addition=0.00;
    }else if (singleMonth>1500.00 && singleMonth<=4500.00){
        rate=0.1;
        addition=105.00;
    }else if (singleMonth>4500.00 && singleMonth<=9000.00){
        rate=0.2;
        addition=555.00;
    }else if (singleMonth>9000.00 && singleMonth<=35000.00){
        rate=0.25;
        addition=1005.00;
    }else if (singleMonth>35000.00 && singleMonth<=55000.00){
        rate=0.30;
        addition=2755.00;
    }else if (singleMonth>55000.00 && singleMonth<=80000.00){
        rate=0.35;
        addition=5505.00;
    }else if (singleMonth>80000.00){
        rate=0.45;
        addition=13505.00;
    }
    double after = before*(1.0-rate)+addition;
    SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
    return [NSArray arrayWithObject:item];
}

/**
 *  反推税前年终奖,可能有两种结果
 *
 *  @param after 税后年终奖
 *
 *  @return 税前年终奖
 */
- (NSMutableArray *)p_getBeforeBonusWithAfterTaxBonus:(double)after{
    NSMutableArray *arr=[NSMutableArray array];
    if (after<=16305.00) {
        double before=(after-0)/(1.0-0.03);
        SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item];
        
    }else if (after>16305.00 && after<=17460.00){
        double before0=(after-0)/(1.0-0.03);
        SCYAnnualBonusCalculateResultItem *item0=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before0] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item0];
        
        double before1=(after-105.00)/(1.0-0.1);
        SCYAnnualBonusCalculateResultItem *item1=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before1] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item1];
        
    }else if (after>17460.00 && after<=43755.00){
        double before=(after-105.00)/(1.0-0.1);
        SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item];

    }else if (after>43755.00 && after<=48705.00){
        double before0=(after-105.00)/(1.0-0.1);
        SCYAnnualBonusCalculateResultItem *item0=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before0] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item0];
        
        double before1=(after-555.00)/(1.0-0.2);
        SCYAnnualBonusCalculateResultItem *item1=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before1] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item1];
        
    }else if (after>48705.00 && after<=82005.00){
        double before=(after-555.00)/(1.0-0.2);
        SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item];

    }else if (after>82005.00 && after<=86955.00){
        double before0=(after-555.00)/(1.0-0.2);
        SCYAnnualBonusCalculateResultItem *item0=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before0] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item0];
        
        double before1=(after-1005.00)/(1.0-0.25);
        SCYAnnualBonusCalculateResultItem *item1=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before1] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item1];
        
    }else if (after>86955.00 && after<=296755.00){
        double before=(after-1005.00)/(1.0-0.25);
        SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item];

    }else if (after>296755.00 && after<=316005.00){
        double before0=(after-1005.00)/(1.0-0.25);
        SCYAnnualBonusCalculateResultItem *item0=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before0] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item0];
        
        double before1=(after-2775.00)/(1.0-0.3);
        SCYAnnualBonusCalculateResultItem *item1=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before1] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item1];
        
    }else if (after>316005.00 && after<=434505.00){
        double before=(after-2775.00)/(1.0-0.3);
        SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item];

    }else if (after>434505.00 && after<=464755.00){
        double before0=(after-2775.00)/(1.0-0.3);
        SCYAnnualBonusCalculateResultItem *item0=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before0] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item0];
        
        double before1=(after-5505.00)/(1.0-0.35);
        SCYAnnualBonusCalculateResultItem *item1=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before1] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item1];
        
    }else if (after>464755.00 && after<=541505.00){
        double before=(after-5505.00)/(1.0-0.35);
        SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item];

    }else if (after>541505.00 && after<=629505.00){
        double before0=(after-5505.00)/(1.0-0.35);
        SCYAnnualBonusCalculateResultItem *item0=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before0] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item0];
        
        double before1=(after-13505.00)/(1.0-0.45);
        SCYAnnualBonusCalculateResultItem *item1=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before1] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item1];
        
    }else if (after>629505.00){
        double before=(after-13505.00)/(1.0-0.45);
        SCYAnnualBonusCalculateResultItem *item=[SCYAnnualBonusCalculateResultItem itemWithBefore:[NSNumber numberWithDouble:before] after:[NSNumber numberWithDouble:after]];
        [arr addObject:item];

    }
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
