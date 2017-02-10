//
//  SCYAnnualBonusCalculateResultController.m
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusCalculateResultController.h"
#import "SCYAnnualBonusRulesCell.h"
#import "SCYAnnualBonusCalculateRulesItem.h"
#import "SCYAnnualBonusResultCell.h"
#import "SCYAnnualBonusCalculateResultItem.h"
#import "SCYAnnualBonusResultSectionHeaderView.h"

@interface SCYAnnualBonusCalculateResultController ()

@property (nonatomic, copy) NSArray *arrRules;
@property (nonatomic, strong) SCYAnnualBonusResultSectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) UIView *sectionFooterView;

@end

@implementation SCYAnnualBonusCalculateResultController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"年终奖计算器";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (NSArray *)arrRules{
    if (_arrRules==nil) {
        SCYAnnualBonusCalculateRulesItem *item0=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"税前/12" center:@"税率" right:@"速算扣除"];
        SCYAnnualBonusCalculateRulesItem *item1=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"不超过1500元(含)" center:@"3%" right:@"0"];
        SCYAnnualBonusCalculateRulesItem *item2=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"1500元-4500元(含)" center:@"10%" right:@"105"];
        SCYAnnualBonusCalculateRulesItem *item3=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"4500元-9000元(含)" center:@"20%" right:@"555"];
        SCYAnnualBonusCalculateRulesItem *item4=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"9000元-35000元(含)" center:@"25%" right:@"1005"];
        SCYAnnualBonusCalculateRulesItem *item5=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"35000元-55000元(含)" center:@"30%" right:@"2755"];
        SCYAnnualBonusCalculateRulesItem *item6=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"55000元-80000元(含)" center:@"35%" right:@"5505"];
        SCYAnnualBonusCalculateRulesItem *item7=[SCYAnnualBonusCalculateRulesItem itemWithLeft:@"超过80000元" center:@"45%" right:@"13505"];
        _arrRules=[[NSArray alloc]initWithObjects:item0,item1,item2,item3,item4,item5,item6,item7, nil];
    }
    return _arrRules;
}

- (SCYAnnualBonusResultSectionHeaderView *)sectionHeaderView{
    if (_sectionHeaderView==nil) {
        _sectionHeaderView=[[SCYAnnualBonusResultSectionHeaderView alloc]init];
        _sectionHeaderView.frame=CGRectMake(0, 0, self.tableView.width, 80);
    }
    return _sectionHeaderView;
}

- (UIView *)sectionFooterView{
    if (_sectionFooterView==nil) {
        _sectionFooterView=[[UIView alloc]init];
        _sectionFooterView.frame=CGRectMake(0, 0, self.tableView.width, 25);
        _sectionFooterView.backgroundColor=[UIColor whiteColor];
    }
    return _sectionFooterView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (section==0) ? self.arrData.count : self.arrRules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellidentifier = @"cellidentifier";
        SCYAnnualBonusResultCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!cell) {
            cell = [[SCYAnnualBonusResultCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
        }
        SCYAnnualBonusCalculateResultItem *item=[self.arrData cd_safeObjectAtIndex:indexPath.row];
        [cell setupWithBeforeTax:item.before.doubleValue afterTax:item.after.doubleValue type:self.bonusCalculateType showTips:(self.arrData.count!=1) indexPath:indexPath];
        return cell;
    }else{
        static NSString *ruleCellidentifier = @"ruleCellidentifier";
        SCYAnnualBonusRulesCell *cell=[tableView dequeueReusableCellWithIdentifier:ruleCellidentifier];
        if (!cell) {
            cell = [[SCYAnnualBonusRulesCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ruleCellidentifier];
        }
        SCYAnnualBonusCalculateRulesItem *item=[self.arrRules cd_safeObjectAtIndex:indexPath.row];
        UIColor *color=(indexPath.row%2==0) ? ColorFromHexRGB(0xfcfcfc) : [UIColor whiteColor];
        [cell setupLeftText:item.left centerText:item.center rightText:item.right backgroundColor:color];
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (indexPath.section==0) ? 188 : 33;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return self.sectionHeaderView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {
        return self.sectionFooterView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section==1) ? self.sectionHeaderView.height : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (section==0) ? 10 : self.sectionFooterView.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
