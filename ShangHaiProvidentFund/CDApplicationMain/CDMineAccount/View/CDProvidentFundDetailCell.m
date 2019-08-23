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
        _lbCompany.numberOfLines=0;
        _lbCompany.lineBreakMode=NSLineBreakByWordWrapping;
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

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.lbDate.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbDate.layer setBorderWidth:0.5f];
    [self.lbCompany.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbCompany.layer setBorderWidth:0.5f];
    [self.lbMonthPay.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbMonthPay.layer setBorderWidth:0.5f];
    
    CGFloat minWidth=self.width*0.25;
    
    if ([CDUIUtil currentScreenType]==CurrentDeviceScreenType_3_5 || [CDUIUtil currentScreenType]==CurrentDeviceScreenType_4_0) {
        minWidth=75;
    }
    if ([CDUIUtil currentScreenType]==CurrentDeviceScreenType_iPad) {
        minWidth=self.width*0.3;
    }
    if (self.cellLayoutType==CDCellLayoutTypeAccountDetail) {
        self.lbDate.frame=CGRectMake(0, 0, minWidth, self.height);
        self.lbCompany.frame=CGRectMake(self.lbDate.right, 0, self.contentView.width-minWidth*2, self.height);
        self.lbMonthPay.frame=CGRectMake(self.lbCompany.right, 0, minWidth, self.height);
    }else if (self.cellLayoutType==CDCellLayoutTypeLoanDetail){
        self.lbDate.frame=CGRectMake(0, 0, self.contentView.width-minWidth*2, self.height);
        self.lbCompany.frame=CGRectMake(self.lbDate.right, 0, minWidth, self.height);
        self.lbMonthPay.frame=CGRectMake(self.lbCompany.right, 0, minWidth, self.height);
    }
}

#pragma mark - public
- (void)setupAccountDetailItem:(CDAccountDetailItem *)cellItem{
    NSString *strSubDate=cellItem.time;
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"年" withString:@""];
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"月" withString:@""];
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"日" withString:@""];
    NSString *strAmount=[self p_removeYUAN:cellItem.surplus_def_hp];
    [self p_setupLeftText:strSubDate centerText:(cellItem.summary ? : @"--") rightText:strAmount];
}

- (void)setupLoanDetailItem:(CDDynamicdetailItem *)cellItem{
    NSString *strDesc=cellItem.summary.length!=0 ? cellItem.summary : @"--";
    NSString *strAmount=[self p_removeYUAN:cellItem.corpushappen];
    NSString *strInterest=[self p_removeYUAN:cellItem.interesthappen];
    [self p_setupLeftText:strDesc centerText:strAmount rightText:strInterest];
}

#pragma mark - private
- (void)p_setupLeftText:(NSString *)left centerText:(NSString *)center rightText:(NSString *)right{
    self.lbDate.text=left;
    self.lbCompany.text=center;
    self.lbMonthPay.text=right;
}

- (NSString *)p_removeYUAN:(NSString *)strAmount{
    if ([strAmount hasSuffix:@"元"]) {
        NSRange range=[strAmount rangeOfString:@"元"];
        strAmount=[strAmount substringToIndex:range.location];
    }
    return strAmount;
}

@end
