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

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self addSubview:({
            _btnForgetPSW = [[UIButton alloc]init];
            _btnForgetPSW.titleLabel.font=[UIFont systemFontOfSize:13];
            [_btnForgetPSW setTitleColor:NAVIGATION_COLOR forState:(UIControlStateNormal)];
            [_btnForgetPSW setTitle:@"忘记密码" forState:(UIControlStateNormal)];
            [_btnForgetPSW addTarget:self action:@selector(btnForgotPSWClick:) forControlEvents:(UIControlEventTouchUpInside)];
            _btnForgetPSW;
        })];
        [self addSubview:({
            _btnRegist = [[UIButton alloc]init];
            _btnRegist.titleLabel.font=[UIFont systemFontOfSize:13];
            [_btnRegist setTitleColor:NAVIGATION_COLOR forState:(UIControlStateNormal)];
            [_btnRegist setTitle:@"个人注册" forState:(UIControlStateNormal)];
            [_btnRegist addTarget:self action:@selector(btnRegistClick:) forControlEvents:(UIControlEventTouchUpInside)];
            _btnRegist;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _btnForgetPSW.frame=CGRectMake(0, 0, self.width*0.5, self.height);
    _btnRegist.frame=CGRectMake(_btnForgetPSW.right, 0, self.width*0.5, self.height);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 0.5);
//    CGContextSetRGBStrokeColor(ctx, 0, 255, 200, 1.0);
    [NAVIGATION_COLOR setStroke];
    CGContextMoveToPoint(ctx, self.width*0.5, self.height*0.25);
    CGContextAddLineToPoint(ctx, self.width*0.5, self.height*0.75);
    CGContextStrokePath(ctx);
}

#pragma mark - private
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

@end
