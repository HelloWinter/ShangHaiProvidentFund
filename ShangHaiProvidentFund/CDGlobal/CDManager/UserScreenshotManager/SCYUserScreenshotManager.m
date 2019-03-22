//
//  SCYUserScreenshotManager.m
//  ProvidentFund
//
//  Created by cd on 2018/1/17.
//  Copyright © 2018年 9188. All rights reserved.
//

#import "SCYUserScreenshotManager.h"

@interface SCYScreentshotButton : UIButton

@end

@implementation SCYScreentshotButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(3, 3, CGRectGetWidth(contentRect) - 6, CGRectGetHeight(contentRect) - 25 - 3);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(3, CGRectGetHeight(contentRect) - 25, CGRectGetWidth(contentRect) - 6, 25);
}

@end

@interface SCYUserScreenshotManager()<NSCopying>

@property (nonatomic, strong) SCYScreentshotButton *btn;

@end

@implementation SCYUserScreenshotManager

static id _manager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

- (id)copyWithZone:(NSZone *)zone{
    return _manager;
}

#pragma mark - public
+ (SCYUserScreenshotManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}

- (void)startObserve{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidTakeScreenshotNotification:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)stopObserve{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (SCYScreentshotButton *)btn{
    if (!_btn) {
        CGFloat btnWidth = 80;
        CGFloat btnHeight = 125;
        _btn = [[SCYScreentshotButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - btnWidth - 10, [UIScreen mainScreen].bounds.size.height * 0.5 - btnHeight * 0.5, btnWidth, btnHeight)];
        _btn.backgroundColor = [UIColor blackColor];
        _btn.titleLabel.font = [UIFont systemFontOfSize:12];
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_btn setTitle:@"我要反馈" forState:(UIControlStateNormal)];
        [_btn addTarget:self action:@selector(screenShotClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}

- (void)userDidTakeScreenshotNotification:(NSNotification *)notification{
    UIImage *image = [self imageFromScreenshot];
    [self.btn setImage:image forState:(UIControlStateNormal)];
    if (!self.btn.superview) {
        [CDKeyWindow addSubview:self.btn];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.btn removeFromSuperview];
    });
}

- (UIImage *)imageFromScreenshot{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]){
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft){
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight){
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - private
- (void)screenShotClick:(UIButton *)sender{
    if (self.screenshotBlock) {
        self.screenshotBlock(sender.currentImage);
        [self.btn removeFromSuperview];
    }
}

@end


