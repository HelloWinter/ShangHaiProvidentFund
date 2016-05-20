//
//  CDTitleImageButton.h
//  ProvidentFund
//
//  Created by cdd on 16/5/9.
//  Copyright © 2016年 9188. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CDBtnType) {
    /**
     *  图片在上，文字在下
     */
    CDBtnTypeUpImageDownTitle,
    /**
     *  图片在右，文字在左
     */
    CDBtnTypeRightImageLeftTitle,
};

@interface CDTitleImageButton : UIButton

@property (nonatomic, assign) CDBtnType btnType;

/**
 *  button偏好宽度
 */
- (CGFloat)btnPreferenceWidth;

@end
