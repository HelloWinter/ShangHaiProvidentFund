//
//  SCYButtonTableFooterView.h
//  ProvidentFund
//
//  Created by cdd on 15/12/24.
//  Copyright © 2015年 9188. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FooterButtonClickBlock)(UIButton *);

@interface SCYButtonTableFooterView : UIView

@property (nonatomic, copy) FooterButtonClickBlock buttonClickBlock;

- (void)setupBtnFrame:(CGRect)frame;

- (void)setupBtnTitle:(NSString *)title;

- (void)setupBtnBackgroundColor:(UIColor *)color;

- (void)activityIndicatorStartAnimate;

- (void)activityIndicatorStopAnimate;

@end
