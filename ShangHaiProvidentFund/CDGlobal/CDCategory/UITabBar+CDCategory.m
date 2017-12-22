//
//  UITabBar+CDCategory.m
//  ProvidentFund
//
//  Created by cdd on 16/7/29.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "UITabBar+CDCategory.h"

#define TabbarItemNums 4.0    //tabbar的数量
#define pointViewBaseTag 4454

@implementation UITabBar (CDCategory)

- (void)showBadgeOnItemIndex:(int)index{
    
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = pointViewBaseTag + index;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    badgeView.layer.cornerRadius = badgeView.frame.size.width/2;
    
    [self addSubview:badgeView];
}

- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == pointViewBaseTag+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
