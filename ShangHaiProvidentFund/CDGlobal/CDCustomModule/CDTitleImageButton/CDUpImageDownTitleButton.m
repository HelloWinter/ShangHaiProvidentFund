//
//  CDUpImageDownTitleButton.m
//  ProvidentFund
//
//  Created by cdd on 16/10/19.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDUpImageDownTitleButton.h"

#define topMargin 7.0

@implementation CDUpImageDownTitleButton

- (instancetype)init{
    self =[super init];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        _imgPercentage=0.7;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        _imgPercentage=0.7;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    //    CDLog(@"imageRect%@",NSStringFromCGRect(contentRect));
    return CGRectMake(0, topMargin, CGRectGetWidth(contentRect), (CGRectGetHeight(contentRect)-topMargin)*_imgPercentage);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//    CDLog(@"titleRect%@",NSStringFromCGRect(contentRect));
    return CGRectMake(0, (CGRectGetHeight(contentRect)-topMargin)*_imgPercentage+topMargin, CGRectGetWidth(contentRect), (CGRectGetHeight(contentRect)-topMargin)*(1-_imgPercentage));
}

@end
