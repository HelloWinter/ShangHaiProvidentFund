//
//  SCYAnnualBonusResultTableHeaderView.m
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusResultTableHeaderView.h"
#import "UpDownLBView.h"

@interface SCYAnnualBonusResultTableHeaderView ()

@property (nonatomic, strong) UpDownLBView *lbTopView;
@property (nonatomic, strong) UpDownLBView *lbBottomLeftView;
@property (nonatomic, strong) UpDownLBView *lbBottomRightView;

@end

@implementation SCYAnnualBonusResultTableHeaderView

- (instancetype)init{
    self =[super init];
    if (self) {
        [self addSubview:self.lbTopView];
        [self addSubview:self.lbBottomLeftView];
        [self addSubview:self.lbBottomRightView];
    }
    return self;
}

- (UpDownLBView *)lbTopView{
    if (_lbTopView==nil) {
        _lbTopView=[[UpDownLBView alloc]init];
        _lbTopView.percentageOflbUp=0.8;
        _lbTopView.lbUp.textAlignment=_lbTopView.lbDown.textAlignment=NSTextAlignmentCenter;
        _lbTopView.lbUp.font=[UIFont systemFontOfSize:38];
        _lbTopView.lbDown.font=[UIFont systemFontOfSize:13];
        _lbTopView.lbUp.textColor=ColorFromHexRGB(0x2c2c2c);
        _lbTopView.lbDown.textColor=ColorFromHexRGB(0x707070);
    }
    return _lbTopView;
}

- (UpDownLBView *)lbBottomLeftView{
    if (_lbBottomLeftView==nil) {
        _lbBottomLeftView=[[UpDownLBView alloc]init];
        _lbBottomLeftView.lbUp.textAlignment=_lbBottomLeftView.lbDown.textAlignment=NSTextAlignmentCenter;
        _lbBottomLeftView.lbUp.font=[UIFont systemFontOfSize:17];
        _lbBottomLeftView.lbDown.font=[UIFont systemFontOfSize:13];
        _lbBottomLeftView.lbUp.textColor=ColorFromHexRGB(0x2c2c2c);
        _lbBottomLeftView.lbDown.textColor=ColorFromHexRGB(0x4291f0);
    }
    return _lbBottomLeftView;
}

- (UpDownLBView *)lbBottomRightView{
    if (_lbBottomRightView==nil) {
        _lbBottomRightView=[[UpDownLBView alloc]init];
        _lbBottomRightView.lbUp.textAlignment=_lbBottomRightView.lbDown.textAlignment=NSTextAlignmentCenter;
        _lbBottomRightView.lbUp.font=[UIFont systemFontOfSize:17];
        _lbBottomRightView.lbDown.font=[UIFont systemFontOfSize:13];
        _lbBottomRightView.lbUp.textColor=ColorFromHexRGB(0x2c2c2c);
        _lbBottomRightView.lbDown.textColor=ColorFromHexRGB(0x4291f0);
        _lbBottomRightView.lbDown.text=@"税费";
    }
    return _lbBottomRightView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lbTopView.frame=CGRectMake(0, 18, self.width, 100);
    CGFloat lbWidth=self.width*0.5;
    CGFloat lbHeight=50;
    self.lbBottomLeftView.frame=CGRectMake(0, self.lbTopView.bottom+10, lbWidth, lbHeight);
    self.lbBottomRightView.frame=CGRectMake(self.lbBottomLeftView.right, self.lbBottomLeftView.top, lbWidth, lbHeight);
}

- (void)setupWith{
    BOOL type=YES;//税后或税前
    NSString *strTop=[NSString stringWithFormat:@"%@ 元",@"9700"];
    NSMutableAttributedString *aStrTop=[[NSMutableAttributedString alloc]initWithString:strTop];
    [aStrTop addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:[strTop rangeOfString:@"元"]];
    self.lbTopView.lbUp.attributedText=aStrTop;
    self.lbTopView.lbDown.text=(type) ? @"税后年终奖" : @"税前年终奖";
    self.lbBottomLeftView.lbUp.text=[NSString stringWithFormat:@"%@元",@"10000"];
    self.lbBottomLeftView.lbDown.text=(type) ? @"税前" : @"税后";
    self.lbBottomRightView.lbUp.text=[NSString stringWithFormat:@"%@元",@"300"];
}

@end
