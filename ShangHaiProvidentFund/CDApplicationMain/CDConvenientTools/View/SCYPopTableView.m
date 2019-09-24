//
//  SCYPopTableView.m
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYPopTableView.h"
#import "SCYPopTableViewCell.h"
#import "SCYLoanRateItem.h"
#import "SCYMortgageCalculatorCellItem.h"
#import "UITableView+CDTableViewAddition.h"

static const NSTimeInterval kAnimationDuration = 0.25;
static const CGSize kSize = {290,658*0.5};

@interface SCYPopTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) SCYMortgageCalculatorCellItem *cellItem;

@property (nonatomic, copy) NSArray *arrData;

@end

@implementation SCYPopTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height)];
    if (self) {
        self.layer.cornerRadius=5;
        self.layer.masksToBounds=YES;
        [self addSubview:self.tableview];
        [self addSubview:self.lbTitle];
        [self addSubview:self.btnClose];
    }
    return self;
}

- (UILabel *)lbTitle{
    if (_lbTitle==nil) {
        _lbTitle=[[UILabel alloc]init];
        _lbTitle.textAlignment=NSTextAlignmentCenter;
        _lbTitle.textColor=NAVIGATION_COLOR;
        UIColor *bgColor = ColorFromHexRGB(0xf5f5f5);
        if (@available(iOS 13.0, *)) {
            bgColor = [UIColor systemBackgroundColor];
        }
        _lbTitle.backgroundColor=bgColor;
    }
    return _lbTitle;
}

- (UIButton *)btnClose{
    if (_btnClose==nil) {
        _btnClose=[[UIButton alloc]init];
        [_btnClose setTitle:@"✕" forState:(UIControlStateNormal)];
        [_btnClose setTitleColor:NAVIGATION_COLOR forState:(UIControlStateNormal)];
        _btnClose.titleLabel.font=[UIFont systemFontOfSize:20];
        [_btnClose addTarget:self action:@selector(closeView:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btnClose;
}

- (UITableView *)tableview{
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]init];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundView = nil;
        if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableview setSeparatorInset:UIEdgeInsetsZero];
        }
        [_tableview cd_clearNeedlessCellLine];
    }
    return _tableview;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat titleHeight=50;
    self.lbTitle.frame=CGRectMake(0, 0, self.width, titleHeight);
    self.btnClose.frame=CGRectMake(self.width-titleHeight, 0, titleHeight, titleHeight);
    self.tableview.frame=CGRectMake(0, titleHeight, self.width, self.height-titleHeight);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cellidentifier";
    SCYPopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[SCYPopTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellidentifier];
    }
    SCYLoanRateItem *item=[self.arrData cd_safeObjectAtIndex:indexPath.row];
    [cell setupCellItem:item indexPath:indexPath];
    if ([item.rate isEqualToString:self.cellItem.paramvalue]) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SCYLoanRateItem *item=[self.arrData cd_safeObjectAtIndex:indexPath.row];
    self.cellItem.paramvalue=item.rate;
    if (self.cellTouched) {
        self.cellTouched(indexPath.row,self.cellItem);
    }
    [self dismiss:YES];
}

#pragma mark - public
- (void)show:(BOOL)animated {
    if (self.superview) {
        return;
    }
    UIWindow *window = CDKeyWindow;
    self.centerX = window.width * 0.5;
    self.top = window.bottom;

    [window cd_showView:self backViewAlpha:0.5 target:nil touchAction:nil animation:^{
        self.center = CGPointMake(window.width * 0.5, (window.height) * 0.5);
    } timeInterval:(animated ? kAnimationDuration : 0) finished:^(BOOL finished) {
        
    }];
}

- (void)dismiss:(BOOL)animated {
    if (!self.superview) {
        return;
    }
    [self.superview cd_hideView:self animation:^{
        self.top = self.superview.bottom;
    } timeInterval:(animated ? kAnimationDuration : 0) fininshed:^(BOOL complation) {
        
    }];
}

- (void)setupViewData:(SCYMortgageCalculatorCellItem *)item popType:(SCYPopTableViewType)type indexPath:(NSIndexPath *)path{
    if (type==SCYPopTableViewTypePayType) {
        self.lbTitle.text=@"还款方式";
    }else if (type==SCYPopTableViewTypeSelectRate){
        self.lbTitle.text=@"利率选择";
    }
    self.cellItem=item;
    self.arrData=item.paramsubitemsdata;
    [self.tableview reloadData];
}

#pragma mark - private
- (void)closeView:(UIButton *)sender{
    [self dismiss:YES];
}

@end
