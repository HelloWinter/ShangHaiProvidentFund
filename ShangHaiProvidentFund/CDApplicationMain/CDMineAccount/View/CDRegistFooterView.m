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

- (instancetype)init{
    self =[super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.btnProtocol];
    [self addSubview:self.btnRegist];
    [self addSubview:self.btnProblem];
}

- (UIButton *)btnProtocol{
    if (!_btnProtocol) {
        _btnProtocol =[UIButton buttonWithType:(UIButtonTypeCustom)];
        [_btnProtocol setTitle:@"  我已阅读并同意《用户协议》" forState:(UIControlStateNormal)];
        [_btnProtocol setTitleColor:ColorFromHexRGB(0xbdc0c2) forState:(UIControlStateNormal)];
        _btnProtocol.titleLabel.font=[UIFont systemFontOfSize:13];
        [_btnProtocol setImage:[UIImage imageNamed:@"checkmark"] forState:(UIControlStateNormal)];
        [_btnProtocol addTarget:self action:@selector(btnProtocolClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btnProtocol;
}

- (UIButton *)btnRegist{
    if (_btnRegist==nil) {
        _btnRegist=[[UIButton alloc]init];
        [_btnRegist setTitle:@"注册" forState:(UIControlStateNormal)];
        [_btnRegist setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_btnRegist setBackgroundColor:ColorFromHexRGB(0x36c362)];
        [_btnRegist addTarget:self action:@selector(btnRegistClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        _btnRegist.layer.cornerRadius=CORNER_RADIUS;
        _btnRegist.layer.masksToBounds=YES;
    }
    return _btnRegist;
}

- (UIButton *)btnProblem{
    if (_btnProblem==nil) {
        _btnProblem=[UIButton buttonWithType:(UIButtonTypeCustom)];
        _btnProblem.titleLabel.font=[UIFont systemFontOfSize:14];
        [_btnProblem setTitle:@"有问题？" forState:(UIControlStateNormal)];
        [_btnProblem setTitleColor:ColorFromHexRGB(0x27a5e2) forState:(UIControlStateNormal)];
        [_btnProblem addTarget:self action:@selector(btnProblemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btnProblem;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.btnProtocol.frame=CGRectMake(LEFT_RIGHT_MARGIN,10, 200, 25);
    self.btnRegist.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.btnProtocol.bottom+10, self.width-LEFT_RIGHT_MARGIN*2, 45);
    self.btnProblem.frame=CGRectMake(self.width-130, self.btnRegist.bottom+10, 110, 30);
    
//    140
}

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
