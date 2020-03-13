//
//  CDProvidentFundDetailHeaderView.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDProvidentFundDetailHeaderView.h"
#import "CDAccountInfoItem.h"
#import "CDPayAccountItem.h"

static const CGFloat kTextLabelSize = 13;

@interface CDProvidentFundDetailHeaderView ()

@property (strong, nonatomic) UILabel *lbAccount;
@property (strong, nonatomic) UILabel *lbAccountNum;
@property (strong, nonatomic) UILabel *lbMonthPay;
@property (strong, nonatomic) UILabel *lbAccountState;

@end

@implementation CDProvidentFundDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=NAVIGATION_COLOR;
        [self addSubview:({
            _lbAccount=[[UILabel alloc]init];
            _lbAccount.textColor=[UIColor whiteColor];
            _lbAccount.font=[UIFont boldSystemFontOfSize:20];
            _lbAccount.adjustsFontSizeToFitWidth=YES;
            _lbAccount;
        })];
        [self addSubview:({
            _lbAccountState=[[UILabel alloc]init];
            _lbAccountState.textColor=[UIColor whiteColor];
            _lbAccountState.font=[UIFont systemFontOfSize:kTextLabelSize];
            _lbAccountState;
        })];
        [self addSubview:({
            _lbMonthPay=[[UILabel alloc]init];
            _lbMonthPay.textColor=[UIColor whiteColor];
            _lbMonthPay.font=[UIFont systemFontOfSize:kTextLabelSize];
            _lbMonthPay;
        })];
        [self addSubview:({
            _lbAccountNum=[[UILabel alloc]init];
            _lbAccountNum.textColor=[UIColor whiteColor];
            _lbAccountNum.font=[UIFont systemFontOfSize:kTextLabelSize];
            _lbAccountNum;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _lbAccount.frame=CGRectMake(LEFT_RIGHT_MARGIN, 10, self.width-LEFT_RIGHT_MARGIN*2, 24);
    _lbAccountState.frame=CGRectMake(LEFT_RIGHT_MARGIN, _lbAccount.bottom+CELL_MARGIN, self.width-LEFT_RIGHT_MARGIN*2, 20);
    _lbMonthPay.frame=CGRectMake(LEFT_RIGHT_MARGIN, _lbAccountState.bottom+CELL_MARGIN, self.width-LEFT_RIGHT_MARGIN*2, 20);
    _lbAccountNum.frame=CGRectMake(LEFT_RIGHT_MARGIN, _lbMonthPay.bottom+CELL_MARGIN, self.width-LEFT_RIGHT_MARGIN*2, 20);
}

#pragma mark - public
- (void)setupAccountInfo:(CDAccountInfoItem *)item{
    _lbAccount.text=item.name ? : @"--";
    _lbAccountState.text=[NSString stringWithFormat:@"账户状态:%@   账号:%@",item.state ? : @"--",item.pri_account ? : @"--"];
    _lbMonthPay.text=[NSString stringWithFormat:@"账户余额:%@     月缴纳:%@",(item.surplus_def ? : @"--"),(item.month_pay ? : @"--")];
    _lbAccountNum.text=[NSString stringWithFormat:@"缴纳单位:%@",item.unit_name ? : @"--"];
}

- (void)setupLoanInfo:(CDPayAccountItem *)item{
    _lbAccount.text=[NSString stringWithFormat:@"贷款账户:%@",item.debtaccount ? : @"--"];
    _lbAccountState.text=[NSString stringWithFormat:@"状态:%@   还款方式:%@",item.state ? : @"--",item.returnwaycode ? : @"--"];
    _lbMonthPay.text=[NSString stringWithFormat:@"贷款开户日期:%@   期限:%@月",(item.opendate ? : @"--"),(item.limit ? : @"--")];
    _lbAccountNum.text=[NSString stringWithFormat:@"贷款总额:%@   贷款余额:%@",item.amount ? : @"--",item.surplus ? : @"--"];
}

@end
