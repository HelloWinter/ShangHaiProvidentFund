//
//  CDQueryAccountHeaderView.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/7/4.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDQueryAccountHeaderView.h"
#import "CDAccountInfoItem.h"

@interface CDQueryAccountHeaderView ()

@property (nonatomic, strong) UIImageView *imgPortrait;
@property (nonatomic, strong) UILabel *lbName;
@property (nonatomic, strong) UILabel *lbState;
@property (nonatomic, strong) UILabel *lbBalance;

@end

@implementation CDQueryAccountHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _imgPortrait=[[UIImageView alloc]init];
            NSString *imgName=[NSString stringWithFormat:@"defualtportrait%d",arc4random_uniform(6)];
            _imgPortrait.image=[UIImage imageNamed:imgName];
            _imgPortrait;
        })];
        [self addSubview:({
            _lbName=[[UILabel alloc]init];
            _lbName.font=[UIFont systemFontOfSize:15];
            _lbName.textColor=[UIColor whiteColor];
            _lbName.textAlignment=NSTextAlignmentCenter;
            _lbName;
        })];
        [self addSubview:({
            _lbState=[[UILabel alloc]init];
            _lbState.font=[UIFont systemFontOfSize:13];
            _lbState.textColor=[UIColor whiteColor];
            _lbState.textAlignment=NSTextAlignmentCenter;
            _lbState;
        })];
        [self addSubview:({
            _lbBalance=[[UILabel alloc]init];
            _lbBalance.font=[UIFont systemFontOfSize:13];
            _lbBalance.textColor=[UIColor whiteColor];
            _lbBalance.textAlignment=NSTextAlignmentCenter;
            _lbBalance;
        })];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_viewTapped)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftRightMargin=15;
    CGFloat imgWidth=60;
    _imgPortrait.frame=CGRectMake(0, 0, imgWidth, imgWidth);
    _imgPortrait.center=CGPointMake(self.width*0.5, self.height*0.5-20);
    _lbName.frame=CGRectMake(leftRightMargin, _imgPortrait.bottom+10, self.width-leftRightMargin*2, 20);
    _lbState.frame=CGRectMake(_lbName.left, _lbName.bottom, _lbName.width, 15);
    _lbBalance.frame=CGRectMake(_lbState.left, _lbState.bottom, _lbState.width, 15);
}

#pragma mark - public
- (void)setupViewItem:(CDAccountInfoItem *)item isLogined:(BOOL)islogined{
    if (islogined) {
        _lbBalance.hidden=_lbState.hidden=NO;
        _lbName.text=item.name ? : @"--";
        _lbBalance.text=[NSString stringWithFormat:@"余额：%@",item.surplus_def];
        _lbState.text=[NSString stringWithFormat:@"账户状态：%@",item.state];
    }else{
        _lbName.text=@"待君登录";
        _lbBalance.hidden=_lbState.hidden=YES;
    }
}

#pragma mark - private
- (void)p_viewTapped{
    if (self.viewTappedBlock) {
        self.viewTappedBlock();
    }
}

@end
