//
//  SCYMortgageCalculatorResultCell.m
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYMortgageCalculatorResultCell.h"

@interface SCYMortgageCalculatorResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *lbPayAllMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbPayMonthNum;
@property (weak, nonatomic) IBOutlet UILabel *lbInterest;
@property (weak, nonatomic) IBOutlet UILabel *lbMonthPay;

@end

@implementation SCYMortgageCalculatorResultCell

+ (instancetype)resultCell{
    SCYMortgageCalculatorResultCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"SCYMortgageCalculatorResultCell" owner:nil options:nil]lastObject];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - public
- (void)setupPayAllMoney:(CGFloat)allMoney monthNumber:(NSInteger)monthNum interest:(CGFloat)interest monthPay:(CGFloat)monthPay payType:(CGFloat)paytype{
    NSString *totalRepayment=[NSString stringWithFormat:@"还款总额：%.2f元",allMoney];
    NSString *duetime=[NSString stringWithFormat:@"还款月数：%ld月",(long)monthNum];
    NSString *totalInterest=[NSString stringWithFormat:@"支付利息：%.2f元",interest];
    
    NSDictionary *attrDict=@{NSForegroundColorAttributeName:ColorFromHexRGB(0x212121)};
    
    NSMutableAttributedString *astrtotalRepayment=[[NSMutableAttributedString alloc]initWithString:totalRepayment];
    [astrtotalRepayment addAttributes:attrDict range:[totalRepayment rangeOfString:@"还款总额："]];
    NSMutableAttributedString *astrduetime=[[NSMutableAttributedString alloc]initWithString:duetime];
    [astrduetime addAttributes:attrDict range:[duetime rangeOfString:@"还款月数："]];
    NSMutableAttributedString *astrtotalInterest=[[NSMutableAttributedString alloc]initWithString:totalInterest];
    [astrtotalInterest addAttributes:attrDict range:[totalInterest rangeOfString:@"支付利息："]];
    
    self.lbPayAllMoney.attributedText=astrtotalRepayment;
    self.lbPayMonthNum.attributedText=astrduetime;
    self.lbInterest.attributedText=astrtotalInterest;
    
    if (paytype==0) {
        NSString *monthlyRepayment=[NSString stringWithFormat:@"月均还款：%.2f元",monthPay];
        
        NSMutableAttributedString *astrmonthlyRepayment=[[NSMutableAttributedString alloc]initWithString:monthlyRepayment];
        [astrmonthlyRepayment addAttributes:attrDict range:[monthlyRepayment rangeOfString:@"月均还款："]];
        self.lbMonthPay.attributedText=astrmonthlyRepayment;
    }else{
        NSString *monthlyRepayment=[NSString stringWithFormat:@"首月还款：%.2f元",monthPay];
        
        NSMutableAttributedString *astrmonthlyRepayment=[[NSMutableAttributedString alloc]initWithString:monthlyRepayment];
        [astrmonthlyRepayment addAttributes:attrDict range:[monthlyRepayment rangeOfString:@"首月还款："]];
        self.lbMonthPay.attributedText=astrmonthlyRepayment;
    }
}

@end
