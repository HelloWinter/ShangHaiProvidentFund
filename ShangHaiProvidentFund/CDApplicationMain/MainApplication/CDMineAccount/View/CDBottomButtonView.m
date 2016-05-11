//
//  CDBottomButtonView.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBottomButtonView.h"

@interface CDBottomButtonView ()

@property (strong, nonatomic) UIButton *btnForgetPSW;
@property (strong, nonatomic) UIButton *btnRegist;

@end

@implementation CDBottomButtonView

- (instancetype)init{
    self = [super init];
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
    self.backgroundColor=[UIColor clearColor];
    [self addSubview:self.btnForgetPSW];
    [self addSubview:self.btnRegist];
}

//+ (instancetype)bottomButtonView{
//    CDBottomButtonView *view=[[[NSBundle mainBundle]loadNibNamed:@"CDBottomButtonView" owner:nil options:nil]lastObject];
//    
//    return view;
//}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.btnForgetPSW.frame=CGRectMake(0, 0, self.width*0.5, self.height);
    self.btnRegist.frame=CGRectMake(self.btnForgetPSW.right, 0, self.width*0.5, self.height);
}

- (UIButton *)btnForgetPSW{
    if(_btnForgetPSW == nil){
        _btnForgetPSW = [[UIButton alloc]init];
        _btnForgetPSW.titleLabel.font=[UIFont systemFontOfSize:13];
        [_btnForgetPSW setTitleColor:ColorFromHexRGB(0x01b2d3) forState:(UIControlStateNormal)];
        [_btnForgetPSW setTitle:@"忘记密码" forState:(UIControlStateNormal)];
        [_btnForgetPSW addTarget:self action:@selector(btnForgotPSWClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btnForgetPSW;
}

- (UIButton *)btnRegist{
    if(_btnRegist == nil){
        _btnRegist = [[UIButton alloc]init];
        _btnRegist.titleLabel.font=[UIFont systemFontOfSize:13];
        [_btnRegist setTitleColor:ColorFromHexRGB(0x01b2d3) forState:(UIControlStateNormal)];
        [_btnRegist setTitle:@"个人注册" forState:(UIControlStateNormal)];
        [_btnRegist addTarget:self action:@selector(btnRegistClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btnRegist;
}

- (void)btnForgotPSWClick:(UIButton *)sender {
    if (self.forgotPSWBlock) {
        self.forgotPSWBlock();
    }
}

- (void)btnRegistClick:(UIButton *)sender {
    if (self.registBlock) {
        self.registBlock();
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 0.5);
//    ColorFromHexRGB(0x01b2d3)
    CGContextSetRGBStrokeColor(ctx, 0, 255, 200, 1.0);
    CGContextMoveToPoint(ctx, self.width*0.5, 0);
    CGContextAddLineToPoint(ctx, self.width*0.5, self.height);
    CGContextStrokePath(ctx);
}

@end
