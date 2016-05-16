//
//  CDSlidePageHeaderView.h
//  CDAppDemo
//
//  Created by cdd on 16/4/28.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDSlidePageHeaderViewDelegate;

@interface CDSlidePageHeaderView : UIView

@property (nonatomic) CGSize tabSize;

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *sliderColor;

@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, strong, readonly) UIView *sliderView;

@property (nonatomic, weak) id<CDSlidePageHeaderViewDelegate> delegate;

- (void)reload;

@end

@protocol CDSlidePageHeaderViewDelegate <NSObject>

@optional
- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView willSelectButtonAtIndex:(NSUInteger)index;

- (void)slidePageHeaderView:(CDSlidePageHeaderView *)headerView didSelectButtonAtIndex:(NSUInteger)index;

@end
