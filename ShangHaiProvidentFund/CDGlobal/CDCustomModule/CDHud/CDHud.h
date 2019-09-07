//
//  CDHud.h
//  
//
//  Created by dong cheng on 2018/6/25.
//  Copyright © 2018年 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface CDHud : NSObject

+ (nullable MBProgressHUD *)showDefaultIndicator;
+ (nullable MBProgressHUD *)showIndicatorWithTitle:(nullable NSString *)title;
+ (nullable MBProgressHUD *)showIndicatorAddedTo:(nullable UIView *)view title:(nullable NSString *)title;
+ (void)hideIndicator;
+ (void)hideIndicatorForTitle:(NSString *_Nullable)title;

+ (nullable MBProgressHUD *)showToast:(nullable NSString *)title;
+ (nullable MBProgressHUD *)showToast:(nonnull NSString *)title hideAfter:(NSTimeInterval)afterSecond;
+ (nullable MBProgressHUD *)showToast:(nullable NSString *)title on:(nullable UIView *)view;

@end
