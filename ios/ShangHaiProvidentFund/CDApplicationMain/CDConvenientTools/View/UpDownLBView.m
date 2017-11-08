//
//  UpDownLBView.m
//  MoneyMore
//
//  Created by cdd on 15/4/20.
//  Copyright (c) 2015年 ___9188___. All rights reserved.
//

#import "UpDownLBView.h"

@implementation UpDownLBView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupView];
}

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.percentageOflbUp=0.5;
    self.backgroundColor=[UIColor clearColor];
    _lbUp=[[UILabel alloc]init];
    _lbUp.font=[UIFont systemFontOfSize:15];
    _lbUp.textColor=ColorFromHexRGB(0x212121);
    _lbUp.adjustsFontSizeToFitWidth=NO;
    _lbUp.numberOfLines=0;
    _lbUp.lineBreakMode=NSLineBreakByCharWrapping;
    [self addSubview:_lbUp];
    _lbDown = [[UILabel alloc]init];
    _lbDown.font=[UIFont systemFontOfSize:13];
    _lbDown.textColor=ColorFromHexRGB(0x9e9e9e);
    _lbDown.adjustsFontSizeToFitWidth=NO;
    _lbDown.numberOfLines=0;
    _lbDown.lineBreakMode=NSLineBreakByCharWrapping;
    [self addSubview:_lbDown];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _lbUp.frame=CGRectMake(0, 0, self.width,self.height*self.percentageOflbUp);
    _lbDown.frame=CGRectMake(0, _lbUp.bottom, self.width, self.height*(1.0-self.percentageOflbUp));
}

@end
