//
//  SCYButtonTableFooterView.m
//  ProvidentFund
//
//  Created by cdd on 15/12/24.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "SCYButtonTableFooterView.h"
#import "SCYActivityIndicatorButton.h"

@interface SCYButtonTableFooterView ()

@property (strong, nonatomic) SCYActivityIndicatorButton *btnFooter;

@property (nonatomic, assign) CGRect btnFrame;

@end

@implementation SCYButtonTableFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupinit];
    }
    return self;
}

- (void)setupinit{
    self.backgroundColor=[UIColor clearColor];
    self.btnFrame=CGRectZero;
    [self addSubview:self.btnFooter];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (CGRectEqualToRect(self.btnFrame, CGRectZero)) {
        self.btnFooter.frame=CGRectMake(LEFT_RIGHT_MARGIN, 20, self.width-LEFT_RIGHT_MARGIN*2, 44);
    }else{
        self.btnFooter.frame=self.btnFrame;
    }
}

- (SCYActivityIndicatorButton *)btnFooter{
    if (_btnFooter==nil) {
        _btnFooter=[[SCYActivityIndicatorButton alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        [_btnFooter setTitle:@"登录" forState:(UIControlStateNormal)];
        [_btnFooter setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_btnFooter addTarget:self action:@selector(p_btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_btnFooter setBackgroundColor:ColorFromHexRGB(0x26df77)];
        _btnFooter.titleLabel.font=[UIFont systemFontOfSize:15];
        _btnFooter.layer.cornerRadius=CORNER_RADIUS;
        _btnFooter.clipsToBounds=YES;
    }
    return _btnFooter;
}

#pragma mark - public
- (void)setupBtnFrame:(CGRect)frame{
    self.btnFrame=frame;
    [self setNeedsLayout];
}

- (void)setupBtnTitle:(NSString *)title{
    [self.btnFooter setTitle:title forState:(UIControlStateNormal)];
}

- (void)setupBtnBackgroundColor:(UIColor *)color{
    [self.btnFooter setBackgroundColor:color];
}

- (void)activityIndicatorStartAnimate{
    [self.btnFooter.activityIndicator startAnimating];
}

- (void)activityIndicatorStopAnimate{
    [self.btnFooter.activityIndicator stopAnimating];
}

#pragma mark - private
- (void)p_btnAction:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender);
    }
}



@end
