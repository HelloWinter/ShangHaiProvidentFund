//
//  CDProvidentFundDetailCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDProvidentFundDetailCell.h"
#import "CDAccountDetailItem.h"
#import "NSString+CDEncryption.h"
#import "CDDynamicdetailItem.h"

@interface CDProvidentFundDetailCell ()

@property (strong, nonatomic) UILabel *lbDate;
@property (strong, nonatomic) UILabel *lbCompany;
@property (strong, nonatomic) UILabel *lbMonthPay;


//@property (nonatomic, assign) CGFloat leftWidth;
//@property (nonatomic, assign) CGFloat centerWidth;
//@property (nonatomic, assign) CGFloat rightWidth;

@end

@implementation CDProvidentFundDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.lbDate];
        [self.contentView addSubview:self.lbCompany];
        [self.contentView addSubview:self.lbMonthPay];
    }
    return self;
}

- (UILabel *)lbDate{
    if(_lbDate == nil){
        _lbDate = [[UILabel alloc]init];
        _lbDate.font=[UIFont systemFontOfSize:13];
        _lbDate.textAlignment=NSTextAlignmentCenter;
        _lbDate.adjustsFontSizeToFitWidth=YES;
    }
    return _lbDate;
}

- (UILabel *)lbCompany{
    if(_lbCompany == nil){
        _lbCompany = [[UILabel alloc]init];
        _lbCompany.font=[UIFont systemFontOfSize:13];
        _lbCompany.textAlignment=NSTextAlignmentCenter;
        _lbCompany.adjustsFontSizeToFitWidth=YES;
    }
    return _lbCompany;
}

- (UILabel *)lbMonthPay{
    if(_lbMonthPay == nil){
        _lbMonthPay = [[UILabel alloc]init];
        _lbMonthPay.font=[UIFont systemFontOfSize:13];
        _lbMonthPay.textAlignment=NSTextAlignmentCenter;
        _lbMonthPay.adjustsFontSizeToFitWidth=YES;
    }
    return _lbMonthPay;
}

- (void)setupAccountDetailItem:(CDAccountDetailItem *)cellItem{
    NSString *strSubDate=cellItem.time;
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"年" withString:@""];
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"月" withString:@""];
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"日" withString:@""];
    NSString *strAmount=[self removeYUAN:cellItem.surplus_def_hp];
    [self setupLeftText:strSubDate centerText:(cellItem.summary ? : @"--") rightText:strAmount];
}

- (void)setupLoanDetailItem:(CDDynamicdetailItem *)cellItem{
    NSString *strDesc=cellItem.summary.length!=0 ? cellItem.summary : @"--";
    NSString *strAmount=[self removeYUAN:cellItem.corpushappen];
    NSString *strInterest=[self removeYUAN:cellItem.interesthappen];
    [self setupLeftText:strDesc centerText:strAmount rightText:strInterest];
}

- (void)setupLeftText:(NSString *)left centerText:(NSString *)center rightText:(NSString *)right{
    self.lbDate.text=left;
    self.lbCompany.text=center;
    self.lbMonthPay.text=right;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.lbDate.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbDate.layer setBorderWidth:0.5f];
    [self.lbCompany.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbCompany.layer setBorderWidth:0.5f];
    [self.lbMonthPay.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbMonthPay.layer setBorderWidth:0.5f];
    if (self.cellLayoutType==CDCellLayoutTypeAccountDetail) {
        self.lbDate.frame=CGRectMake(0, 0, 70, self.height);
        self.lbCompany.frame=CGRectMake(self.lbDate.right, 0, self.contentView.width-130, self.height);
        self.lbMonthPay.frame=CGRectMake(self.lbCompany.right, 0, 60, self.height);
    }else if (self.cellLayoutType==CDCellLayoutTypeLoanDetail){
        self.lbDate.frame=CGRectMake(0, 0, self.contentView.width-130, self.height);
        self.lbCompany.frame=CGRectMake(self.lbDate.right, 0, 70, self.height);
        self.lbMonthPay.frame=CGRectMake(self.lbCompany.right, 0, 60, self.height);
    }
}

- (NSString *)removeYUAN:(NSString *)strAmount{
    if ([strAmount hasSuffix:@"元"]) {
        NSRange range=[strAmount rangeOfString:@"元"];
        strAmount=[strAmount substringToIndex:range.location];
    }
    return strAmount;
}

@end
