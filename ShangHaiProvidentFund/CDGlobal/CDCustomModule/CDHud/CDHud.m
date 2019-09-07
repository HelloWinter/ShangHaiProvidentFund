//
//  CDHud.h
//  
//
//  Created by dong cheng on 2018/6/25.
//  Copyright © 2018年 cheng dong. All rights reserved.
//

#import "CDHud.h"

@implementation CDHud

+ (MBProgressHUD *)showDefaultIndicator {
    return [self showIndicatorWithTitle:@"加载中..."];
}

+ (MBProgressHUD *)showIndicatorWithTitle:(NSString *)title {
    return [CDHud showIndicatorWithTitle:title animated:YES];
}

+ (MBProgressHUD *)showIndicatorAddedTo:(UIView *)view title:(NSString *)title {
    return [CDHud showIndicatorAddedTo:view title:title animated:YES];
}

+ (MBProgressHUD *)showIndicatorWithTitle:(NSString *)title animated:(BOOL)animated {
    return [CDHud showIndicatorAddedTo:[[[UIApplication sharedApplication] delegate] window] title:title animated:animated];
}

+ (MBProgressHUD *)showIndicatorAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated {
    return [CDHud showProgressHUDOn:view title:title hideAfter:0 mode:MBProgressHUDModeIndeterminate];
}

+ (void)hideIndicator{
    [self hiddenProgressHUD:[[[UIApplication sharedApplication] delegate] window] forTitle:nil];
}

+ (void)hideIndicatorForTitle:(NSString *)title{
    [self hiddenProgressHUD:[[[UIApplication sharedApplication] delegate] window] forTitle:title];
}

+ (void)hiddenProgressHUD:(UIView *)inView forTitle:(NSString *)title{
    NSEnumerator *subviewsEnum = [inView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subview;
            if (hud.mode == MBProgressHUDModeIndeterminate) {
                if (title && title.length>0) {
                    if([hud.label.text isEqualToString:title]){
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hideAnimated:NO];
                        return;
                    }
                }else{
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hideAnimated:NO];
                }
            }else {
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:NO];
            }
        }
    }
}

+ (MBProgressHUD *)showToast:(NSString *)title {
    return [CDHud showToast:title on:[[[UIApplication sharedApplication] delegate] window] hideAfter:2];
}

+ (MBProgressHUD *)showToast:(NSString *)title hideAfter:(NSTimeInterval)afterSecond {
    return [CDHud showToast:title on:[[[UIApplication sharedApplication] delegate] window] hideAfter:afterSecond];
}

+ (MBProgressHUD *)showToast:(NSString *)title on:(UIView *)view {
    return [CDHud showToast:title on:view hideAfter:2];
}

+ (MBProgressHUD *)showToast:(NSString *)title on:(UIView *)view  hideAfter:(NSTimeInterval)afterSecond {
    return [CDHud showProgressHUDOn:view title:title hideAfter:afterSecond mode:MBProgressHUDModeText];
}

+ (MBProgressHUD *)showProgressHUDOn:(UIView *)view title:(NSString *)title hideAfter:(NSTimeInterval)afterSecond mode:(MBProgressHUDMode)mode {
    if (title.length == 0) {return nil;}
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = mode;
    HUD.contentColor = [UIColor whiteColor];
    HUD.label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    HUD.label.text = title;
    HUD.label.numberOfLines = 5;
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.color = [UIColor colorWithWhite:0.0 alpha:0.7];
    HUD.removeFromSuperViewOnHide = YES;
    if (MBProgressHUDModeText == mode) {
        [HUD hideAnimated:YES afterDelay:afterSecond];
    }
    return HUD;
}

@end
