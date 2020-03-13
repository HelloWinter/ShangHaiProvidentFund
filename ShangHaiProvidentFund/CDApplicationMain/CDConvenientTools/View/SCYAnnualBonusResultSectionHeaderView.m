//
//  SCYAnnualBonusResultSectionHeaderView.m
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusResultSectionHeaderView.h"

@interface SCYAnnualBonusResultSectionHeaderView ()

@property (nonatomic, strong) UILabel *lbTips;
@property (nonatomic, strong) UILabel *lbFormula;

@end

@implementation SCYAnnualBonusResultSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:({
            _lbTips=[[UILabel alloc]init];
            _lbTips.text=@"年终奖计算方法";
            _lbTips.textColor=ColorFromHexRGB(0x666666);
            _lbTips.font=[UIFont systemFontOfSize:13];
            _lbTips;
        })];
        [self addSubview:({
            _lbFormula=[[UILabel alloc]init];
            _lbFormula.text=@"税后=税前-税前*税率+速算扣除";
            _lbFormula.textColor=ColorFromHexRGB(0x2c2c2c);
            _lbFormula.font=[UIFont systemFontOfSize:13];
            _lbFormula;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftRightMargin=25;
    CGFloat lbWidth=self.width-leftRightMargin*2;
    CGFloat lbHeight=18;
    _lbTips.frame=CGRectMake(leftRightMargin, 20, lbWidth, lbHeight);
    _lbFormula.frame=CGRectMake(_lbTips.left, _lbTips.bottom+4, lbWidth, lbHeight);
}

@end
