//
//  CDSlidePageHeaderView.m
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import "CDSlidePageHeaderView.h"

@interface CDSlidePageHeaderView ()

@property (nonatomic, strong) NSMutableArray *buttons;

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
    _tabSize = CGSizeZero;
    _titleColor = [UIColor lightGrayColor];
    _sliderColor = [UIColor redColor];
    _selectedIndex=0;
    [self addSubview:self.sliderView];
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

- (void)setSliderColor:(UIColor *)sliderColor{
    _sliderColor=sliderColor;
    self.sliderView.backgroundColor=_sliderColor;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self reload];
}

- (void)reload {
    [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttons removeAllObjects];
    for (int idx = 0; idx < self.titles.count; idx ++) {
        NSString *title = self.titles[idx];
        if (![title isKindOfClass:[NSString class]]) {
            continue;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(p_titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:_titleColor forState:UIControlStateNormal];
        [button setTitleColor:_sliderColor forState:UIControlStateSelected];
        button.selected = idx == _selectedIndex;
        [self.buttons addObject:button];
        [self addSubview:button];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width / self.titles.count;
    CGFloat height = self.height;
    for (int idx = 0; idx < _buttons.count; idx ++) {
        UIButton *button = _buttons[idx];
        if (![button isKindOfClass:[UIButton class]]) {
            continue;
        }
        CGFloat axisX = width *idx;
        CGFloat axisY = 0;
        button.frame = CGRectMake(axisX, axisY, width, height);
    }
    if (CGSizeEqualToSize(_tabSize, CGSizeZero)) {
        self.sliderView.width = width;
        self.sliderView.height = 2.0;
    } else {
        _tabSize.width = MIN(_tabSize.width, width);
        _tabSize.height = MIN(_tabSize.height, self.height);
        self.sliderView.size = _tabSize;
    }
    self.sliderView.bottom = self.height;
    self.sliderView.centerX = width * 0.5 + width * _selectedIndex;
}

- (void)p_titleButtonAction:(UIButton *)button {
    if ([_buttons containsObject:button]) {
        NSUInteger selectedIndex = [_buttons indexOfObject:button];
        [self setSelectedIndex:selectedIndex];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (selectedIndex >= self.buttons.count) {
        return;
    }
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        if (_delegate && [_delegate respondsToSelector:@selector(slidePageHeaderView:willSelectButtonAtIndex:)]) {
            [_delegate slidePageHeaderView:self willSelectButtonAtIndex:_selectedIndex];
        }
        [UIView animateWithDuration:0.25 animations:^{
            for (int idx = 0; idx < self.buttons.count; idx ++) {
                UIButton *button = self.buttons[idx];
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

@end
