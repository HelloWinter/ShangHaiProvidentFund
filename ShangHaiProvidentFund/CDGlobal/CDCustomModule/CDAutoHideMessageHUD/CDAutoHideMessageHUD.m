//
//  CDAutoHideMessageHUD.m
//  CDAppDemo
//
//  Created by Cheng on 15/9/5.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "CDAutoHideMessageHUD.h"
#import <objc/runtime.h>

static const NSTimeInterval kANIMATION_DURATION_SEC = 0.5;
static const NSTimeInterval kVIEW_DURATION = 1.5;
static const CGFloat kVIEW_MAX_WIDTH = 260;
static const CGFloat kVIEW_MAX_HEIGHT = 120;
//static const CGFloat kVIEW_MIN_WIDTH = 60;
static const CGFloat kVIEW_MIN_HEIGHT = 30;
static const CGFloat klbTextFont = 14;

static void * CDAutoHideMessageHUDKey = (void *)@"CDAutoHideMessageHUDKey";

@implementation CDAutoHideMessageHUD

+ (void)showMessage:(NSString *)msg{
    [CDAutoHideMessageHUD showMessage:msg inView:[UIApplication sharedApplication].keyWindow duration:kVIEW_DURATION];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view{
    [CDAutoHideMessageHUD showMessage:msg inView:view duration:kVIEW_DURATION];
}

+ (void)showMessage:(NSString *)msg duration:(NSTimeInterval)duration{
    [CDAutoHideMessageHUD showMessage:msg inView:[UIApplication sharedApplication].keyWindow duration:duration];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view duration:(NSTimeInterval)duration{
    if(view && msg && duration > 0){
        CDNewLabel *label=(CDNewLabel *)objc_getAssociatedObject(view, CDAutoHideMessageHUDKey);
        if (label==nil) {
            label = [[CDNewLabel alloc]init];
            label.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.75f];
            label.textColor=[UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius=5;
            label.layer.masksToBounds=YES;
            label.font=[UIFont systemFontOfSize:klbTextFont];
            label.numberOfLines=0;
            label.lineBreakMode=NSLineBreakByWordWrapping;
            label.alpha=0;
            [view addSubview:label];
            objc_setAssociatedObject(view, CDAutoHideMessageHUDKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [view bringSubviewToFront:label];
        
        CGSize vwSize = view.bounds.size;
        CGRect rect = [msg boundingRectWithSize:CGSizeMake(kVIEW_MAX_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:klbTextFont]} context:nil];
        //        CGFloat lbWidth = MIN(kVIEW_MAX_WIDTH, MAX(kVIEW_MIN_WIDTH, CGRectGetWidth(rect)+20));
        CGFloat lbWidth=CGRectGetWidth(rect)+20;
        CGFloat lbHeight=MIN(kVIEW_MAX_HEIGHT, MAX(kVIEW_MIN_HEIGHT, CGRectGetHeight(rect)+20));
        label.bounds = CGRectMake(0, 0, ceilf(lbWidth), ceilf(lbHeight));
        label.center = CGPointMake(vwSize.width * 0.5f, vwSize.height * 0.5f);
        label.text = msg;
        
        __weak __typeof(UILabel *) weakLabel=label;
        [UIView animateWithDuration:kANIMATION_DURATION_SEC animations:^{
            weakLabel.alpha=1;
        } completion:^(BOOL finished){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:kANIMATION_DURATION_SEC animations:^{
                    weakLabel.alpha=0;
                } completion:^(BOOL finished) {
                    [weakLabel removeFromSuperview];
                    objc_setAssociatedObject(view, CDAutoHideMessageHUDKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                }];
            });
        }];
    }
}

@end

@implementation CDNewLabel

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:CGRectMake(10, 10, self.width-20, self.height-20)];
}

@end
