//
//  SCYActivityIndicatorButton.h
//  ProvidentFund
//
//  Created by cdd on 16/12/14.
//  Copyright © 2016年 9188. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCYActivityIndicatorButton : UIButton

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicator;

- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

@end
