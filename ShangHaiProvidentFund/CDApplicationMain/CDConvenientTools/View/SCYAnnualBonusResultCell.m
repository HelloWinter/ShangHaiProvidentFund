//
//  SCYAnnualBonusResultCell.m
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusResultCell.h"
#import "UpDownLBView.h"

static const CGFloat lbTipsHeight=20;

@interface SCYAnnualBonusResultCell ()

@property (nonatomic, strong) UILabel *lbTips;
@property (nonatomic, strong) UpDownLBView *lbTopView;
@property (nonatomic, strong) UpDownLBView *lbBottomLeftView;
@property (nonatomic, strong) UpDownLBView *lbBottomRightView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation SCYAnnualBonusResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.lbTips];
        [self.contentView addSubview:self.lbTopView];
        [self.contentView addSubview:self.lbBottomLeftView];
        [self.contentView addSubview:self.lbBottomRightView];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (UILabel *)lbTips{
    if (_lbTips==nil) {
        _lbTips=[[UILabel alloc]init];
        _lbTips.backgroundColor=ColorFromHexRGB(0x3591fc);
        _lbTips.textAlignment=NSTextAlignmentCenter;
        _lbTips.textColor=[UIColor whiteColor];
        _lbTips.font=[UIFont systemFontOfSize:12];
        _lbTips.layer.cornerRadius=lbTipsHeight*0.5;
        _lbTips.layer.masksToBounds=YES;
        _lbTips.hidden=YES;
    }
    return _lbTips;
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

- (UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=ColorFromHexRGB(0xe0e0e0);
        _lineView.hidden=YES;
    }
    return _lineView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.lbTopView.frame=CGRectMake(0, 18, self.width, 100);
    CGFloat lbWidth=self.width*0.5;
    CGFloat lbHeight=50;
    self.lbBottomLeftView.frame=CGRectMake(0, self.lbTopView.bottom+10, lbWidth, lbHeight);
    self.lbBottomRightView.frame=CGRectMake(self.lbBottomLeftView.right, self.lbBottomLeftView.top, lbWidth, lbHeight);
    
    self.lbTips.frame=CGRectMake(15, 18, 50, lbTipsHeight);
    self.lineView.frame=CGRectMake(0, self.contentView.height-0.5, self.contentView.width, 0.5);
}

- (void)setupWithBeforeTax:(double)before afterTax:(double)after type:(SCYAnnualBonusCalculateType)type showTips:(BOOL)show indexPath:(NSIndexPath *)path{
    NSString *strTop=[NSString stringWithFormat:@"%.2f 元",(type==SCYAnnualBonusCalculateType1 ? after : before)];
    NSMutableAttributedString *aStrTop=[[NSMutableAttributedString alloc]initWithString:strTop];
    [aStrTop addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:[strTop rangeOfString:@"元"]];
    self.lbTopView.lbUp.attributedText=aStrTop;
    self.lbTopView.lbDown.text=(type==SCYAnnualBonusCalculateType1) ? @"税后年终奖" : @"税前年终奖";
    self.lbBottomLeftView.lbUp.text=[NSString stringWithFormat:@"%.2f 元",(type==SCYAnnualBonusCalculateType1 ? before : after)];
    self.lbBottomLeftView.lbDown.text=(type==SCYAnnualBonusCalculateType1) ? @"税前" : @"税后";
    CGFloat tax=before-after;
    self.lbBottomRightView.lbUp.text=[NSString stringWithFormat:@"%.2f 元",tax];
    if (show) {
        self.lbTips.hidden=NO;
        if (path.row==0) {
            self.lbTips.text=@"结果一";
            self.lineView.hidden=NO;
        }else if (path.row==1){
            self.lbTips.text=@"结果二";
            self.lineView.hidden=YES;
        }else{
            self.lbTips.hidden=YES;
            self.lineView.hidden=YES;
        }
    }else{
        self.lbTips.hidden=YES;
        self.lineView.hidden=YES;
    }
}

@end
