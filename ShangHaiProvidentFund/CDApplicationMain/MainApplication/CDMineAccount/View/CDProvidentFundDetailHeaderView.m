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

- (instancetype)init{
    self =[super init];
    if (self) {
        self.backgroundColor=ColorFromHexRGB(0x01b2d3);
        [self addSubview:self.lbAccount];
        [self addSubview:self.lbAccountState];
        [self addSubview:self.lbMonthPay];
        [self addSubview:self.lbAccountNum];
    }
    return self;
}

- (UILabel *)lbAccount{
    if (_lbAccount==nil) {
        _lbAccount=[[UILabel alloc]init];
        _lbAccount.textColor=[UIColor whiteColor];
        _lbAccount.font=[UIFont boldSystemFontOfSize:20];
        _lbAccount.adjustsFontSizeToFitWidth=YES;
    }
    return _lbAccount;
}

- (UILabel *)lbAccountNum{
    if (_lbAccountNum==nil) {
        _lbAccountNum=[[UILabel alloc]init];
        _lbAccountNum.textColor=[UIColor whiteColor];
        _lbAccountNum.font=[UIFont systemFontOfSize:kTextLabelSize];
    }
    return _lbAccountNum;
}

- (UILabel *)lbAccountState{
    if (_lbAccountState==nil) {
        _lbAccountState=[[UILabel alloc]init];
        _lbAccountState.textColor=[UIColor whiteColor];
        _lbAccountState.font=[UIFont systemFontOfSize:kTextLabelSize];
    }
    return _lbAccountState;
}

- (UILabel *)lbMonthPay{
    if (_lbMonthPay==nil) {
        _lbMonthPay=[[UILabel alloc]init];
        _lbMonthPay.textColor=[UIColor whiteColor];
        _lbMonthPay.font=[UIFont systemFontOfSize:kTextLabelSize];
    }
    return _lbMonthPay;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lbAccount.frame=CGRectMake(LEFT_RIGHT_MARGIN, 10, self.width-LEFT_RIGHT_MARGIN*2, 24);
    self.lbAccountState.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.lbAccount.bottom+CELL_MARGIN, self.width-LEFT_RIGHT_MARGIN*2, 20);
    self.lbMonthPay.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.lbAccountState.bottom+CELL_MARGIN, self.width-LEFT_RIGHT_MARGIN*2, 20);
    self.lbAccountNum.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.lbMonthPay.bottom+CELL_MARGIN, self.width-LEFT_RIGHT_MARGIN*2, 20);
}

- (void)setupAccountInfo:(CDAccountInfoItem *)item{
    self.lbAccount.text=item.name ? : @"--";
    self.lbAccountState.text=[NSString stringWithFormat:@"账户状态:%@   账号:%@",item.state ? : @"--",item.pri_account ? : @"--"];
    self.lbMonthPay.text=[NSString stringWithFormat:@"账户余额:%@     月缴纳:%@",(item.surplus_def ? : @"--"),(item.month_pay ? : @"--")];
    self.lbAccountNum.text=[NSString stringWithFormat:@"缴纳单位:%@",item.unit_name ? : @"--"];
}

- (void)setupLoanInfo:(CDPayAccountItem *)item{
    self.lbAccount.text=[NSString stringWithFormat:@"贷款账户:%@",item.debtaccount ? : @"--"];
    self.lbAccountState.text=[NSString stringWithFormat:@"状态:%@   还款方式:%@",item.state ? : @"--",item.returnwaycode ? : @"--"];
    self.lbMonthPay.text=[NSString stringWithFormat:@"贷款开户日期:%@   期限:%@月",(item.opendate ? : @"--"),(item.limit ? : @"--")];
    self.lbAccountNum.text=[NSString stringWithFormat:@"贷款总额:%@   贷款余额:%@",item.amount ? : @"--",item.surplus ? : @"--"];
}

@end
