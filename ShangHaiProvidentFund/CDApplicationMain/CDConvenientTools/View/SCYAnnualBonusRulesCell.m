//
//  SCYAnnualBonusRulesCell.m
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusRulesCell.h"

@interface SCYAnnualBonusRulesCell ()

@property (nonatomic, strong) UILabel *lbLeft;
@property (nonatomic, strong) UILabel *lbCenter;
@property (nonatomic, strong) UILabel *lbRight;

@end

@implementation SCYAnnualBonusRulesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.lbLeft];
        [self.contentView addSubview:self.lbCenter];
        [self.contentView addSubview:self.lbRight];
    }
    return self;
}

- (UILabel *)lbLeft{
    if (_lbLeft==nil) {
        _lbLeft=[[UILabel alloc]init];
        _lbLeft.textAlignment=NSTextAlignmentCenter;
        _lbLeft.textColor=ColorFromHexRGB(0x2c2c2c);
        _lbLeft.font=[UIFont systemFontOfSize:13];
        _lbLeft.layer.borderColor=ColorFromHexRGB(0xe0e0e0).CGColor;
        _lbLeft.layer.borderWidth=0.5;
    }
    return _lbLeft;
}

- (UILabel *)lbCenter{
    if (_lbCenter==nil) {
        _lbCenter=[[UILabel alloc]init];
        _lbCenter.textAlignment=NSTextAlignmentCenter;
        _lbCenter.textColor=ColorFromHexRGB(0x2c2c2c);
        _lbCenter.font=[UIFont systemFontOfSize:13];
        _lbCenter.layer.borderColor=ColorFromHexRGB(0xe0e0e0).CGColor;
        _lbCenter.layer.borderWidth=0.5;
    }
    return _lbCenter;
}

- (UILabel *)lbRight{
    if (_lbRight==nil) {
        _lbRight=[[UILabel alloc]init];
        _lbRight.textAlignment=NSTextAlignmentCenter;
        _lbRight.textColor=ColorFromHexRGB(0x2c2c2c);
        _lbRight.font=[UIFont systemFontOfSize:13];
        _lbRight.layer.borderColor=ColorFromHexRGB(0xe0e0e0).CGColor;
        _lbRight.layer.borderWidth=0.5;
    }
    return _lbRight;
}

- (void)setupLeftText:(NSString *)left centerText:(NSString *)center rightText:(NSString *)right backgroundColor:(UIColor *)color{
    self.lbLeft.text=left;
    self.lbCenter.text=center;
    self.lbRight.text=right;
    self.lbLeft.backgroundColor=self.lbCenter.backgroundColor=self.lbRight.backgroundColor=color;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftRightMargin=25;
    CGFloat lbWidth=(self.contentView.width-leftRightMargin*2)*0.5;
    self.lbLeft.frame=CGRectMake(leftRightMargin, 0, lbWidth, self.contentView.height);
    self.lbCenter.frame=CGRectMake(self.lbLeft.right, 0, lbWidth*0.5, self.contentView.height);
    self.lbRight.frame=CGRectMake(self.lbCenter.right, 0, lbWidth*0.5, self.contentView.height);
}

@end
