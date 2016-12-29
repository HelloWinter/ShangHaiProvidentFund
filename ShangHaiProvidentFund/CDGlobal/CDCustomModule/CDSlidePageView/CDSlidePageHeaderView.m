//
//  CDSlidePageHeaderView.m
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import "CDSlidePageHeaderView.h"
#import "NSString+CDEncryption.h"

static CGFloat const badgeViewfont = 12;

@interface CDSlidePageHeaderView ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *badgeViews;

@end

@implementation CDSlidePageHeaderView
@synthesize sliderView=_sliderView;

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
    _sliderSize = CGSizeZero;
    _normalColor = [UIColor lightGrayColor];
    _selectedColor = [UIColor redColor];
    _selectedIndex=0;
    [self addSubview:self.sliderView];
}

- (NSMutableArray *)badgeViews{
    if (_badgeViews==nil) {
        _badgeViews=[[NSMutableArray alloc]init];
    }
    return _badgeViews;
}
- (NSMutableArray *)buttons{
    if (_buttons==nil) {
        _buttons=[[NSMutableArray alloc]init];
    }
    return _buttons;
}

- (UIView *)sliderView{
    if (_sliderView==nil) {
        _sliderView=[[UIView alloc]init];
    }
    return _sliderView;
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor=selectedColor;
    self.sliderView.backgroundColor=_selectedColor;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self reload];
}

- (void)reload {
    [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int idx = 0; idx < self.itemTitles.count; idx++) {
        [self createButtonWithIndex:idx];
        [self createBadgeViewWithIndex:idx];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.width / self.itemTitles.count;
    CGFloat height = self.height;
    CGFloat badgeViewHeight = 15;
    for (int idx = 0; idx < self.itemTitles.count; idx ++) {
        UIButton *button = self.buttons[idx];
        CGFloat axisX = width*idx;
        CGFloat axisY = 0;
        button.frame = CGRectMake(axisX, axisY, width, height);
        
        UILabel *badgeView = self.badgeViews[idx];
        CGSize badgeViewSize = [badgeView.text sizeWithpreferHeight:badgeViewHeight font:[UIFont systemFontOfSize:badgeViewfont]];
        badgeView.frame = CGRectMake(button.right - 25, button.top + 5, badgeViewSize.width + 9, badgeViewHeight);
    }
    if (CGSizeEqualToSize(_sliderSize, CGSizeZero)) {
        self.sliderView.size=CGSizeMake(width, 2.0);
    } else {
        _sliderSize.width = MIN(_sliderSize.width, width);
        _sliderSize.height = MIN(_sliderSize.height, height);
        self.sliderView.size = _sliderSize;
    }
    self.sliderView.bottom = self.height;
    self.sliderView.centerX = width * (_selectedIndex+0.5f);
}

- (void)p_titleButtonAction:(UIButton *)button {
    if ([self.buttons containsObject:button]) {
        NSUInteger selectedIndex = [self.buttons indexOfObject:button];
        [self setSelectedIndex:selectedIndex];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex >= self.itemTitles.count) { return; }
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        if (_delegate && [_delegate respondsToSelector:@selector(slidePageHeaderView:willSelectButtonAtIndex:)]) {
            [_delegate slidePageHeaderView:self willSelectButtonAtIndex:_selectedIndex];
        }
        [UIView animateWithDuration:0.25 animations:^{
            for (int idx = 0; idx < self.itemTitles.count; idx ++) {
                UIButton *button = [self.buttons cd_safeObjectAtIndex:idx];
                button.selected = idx == _selectedIndex;
                if (button.selected) {
                    self.sliderView.centerX = button.centerX;
                }
            }
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(slidePageHeaderView:didSelectButtonAtIndex:)]) {
                [_delegate slidePageHeaderView:self didSelectButtonAtIndex:_selectedIndex];
            }
        }];
    }
}
#pragma mark - private
/// 创建按钮
- (void)createButtonWithIndex:(NSInteger)idx{
    UIButton *button=[self.buttons cd_safeObjectAtIndex:idx];
    if (!button) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.adjustsFontSizeToFitWidth=YES;
        [button addTarget:self action:@selector(p_titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedColor forState:UIControlStateSelected];
        if (self.isBoldFont) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        }
        [self.buttons addObject:button];
    }
    button.selected = (idx == _selectedIndex);
    NSString *title = [self.itemTitles cd_safeObjectAtIndex:idx];
    [button setTitle:title forState:UIControlStateNormal];
    [self addSubview:button];
}

/// 创建badgeView
- (void)createBadgeViewWithIndex:(NSInteger)idx{
    UILabel *badgeView = [self.badgeViews cd_safeObjectAtIndex:idx];
    if (!badgeView) {
        badgeView = [[UILabel alloc] init];
        badgeView.font = [UIFont systemFontOfSize:badgeViewfont];
        badgeView.backgroundColor = [UIColor redColor];
        badgeView.textColor = [UIColor whiteColor];
        badgeView.textAlignment = NSTextAlignmentCenter;
        [self.badgeViews addObject:badgeView];
        
        badgeView.layer.cornerRadius = 7.5;
        badgeView.layer.masksToBounds = YES;
    }
    NSString *badge = [self.badgeNumbers cd_safeObjectAtIndex:idx];
    badgeView.hidden = (!badge || [badge isEqualToString:@"0"] || badge.length == 0) ? YES : NO;
    badgeView.text = badge.length > 2 ? @"99+" : badge;
    [self addSubview:badgeView];
}
@end
