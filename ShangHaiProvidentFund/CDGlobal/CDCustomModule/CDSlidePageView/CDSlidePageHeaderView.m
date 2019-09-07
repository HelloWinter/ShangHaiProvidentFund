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

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttons;//button缓冲池
@property (nonatomic, strong) NSMutableArray *badgeViews;

@end

@implementation CDSlidePageHeaderView
@synthesize sliderView=_sliderView;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _sliderSize = CGSizeZero;
        _normalColor = [UIColor lightGrayColor];
        _selectedColor = RGBCOLOR(53, 145, 252);
        _selectedIndex=0;
        _itemWidth=0;
        _fontSize = 15;
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.sliderView];
    }
    return self;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.bounces=NO;
    }
    return _scrollView;
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

#pragma mark - override
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self reload];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame=self.bounds;
    
    self.itemWidth = self.itemWidth==0 ? self.width / self.itemTitles.count : self.itemWidth;
    CGFloat itemHeight = self.height;
    
    CGFloat badgeViewHeight = 15;
    for (int idx = 0; idx < self.itemTitles.count; idx ++) {
        UIButton *button = self.buttons[idx];
        button.frame = CGRectMake(self.itemWidth*idx, 0, self.itemWidth, itemHeight);
        
        UILabel *badgeView = self.badgeViews[idx];
        CGSize badgeViewSize = [badgeView.text cd_sizeWithPreferHeight:badgeViewHeight font:[UIFont systemFontOfSize:badgeViewfont]];
        // 这里badgeView的坐标  定死了  以后情况多时   在找统一计算方法
        NSInteger badgeMargin = 0;
        if (self.badgeViews.count == 3 ) {
            badgeMargin = SCREEN_WIDTH * 0.07;
        } else if (self.badgeViews.count == 2) {
            badgeMargin = SCREEN_WIDTH * 0.15;
        }
        badgeView.frame = CGRectMake(button.right - badgeMargin, button.top + 5, badgeViewSize.width + 9, badgeViewHeight);
    }
    if (CGSizeEqualToSize(_sliderSize, CGSizeZero)) {
        self.sliderView.size=CGSizeMake(self.itemWidth, 2.0);
    } else {
        _sliderSize.width = MIN(_sliderSize.width, self.itemWidth);
        _sliderSize.height = MIN(_sliderSize.height, itemHeight);
        self.sliderView.size = _sliderSize;
    }
    self.sliderView.bottom = self.height;
    self.sliderView.centerX = self.itemWidth * (_selectedIndex+0.5f);
    
    self.scrollView.contentSize=CGSizeMake(self.itemWidth*self.itemTitles.count, itemHeight);
}

#pragma mark - public
- (void)setItemTitles:(NSArray<NSString *> *)itemTitles{
    _itemTitles=[itemTitles copy];
    [self reload];
}

- (CGSize)contentSize{
    return self.scrollView.contentSize;
}

#pragma mark - private
- (void)reload {
    [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.itemTitles.count!=0) {
        for (int idx = 0; idx < self.itemTitles.count; idx++) {
            [self createButtonWithIndex:idx];
            [self createBadgeViewWithIndex:idx];
        }
    }
    [self setNeedsLayout];
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
                button.selected = idx == self->_selectedIndex;
                if (button.selected) {
                    self.sliderView.centerX = button.centerX;
                    [self.scrollView scrollRectToVisible:button.frame animated:YES];
                }
            }
        } completion:^(BOOL finished) {
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(slidePageHeaderView:didSelectButtonAtIndex:)]) {
                [self->_delegate slidePageHeaderView:self didSelectButtonAtIndex:self->_selectedIndex];
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
        button.titleLabel.font=[UIFont systemFontOfSize:self.fontSize];
        if (self.isBoldFont) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:self.fontSize];
        }
        button.titleLabel.adjustsFontSizeToFitWidth=YES;
        [button addTarget:self action:@selector(p_titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedColor forState:UIControlStateSelected];
        [self.buttons addObject:button];
    }
    button.selected = (idx == _selectedIndex);
    NSString *title = [self.itemTitles cd_safeObjectAtIndex:idx];
    [button setTitle:title forState:UIControlStateNormal];
    [self.scrollView addSubview:button];
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
    badgeView.text = badge.integerValue > 99 ? @"99+" : badge;
    [self.scrollView addSubview:badgeView];
}
@end

