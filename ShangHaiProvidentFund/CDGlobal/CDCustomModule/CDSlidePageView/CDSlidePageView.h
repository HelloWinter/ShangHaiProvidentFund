//
//  CDSlidePageView.h
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDSlidePageHeaderView.h"

@protocol CDSlidePageViewDataSource;
@protocol CDSlidePageViewDelegate;

@interface CDSlidePageView : UIView

/**
 头部选项卡
 */
@property (nonatomic, strong, readonly) CDSlidePageHeaderView *headerView;

/**
 可滑动的载体
 */
@property (nonatomic, strong, readonly) UIScrollView *bodyView;

/**
 数据源
 */
@property (nonatomic, weak) id <CDSlidePageViewDataSource> dataSource;

/**
 数据代理
 */
@property (nonatomic, weak) id <CDSlidePageViewDelegate> delegate;

/**
 选中的index
 */
@property (nonatomic, assign) NSUInteger selectIndex;

/**
 头部视图高度 Default:44
 */
@property (nonatomic, assign) CGFloat headerViewHeight;

/**
 刷新
 */
- (void)reload;

@end

@protocol CDSlidePageViewDataSource <NSObject>

/**
 可滑动视图的个数
 */
- (NSUInteger)numberOfPagesInSlidePageView:(CDSlidePageView *)slidePageView;

/**
 滑动视图的子视图
 */
- (UIView *)slidePageView:(CDSlidePageView *)slidePageView contentViewAtPageIndex:(NSUInteger)index;

/**
 滑动视图与选项卡的对应Title
 */
- (NSString *)slidePageView:(CDSlidePageView *)slidePageView headerTitleAtPageIndex:(NSUInteger)index;

@optional
- (NSString *)slidePageView:(CDSlidePageView *)slidePageView badgeNumbersAtPageIndex:(NSUInteger)index;

@end

@protocol CDSlidePageViewDelegate <NSObject>

@optional
/**
 滑动到指定页面后调用
 */
- (void)slidePageView:(CDSlidePageView *)slidePageView didMoveToPageAtIndex:(NSUInteger)index;

@end

