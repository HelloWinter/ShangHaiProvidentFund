//
//  SCYActivityIndicatorButton.m
//  ProvidentFund
//
//  Created by cdd on 16/12/14.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYActivityIndicatorButton.h"

@implementation SCYActivityIndicatorButton
@synthesize activityIndicator=_activityIndicator;

- (void)dealloc{
    [self.activityIndicator stopAnimating];
}

- (instancetype)init{
    @throw [NSException exceptionWithName:(NSInternalInconsistencyException) reason:@"Must use \"- initWithActivityIndicatorStyle:\"" userInfo:nil];
}

- (instancetype)initWithFrame:(CGRect)frame{
    @throw [NSException exceptionWithName:(NSInternalInconsistencyException) reason:@"Must use \"- initWithActivityIndicatorStyle:\"" userInfo:nil];
}

- (instancetype)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style{
    self = [super init];
    if (self) {
        [self addSubview:self.activityIndicator];
        self.activityIndicator.activityIndicatorViewStyle=style;
    }
    return self;
}

- (UIActivityIndicatorView *)activityIndicator{
    if (_activityIndicator==nil) {
        _activityIndicator=[[UIActivityIndicatorView alloc]init];
    }
    return _activityIndicator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 20.0f;
    self.activityIndicator.right = self.titleLabel.left-space;
    self.activityIndicator.centerY =self.bounds.size.height * 0.5f;
}

@end
