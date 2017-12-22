//
//  CDSlidePageView.m
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import "CDSlidePageView.h"


@interface CDSlidePageView ()<UIScrollViewDelegate,CDSlidePageHeaderViewDelegate>

@property (nonatomic) NSUInteger numberOfPages;
@property (nonatomic, strong) NSMutableArray *contentViews;

@end

@implementation CDSlidePageView
@synthesize headerView=_headerView;
@synthesize bodyView=_bodyView;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _headerViewHeight=44;
        _selectIndex=0;
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
    self.headerView.frame = CGRectMake(0, 0, self.width, self.headerViewHeight);
    self.bodyView.frame = CGRectMake(0, self.headerView.bottom, self.width, self.height - self.headerViewHeight);
    self.bodyView.contentSize = CGSizeMake(self.numberOfPages * self.bodyView.width, self.bodyView.height);
    for (int idx = 0; idx < self.contentViews.count; idx ++) {
        UIView *contentView  = self.contentViews[idx];
        contentView.frame = CGRectMake(idx * self.bodyView.width, 0, self.bodyView.width, self.bodyView.height);
    }
    [self.headerView setSelectedIndex:_selectIndex];
    [self slidePageHeaderView:self.headerView willSelectButtonAtIndex:_selectIndex];
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
    if (self.numberOfPages==0) { return; }
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:self.numberOfPages];
    NSMutableArray *badges = [[NSMutableArray alloc] initWithCapacity:self.numberOfPages];
    
    for (int idx = 0; idx < self.numberOfPages; idx ++) {
        if (_dataSource && [_dataSource respondsToSelector:@selector(slidePageView:headerTitleAtPageIndex:)]) {
            NSString *title = [_dataSource slidePageView:self headerTitleAtPageIndex:idx];
            [titles addObject:title];
        }
        if (_dataSource && [_dataSource respondsToSelector:@selector(slidePageView:badgeNumbersAtPageIndex:)]) {
            NSString *badge = [_dataSource slidePageView:self badgeNumbersAtPageIndex:idx];
            [badges addObject:badge];
        }
        if (_dataSource && [_dataSource respondsToSelector:@selector(slidePageView:contentViewAtPageIndex:)]) {
            UIView *contentView = [_dataSource slidePageView:self contentViewAtPageIndex:idx];
            [self.contentViews addObject:contentView];
            [self.bodyView addSubview:contentView];
        }
    }
    self.headerView.itemTitles = titles;
    self.headerView.badgeNumbers = badges;
    [self.headerView reload];
}

- (void)setSelectIndex:(NSUInteger)selectIndex{
    if (selectIndex > self.numberOfPages) { return; }
    if (_selectIndex!=selectIndex) {
        _selectIndex=selectIndex;
        [self.headerView setSelectedIndex:_selectIndex];
    }
}

#pragma mark - CDSlidePageHeaderViewDelegate
- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView willSelectButtonAtIndex:(NSUInteger)index{
    
}

- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView didSelectButtonAtIndex:(NSUInteger)index {
    _selectIndex = index;
    CGFloat contentOffsetX = index *self.bodyView.width;
    [self.bodyView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.bodyView == scrollView) {
        if (self.bodyView.tracking || self.bodyView.dragging || self.bodyView.decelerating) {
            CGFloat tabOffsetX = (self.bodyView.contentOffset.x / self.bodyView.contentSize.width) * self.headerView.contentSize.width;
            self.headerView.sliderView.centerX = self.headerView.contentSize.width / self.numberOfPages * 0.5 + tabOffsetX;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.bodyView == scrollView) {
        NSUInteger index = _bodyView.contentOffset.x / _bodyView.width;
        if (_selectIndex != index) {
            _selectIndex = index;
            [self.headerView setSelectedIndex:_selectIndex];
            if (_delegate && [_delegate respondsToSelector:@selector(slidePageView:didMoveToPageAtIndex:)]) {
                [_delegate slidePageView:self didMoveToPageAtIndex:_selectIndex];
            }
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.bodyView == scrollView) {
        if (_delegate && [_delegate respondsToSelector:@selector(slidePageView:didMoveToPageAtIndex:)]) {
            [_delegate slidePageView:self didMoveToPageAtIndex:_selectIndex];
        }
    }
}

@end

