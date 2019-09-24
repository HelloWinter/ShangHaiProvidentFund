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
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self addSubview:({
            _activityIndicator=[[UIActivityIndicatorView alloc]init];
            _activityIndicator.activityIndicatorViewStyle=style;
            _activityIndicator;
        })];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 20.0f;
    _activityIndicator.right = self.titleLabel.left-space;
    _activityIndicator.centerY =self.bounds.size.height * 0.5f;
}

@end
