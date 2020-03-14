//
//  CDRegistFooterView.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/13.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDRegistFooterView.h"

@interface CDRegistFooterView ()

@property (nonatomic, strong) UIButton *btnProtocol;
@property (nonatomic, strong) UIButton *btnRegist;
@property (nonatomic, strong) UIButton *btnProblem;

@end

@implementation CDRegistFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _btnProtocol =[UIButton buttonWithType:(UIButtonTypeCustom)];
            [_btnProtocol setTitle:@"  我已阅读并同意《用户协议》" forState:(UIControlStateNormal)];
            [_btnProtocol setTitleColor:ColorFromHexRGB(0xbdc0c2) forState:(UIControlStateNormal)];
            _btnProtocol.titleLabel.font=[UIFont systemFontOfSize:13];
            [_btnProtocol setImage:[UIImage imageNamed:@"checkmark"] forState:(UIControlStateNormal)];
            [_btnProtocol addTarget:self action:@selector(btnProtocolClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            _btnProtocol;
        })];
        [self addSubview:({
            _btnRegist=[[UIButton alloc]init];
            [_btnRegist setTitle:@"注册" forState:(UIControlStateNormal)];
            [_btnRegist setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [_btnRegist setBackgroundColor:ColorFromHexRGB(0x36c362)];
            [_btnRegist addTarget:self action:@selector(btnRegistClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            _btnRegist.layer.cornerRadius=CORNER_RADIUS;
            _btnRegist.layer.masksToBounds=YES;
            _btnRegist;
        })];
        [self addSubview:({
            _btnProblem=[UIButton buttonWithType:(UIButtonTypeCustom)];
            _btnProblem.titleLabel.font=[UIFont systemFontOfSize:14];
            [_btnProblem setTitle:@"有问题？" forState:(UIControlStateNormal)];
            [_btnProblem setTitleColor:ColorFromHexRGB(0x27a5e2) forState:(UIControlStateNormal)];
            [_btnProblem addTarget:self action:@selector(btnProblemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            _btnProblem;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _btnProtocol.frame=CGRectMake(LEFT_RIGHT_MARGIN,10, 200, 25);
    _btnRegist.frame=CGRectMake(LEFT_RIGHT_MARGIN, _btnProtocol.bottom+10, self.width-LEFT_RIGHT_MARGIN*2, 45);
    _btnProblem.frame=CGRectMake(self.width-130, _btnRegist.bottom+10, 110, 30);
}

#pragma mark - private
- (void)btnProtocolClicked:(UIButton *)sender{
    if (self.showProtocolBlock) {
        self.showProtocolBlock();
    }
}

- (void)btnRegistClicked:(UIButton *)sender{
    if (self.registBlock) {
        self.registBlock();
    }
}

- (void)btnProblemClicked:(UIButton *)sender{
    if (self.showProblemBlock) {
        self.showProblemBlock();
    }
}

@end
