//
//  CDTitleImageButton.m
//  ProvidentFund
//
//  Created by cdd on 16/5/9.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDTitleImageButton.h"

@implementation CDTitleImageButton

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize titleLabelsize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    if (self.btnType==CDBtnTypeUpImageDownTitle) {
        self.imageEdgeInsets = UIEdgeInsetsMake(5,0,self.frame.size.height*0.5,-titleLabelsize.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(self.frame.size.height*0.5, -self.currentImage.size.width, 0, 0);
    }else if (self.btnType==CDBtnTypeRightImageLeftTitle){
        self.titleEdgeInsets = UIEdgeInsetsMake(0,-self.currentImage.size.width, 0, self.currentImage.size.width);
        self.imageEdgeInsets = UIEdgeInsetsMake(0,titleLabelsize.width,0,-titleLabelsize.width);
    }
}

- (CGFloat)btnPreferenceWidth{
    CGSize titleLabelsize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    if (self.btnType==CDBtnTypeUpImageDownTitle) {
        return titleLabelsize.width>=self.currentImage.size.width ? titleLabelsize.width : self.currentImage.size.width;
    }else if (self.btnType==CDBtnTypeRightImageLeftTitle){
        return titleLabelsize.width+self.currentImage.size.width;
    }
    return 0;
}

@end
