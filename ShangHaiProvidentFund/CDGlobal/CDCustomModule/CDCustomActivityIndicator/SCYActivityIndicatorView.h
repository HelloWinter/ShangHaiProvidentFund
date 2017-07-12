//
//  SCYActivityIndicatorView.h
//  ProvidentFund
//
//  Created by cd on 2017/7/4.
//  Copyright © 2017年 9188. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCYActivityIndicatorView : UIView

/**
 开始加载动画
 */
+(void)startAnimating;

/**
 停止加载动画
 */
+(void)stopAnimating;

/**
 加载动画是否正在执行
 */
+(BOOL)isAnimating;

@end
