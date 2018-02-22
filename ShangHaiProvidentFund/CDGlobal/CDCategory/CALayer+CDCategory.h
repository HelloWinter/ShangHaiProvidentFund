//
//  CALayer+CDCategory.h
//  ShangHaiProvidentFund
//
//  Created by cd on 2018/2/22.
//  Copyright © 2018年 cheng dong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (CDCategory)

- (UIImage *)cd_capture;

/**
 图层捕捉

 @param size 大小
 @param opaque 是否不透明
 @return 图层图片
 */
- (UIImage *)cd_captureWithSize:(CGSize)size opaque:(BOOL)opaque;

@end
