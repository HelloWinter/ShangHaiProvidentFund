//
//  CDVerificationCodeCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/17.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDVerificationCodeCell.h"
#import "CDOpinionsSuggestionsItem.h"
#import "UIImage+CDImageAdditions.h"


@interface CDVerificationCodeCell (){
    NSTimer *_timer;                       // 倒计时定时器
    NSInteger _countDown;                  // 倒计时时限
}

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *getSecurityBtn;


@end

@implementation CDVerificationCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _textField.textAlignment=NSTextAlignmentLeft;
        _textField.font=[UIFont systemFontOfSize:14];
    }
    return self;
}

- (UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.font=[UIFont systemFontOfSize:14];
    }
    return _label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize textsize = [self.label.text sizeWithAttributes:@{NSFontAttributeName:self.label.font}];
    self.label.frame=CGRectMake(0, 0, textsize.width, _textField.height);
    self.getSecurityBtn.frame=CGRectMake(0, 0, 80, _textField.height);
}

#pragma mark - public
- (void)setupItem:(CDOpinionsSuggestionsItem *)item indexPath:(NSIndexPath *)path{
    _textField.secureTextEntry=[item.security isEqualToString:@"1"] ? YES : NO;
    _textField.text=item.value;
    self.label.text=item.paramname;
    [super setupLeftView:self.label rightView:self.getSecurityBtn placeHolder:item.hint defaultText:@"" indexPath:path];
}

#pragma mark - private
/* 获取验证码按钮 */
- (UIButton *)p_getSecurityBtn{
    if (!_getSecurityBtn) {
        _getSecurityBtn = [[UIButton alloc]init];
        UIImage *normalImg=[UIImage cd_imageWithColor:NAVIGATION_COLOR];
        UIImage *disableImg=[UIImage cd_imageWithColor:ColorFromHexRGB(0x80d8e9)];
        [_getSecurityBtn setBackgroundImage:normalImg forState:(UIControlStateNormal)];
        [_getSecurityBtn setBackgroundImage:disableImg forState:(UIControlStateDisabled)];
        [_getSecurityBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_getSecurityBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getSecurityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getSecurityBtn addTarget:self action:@selector(p_getSecurityCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSecurityBtn;
}

- (void)p_getSecurityCode{
    if (self.getVerCodeBlock) {
        BOOL shouldStart = self.getVerCodeBlock();
        if (shouldStart) {
            [self p_startTimer];
        }
    }
}

/* 刷新倒计时和按钮title */
- (void)p_updateCountdown{
    if (_countDown > 0) {
        [self.getSecurityBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)_countDown] forState:UIControlStateDisabled];
        _countDown --;
    }else{
        [self p_invalidTimer];
        self.getSecurityBtn.enabled=YES;
        [self.getSecurityBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    }
}

/* 启动定时器，开始倒计时，在此期间不能重新获取验证码，并使按钮颜色变成灰色 */
- (void)p_startTimer{
    [self p_invalidTimer];
    _countDown = 59;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(p_updateCountdown) userInfo:nil repeats:YES];
    [_timer fire];
    self.getSecurityBtn.enabled = NO;
}

/* 关闭定时器 */
- (void)p_invalidTimer{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
