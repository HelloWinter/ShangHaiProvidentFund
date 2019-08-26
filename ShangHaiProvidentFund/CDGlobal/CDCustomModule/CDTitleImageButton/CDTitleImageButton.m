//
//  CDTitleImageButton.m
//  ProvidentFund
//
//  Created by cdd on 16/10/19.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDTitleImageButton.h"

@implementation CDTitleImageButton

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize titleLabelsize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.titleEdgeInsets = UIEdgeInsetsMake(0,-self.currentImage.size.width, 0, self.currentImage.size.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleLabelsize.width,0,-titleLabelsize.width);
}

- (CGFloat)preferenceWidth{
    CGSize titleLabelsize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    return titleLabelsize.width+self.currentImage.size.width;
}

@end
