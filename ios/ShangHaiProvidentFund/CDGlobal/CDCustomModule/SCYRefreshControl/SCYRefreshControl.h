//
//  SCYRefreshControl.h
//  CDRefreshControlDemo
//
//  Created by Cheng on 16/10/23.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCYRefreshControl : UIControl

@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

@property (nonatomic, strong) UIColor *lineColor;

/**
 *  初始化方法
 *
 *  @param scrollView 关联的滚动视图
 *
 *  @return self
 */
- (id)initInScrollView:(UIScrollView *)scrollView;

/**
 *  触发刷新
 */
- (void)beginRefreshing;

/**
 *  停止旋转，并且滚动视图回弹到顶部
 */
- (void)endRefreshing;

@end
