//
//  CDUIUtil.m
//  ShangHaiProvidentFund
//
//  Created by Tung on 2019/8/23.
//  Copyright © 2019年 cheng dong. All rights reserved.
//

#import "CDUIUtil.h"
#import "CDAutoHideMessageHUD.h"

void shakeView(UIView* view){
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.1];
    shake.toValue = [NSNumber numberWithFloat:+0.1];
    shake.duration = 0.1;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 4;
    [view.layer addAnimation:shake forKey:@"imageView"];
}

void shakeLeftAndRightWithView(UIView *view) {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.3;
    NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:8];
    for (int idx = 0; idx < 4; idx ++) {
        [values addObject:[NSValue valueWithCGPoint:CGPointMake(view.centerX - 15, view.centerY)]];
        [values addObject:[NSValue valueWithCGPoint:CGPointMake(view.centerX + 15, view.centerY)]];
    }
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}

void callPhoneNum(NSString* phoneNum){
    if ([CDDeviceModel isEqualToString:@"iPhone"]){
        NSURL *telUrl=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
        if ([[UIApplication sharedApplication]canOpenURL:telUrl]) {
            [[UIApplication sharedApplication] openURL:telUrl];
        }else{
            [CDAutoHideMessageHUD showMessage:@"号码有误"];
        }
    }else {
        NSString *strAlert=[NSString stringWithFormat:@"您的设备 %@ 不支持电话功能！",CDDeviceModel];
        [CDAutoHideMessageHUD showMessage:strAlert];
    }
}

@implementation CDUIUtil

+ (CurrentDeviceScreenType)currentScreenType{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        if (CGSizeEqualToSize(screenSize, CGSizeMake(320.0, 480.0)) || CGSizeEqualToSize(screenSize, CGSizeMake(480.0, 320.0))) {
            return CurrentDeviceScreenType_3_5;
        }
        if (CGSizeEqualToSize(screenSize, CGSizeMake(320.0, 568.0)) || CGSizeEqualToSize(screenSize, CGSizeMake(568.0, 320.0))) {
            return CurrentDeviceScreenType_4_0;
        }
        if (CGSizeEqualToSize(screenSize, CGSizeMake(375.0, 667.0)) || CGSizeEqualToSize(screenSize, CGSizeMake(667.0, 375.0))) {
            return CurrentDeviceScreenType_4_7;
        }
        if (CGSizeEqualToSize(screenSize, CGSizeMake(414.0, 736.0)) || CGSizeEqualToSize(screenSize, CGSizeMake(736.0, 414.0))) {
            return CurrentDeviceScreenType_5_5;
        }
        if (CGSizeEqualToSize(screenSize, CGSizeMake(375.0, 812.0)) || CGSizeEqualToSize(screenSize, CGSizeMake(812.0, 375.0))) {
            return CurrentDeviceScreenType_X;
        }
        
        if ((CGSizeEqualToSize(screenSize, CGSizeMake(414.0, 896.0)) || CGSizeEqualToSize(screenSize, CGSizeMake(896.0, 414.0))) && [UIScreen mainScreen].scale == 2) {
            return CurrentDeviceScreenType_6_1;
        }
        
        if ((CGSizeEqualToSize(screenSize, CGSizeMake(414.0, 896.0)) || CGSizeEqualToSize(screenSize, CGSizeMake(896.0, 414.0))) && [UIScreen mainScreen].scale == 3) {
            return CurrentDeviceScreenType_6_5;
        }
    }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return CurrentDeviceScreenType_iPad;
    }
    return CurrentDeviceScreenType_Unspecified;
}

+ (BOOL)hasFringe{
    return [CDUIUtil currentScreenType] == CurrentDeviceScreenType_X || [CDUIUtil currentScreenType] == CurrentDeviceScreenType_6_1 || [CDUIUtil currentScreenType] == CurrentDeviceScreenType_6_5;
}

+ (UIViewController *)findTopModalViewController:(UIViewController *)vc{
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController*)vc visibleViewController];
    }
    return vc;
}

+ (UIViewController *)visibleController{
    UIViewController* appRootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ([appRootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController*)appRootViewController;
        UIViewController *selectController=(UIViewController *)tabBarVC.selectedViewController;
        return [CDUIUtil findTopModalViewController:selectController];
    }else {
        return [CDUIUtil findTopModalViewController:appRootViewController];
    }
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg{
    [self showAlertWithTitle:title message:msg cancelButton:@"取消" cancelHandler:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg cancelButton:(NSString *)cancelTitle cancelHandler:(void(^)(UIAlertAction *))cancel{
    [self showAlertWithTitle:title message:msg cancelButton:cancelTitle cancelHandler:cancel sureButton:nil sureHandler:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg cancelButton:(NSString *)cancelTitle cancelHandler:(void(^)(UIAlertAction *))cancel sureButton:(NSString *)sureTitle sureHandler:(void(^)(UIAlertAction *))sure{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:cancel];
    [alertController addAction:actionCancel];
    
    if (sureTitle && sure) {
        UIAlertAction *actionSure = [UIAlertAction actionWithTitle:sureTitle style:(UIAlertActionStyleDefault) handler:sure];
        [alertController addAction:actionSure];
    }
    
    alertController.popoverPresentationController.sourceView = [self visibleController].view;
    alertController.popoverPresentationController.sourceRect = CGRectMake([self visibleController].view.bounds.size.width*0.5, [self visibleController].view.bounds.size.height, 1.0, 1.0);
    [[self visibleController] presentViewController:alertController animated:YES completion:^{
    }];
}

@end
