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
        [self.contentView addSubview:({
            _lbDate = [[UILabel alloc]init];
            _lbDate.font=[UIFont systemFontOfSize:13];
            _lbDate.textAlignment=NSTextAlignmentCenter;
            _lbDate.adjustsFontSizeToFitWidth=YES;
            _lbDate;
        })];
        [self.contentView addSubview:({
            _lbCompany = [[UILabel alloc]init];
            _lbCompany.font=[UIFont systemFontOfSize:13];
            _lbCompany.textAlignment=NSTextAlignmentCenter;
            _lbCompany.numberOfLines=0;
            _lbCompany.lineBreakMode=NSLineBreakByWordWrapping;
            _lbCompany;
        })];
        [self.contentView addSubview:({
            _lbMonthPay = [[UILabel alloc]init];
            _lbMonthPay.font=[UIFont systemFontOfSize:13];
            _lbMonthPay.textAlignment=NSTextAlignmentCenter;
            _lbMonthPay.adjustsFontSizeToFitWidth=YES;
            _lbMonthPay;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_lbDate.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [_lbDate.layer setBorderWidth:0.5f];
    [_lbCompany.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [_lbCompany.layer setBorderWidth:0.5f];
    [_lbMonthPay.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [_lbMonthPay.layer setBorderWidth:0.5f];
    
    CGFloat minWidth=self.width*0.25;
    
    if ([CDUIUtil currentScreenType]==CurrentDeviceScreenType_3_5 || [CDUIUtil currentScreenType]==CurrentDeviceScreenType_4_0) {
        minWidth=75;
    }
    if ([CDUIUtil currentScreenType]==CurrentDeviceScreenType_iPad) {
        minWidth=self.width*0.3;
    }
    if (self.cellLayoutType==CDCellLayoutTypeAccountDetail) {
        _lbDate.frame=CGRectMake(0, 0, minWidth, self.height);
        _lbCompany.frame=CGRectMake(_lbDate.right, 0, self.contentView.width-minWidth*2, self.height);
        _lbMonthPay.frame=CGRectMake(_lbCompany.right, 0, minWidth, self.height);
    }else if (self.cellLayoutType==CDCellLayoutTypeLoanDetail){
        _lbDate.frame=CGRectMake(0, 0, self.contentView.width-minWidth*2, self.height);
        _lbCompany.frame=CGRectMake(_lbDate.right, 0, minWidth, self.height);
        _lbMonthPay.frame=CGRectMake(_lbCompany.right, 0, minWidth, self.height);
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
    _lbDate.text=left;
    _lbCompany.text=center;
    _lbMonthPay.text=right;
}

- (NSString *)p_removeYUAN:(NSString *)strAmount{
    if ([strAmount hasSuffix:@"元"]) {
        NSRange range=[strAmount rangeOfString:@"元"];
        strAmount=[strAmount substringToIndex:range.location];
    }
    return strAmount;
}

@end
