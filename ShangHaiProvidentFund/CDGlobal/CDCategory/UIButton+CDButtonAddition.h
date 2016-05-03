//
//  UIButton+CDButtonAddition.h
//  CDAppDemo
//
//  Created by cdd on 15/9/10.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CDButtonAddition)

/**
 *  快速生成上图下标题的按钮
 *
 *  @param imgName 图片名
 *  @param title   按钮标题
 *  @param font    按钮标题字体
 *  @param frame   button的frame
 *
 *  @return 图片在上标题在下的按钮
 */
+ (UIButton *)cd_btnWithImageName:(NSString *)imgName Title:(NSString *)title Font:(UIFont *)font Frame:(CGRect)frame;

@end
