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

@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UILabel *lbCompany;
@property (weak, nonatomic) IBOutlet UILabel *lbMonthPay;

@end

@implementation CDProvidentFundDetailCell

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
}

@end
