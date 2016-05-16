//
//  CDSlidePageView.m
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import "CDSlidePageView.h"
#import "CDSlidePageHeaderView.h"

@interface CDSlidePageView ()<UIScrollViewDelegate,CDSlidePageHeaderViewDelegate>

@property (nonatomic) NSUInteger numberOfPages;
@property (nonatomic, strong) NSMutableArray *contentViews;

@end

@implementation CDSlidePageView
@synthesize headerView=_headerView;
@synthesize bodyView=_bodyView;

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
    [self addSubview:self.headerView];
    [self addSubview:self.bodyView];
}

- (NSMutableArray *)contentViews{
    if (_contentViews==nil) {
        _contentViews=[[NSMutableArray alloc]init];
    }
    return _contentViews;
}

- (CDSlidePageHeaderView *)headerView{
    if (_headerView==nil) {
        _headerView=[[CDSlidePageHeaderView alloc]init];
        _headerView.tabSize=CGSizeMake(30, 2);
        _headerView.sliderColor=[UIColor redColor];
        _headerView.delegate=self;
    }
    return _headerView;
}

- (UIScrollView *)bodyView{
    if (_bodyView==nil) {
        _bodyView=[[UIScrollView alloc]init];
        _bodyView.pagingEnabled = YES;
        _bodyView.delegate = self;
        _bodyView.showsHorizontalScrollIndicator = NO;
        _bodyView.showsVerticalScrollIndicator = NO;
        _bodyView.bounces = NO;
    }
    return _bodyView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.numberOfPages == 0) {
        return;
    }
    self.headerView.frame = CGRectMake(0, 0, self.width, 44);
    
    self.bodyView.frame = CGRectMake(0, self.headerView.bottom, self.width, self.height - self.headerView.bottom);
    self.bodyView.contentSize = CGSizeMake(self.numberOfPages * self.bodyView.width, self.bodyView.height);
    for (int idx = 0; idx < self.contentViews.count; idx ++) {
        UIView *contentView  = self.contentViews[idx];
        contentView.frame = CGRectMake(idx * self.bodyView.width, 0, self.bodyView.width, self.bodyView.height);
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview && _dataSource) {
        [self reload];
    }
}

- (void)reload {
    self.numberOfPages = 0;
    [self.contentViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentViews removeAllObjects];
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfPagesInSlidePageView:)]) {
        self.numberOfPages = [_dataSource numberOfPagesInSlidePageView:self];
    }
    
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:self.numberOfPages];
    for (int idx = 0; idx < self.numberOfPages; idx ++) {
        if (_dataSource && [_dataSource respondsToSelector:@selector(slidePageView:headerTitleAtPageIndex:)]) {
            NSString *title = [_dataSource slidePageView:self headerTitleAtPageIndex:idx];
            [titles addObject:title];
        }
        if (_dataSource && [_dataSource respondsToSelector:@selector(slidePageView:contentViewAtPageIndex:)]) {
            UIView *contentView = [_dataSource slidePageView:self contentViewAtPageIndex:idx];
            [self.contentViews addObject:contentView];
            [self.bodyView addSubview:contentView];
        }
    }
    self.headerView.titles = titles;
    [self.headerView reload];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    if (selectedIndex >= self.numberOfPages) {
        return;
    }
    if (_selectedIndex != selectedIndex) {
        BOOL shouldMove = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(slidePageView:shouldMoveToPageAtIndex:)]) {
            shouldMove = [_delegate slidePageView:self shouldMoveToPageAtIndex:selectedIndex];
        }
        
        if (shouldMove) {
            _selectedIndex = selectedIndex;
            if (_delegate && [_delegate respondsToSelector:@selector(slidePageView:willMoveToPageAtIndex:)]) {
                [_delegate slidePageView:self willMoveToPageAtIndex:selectedIndex];
            }
            
            [self.headerView setSelectedIndex:selectedIndex];
            [self.bodyView setContentOffset:CGPointMake(self.bodyView.width * selectedIndex, 0) animated:animated];
            
            if (!animated) {
                if (_delegate && [_delegate respondsToSelector:@selector(slidePageView:didMoveToPageAtIndex:)]) {
                    [_delegate slidePageView:self didMoveToPageAtIndex:_selectedIndex];
                }
            }
        }
    }
}

#pragma mark - CDSlidePageHeaderViewDelegate
- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView willSelectButtonAtIndex:(NSUInteger)index {
    _selectedIndex = index;
    CGFloat contentOffsetX = index *self.bodyView.width;
    [self.bodyView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}

- (void)slidePagingHeaderView:(CDSlidePageHeaderView *)headerView didSelectButtonAtIndex:(NSUInteger)index {
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.bodyView == scrollView) {
        if (self.bodyView.tracking || self.bodyView.dragging || self.bodyView.decelerating) {
            CGFloat tabOffsetX = self.bodyView.contentOffset.x / self.bodyView.contentSize.width * self.headerView.width;
            self.headerView.sliderView.centerX = self.headerView.width / self.numberOfPages * 0.5 + tabOffsetX;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.bodyView == scrollView) {
        NSUInteger index = _bodyView.contentOffset.x / _bodyView.width;
        if (_selectedIndex != index) {
            _selectedIndex = index;
            [self.headerView setSelectedIndex:_selectedIndex];
            
            if (_delegate && [_delegate respondsToSelector:@selector(slidePageView:didMoveToPageAtIndex:)]) {
                [_delegate slidePageView:self didMoveToPageAtIndex:_selectedIndex];
            }
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(slidePageView:didMoveToPageAtIndex:)]) {
        [_delegate slidePageView:self didMoveToPageAtIndex:_selectedIndex];
    }
}

@end
