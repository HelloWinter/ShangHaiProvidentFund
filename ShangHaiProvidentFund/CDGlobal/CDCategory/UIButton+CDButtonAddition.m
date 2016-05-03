//
//  UIButton+CDButtonAddition.m
//  CDAppDemo
//
//  Created by cdd on 15/9/10.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "UIButton+CDButtonAddition.h"

@implementation UIButton (CDButtonAddition)

+ (UIButton *)cd_btnWithImageName:(NSString *)imgName Title:(NSString *)title Font:(UIFont *)font Frame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.titleLabel.font=font;
    btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image=[UIImage imageNamed:imgName];
    [btn setImage:image forState:UIControlStateNormal];
    CGSize titleLabelsize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    btn.imageEdgeInsets = UIEdgeInsetsMake(5,0,frame.size.height*0.5,-titleLabelsize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(frame.size.height*0.5, -image.size.width, 0, 0);
    return btn;
}

@end
