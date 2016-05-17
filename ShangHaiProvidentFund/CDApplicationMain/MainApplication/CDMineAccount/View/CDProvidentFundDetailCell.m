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

@interface CDProvidentFundDetailCell ()

@property (strong, nonatomic) UILabel *lbDate;
@property (strong, nonatomic) UILabel *lbCompany;
@property (strong, nonatomic) UILabel *lbMonthPay;

@property (nonatomic, assign) CGFloat leftWidth;
@property (nonatomic, assign) CGFloat centerWidth;
@property (nonatomic, assign) CGFloat rightWidth;

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

- (void)setupLeftWidth:(CGFloat)left centerWidth:(CGFloat)center rightWidth:(CGFloat)right{
    CGFloat width=left+center+right;
    self.leftWidth=left/width*self.contentView.width;
    self.centerWidth=center/width*self.contentView.width;
    self.rightWidth=self.contentView.width-self.leftWidth-self.rightWidth;
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

- (void)setCellItem:(CDAccountDetailItem *)item{
    NSString *strSubDate=item.time;
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"年" withString:@""];
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"月" withString:@""];
    strSubDate = [strSubDate stringByReplacingOccurrencesOfString:@"日" withString:@""];
    self.lbDate.text=strSubDate;
    self.lbCompany.text=item.summary ? : @"";
    NSString *strAmount=item.surplus_def_hp;
    if ([strAmount hasSuffix:@"元"]) {
        NSRange range=[strAmount rangeOfString:@"元"];
        strAmount=[strAmount substringToIndex:range.location];
    }
    self.lbMonthPay.text=strAmount;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.lbDate.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbDate.layer setBorderWidth:0.5f];
    [self.lbCompany.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbCompany.layer setBorderWidth:0.5f];
    [self.lbMonthPay.layer setBorderColor:ColorFromHexRGB(0xe0e0e0).CGColor];
    [self.lbMonthPay.layer setBorderWidth:0.5f];
    
    self.lbDate.frame=CGRectMake(0, 0, self.leftWidth, self.height);
    self.lbCompany.frame=CGRectMake(self.lbDate.right, 0, self.centerWidth, self.height);
    self.lbMonthPay.frame=CGRectMake(self.lbCompany.right, 0, self.rightWidth, self.height);
}

@end
