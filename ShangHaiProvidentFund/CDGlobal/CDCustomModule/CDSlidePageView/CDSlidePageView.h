//
//  CDSlidePageView.h
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDSlidePageHeaderView;

@protocol CDSlidePageViewDataSource;
@protocol CDSlidePageViewDelegate;

@interface CDSlidePageView : UIView

@property (nonatomic, assign, readonly) NSUInteger selectedIndex;

@property (nonatomic, strong, readonly) CDSlidePageHeaderView *headerView;

@property (nonatomic, strong, readonly) UIScrollView *bodyView;

@property (nonatomic, weak) id <CDSlidePageViewDataSource> dataSource;

@property (nonatomic, weak) id <CDSlidePageViewDelegate> delegate;

- (void)reload;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

@end


@protocol CDSlidePageViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInSlidePageView:(CDSlidePageView *)slidePageView;

- (UIView *)slidePageView:(CDSlidePageView *)slidePageView contentViewAtPageIndex:(NSUInteger)index;

- (NSString *)slidePageView:(CDSlidePageView *)slidePageView headerTitleAtPageIndex:(NSUInteger)index;

@end

@protocol CDSlidePageViewDelegate <NSObject>

@optional
- (BOOL)slidePageView:(CDSlidePageView *)slidePageView shouldMoveToPageAtIndex:(NSUInteger)index;

- (void)slidePageView:(CDSlidePageView *)slidePageView willMoveToPageAtIndex:(NSUInteger)index;

- (void)slidePageView:(CDSlidePageView *)slidePageView didMoveToPageAtIndex:(NSUInteger)index;

@end