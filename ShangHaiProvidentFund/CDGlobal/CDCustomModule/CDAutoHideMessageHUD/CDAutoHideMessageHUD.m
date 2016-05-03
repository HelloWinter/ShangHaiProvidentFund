//
//  CDAutoHideMessageHUD.m
//  CDAppDemo
//
//  Created by Cheng on 15/9/5.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "CDAutoHideMessageHUD.h"
#import <objc/runtime.h>

#define ANIMATION_DURATION_SEC 0.5
#define VIEW_MAX_WIDTH 260
#define VIEW_MAX_HEIGHT 120
#define VIEW_MIN_WIDTH 60
#define VIEW_MIN_HEIGHT 30

static char CDAutoHideMessageHUDKey;

@implementation CDAutoHideMessageHUD

+ (void)showMessage:(NSString *)msg{
    [CDAutoHideMessageHUD showMessage:msg inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view{
    [CDAutoHideMessageHUD showMessage:msg inView:view duration:1.5f];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view duration:(NSTimeInterval)duration{
    if(view && msg && duration > 0){
        CDNewLabel *label=(CDNewLabel *)objc_getAssociatedObject(view, &CDAutoHideMessageHUDKey);
        if (label==nil) {
            label = [[CDNewLabel alloc]init];
            label.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.75f];
            label.textColor=[UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.cornerRadius=5;
            label.clipsToBounds=YES;
            label.font=[UIFont systemFontOfSize:14];
            label.numberOfLines=0;
            label.lineBreakMode=NSLineBreakByWordWrapping;
            label.alpha=0;
            [view addSubview:label];
            objc_setAssociatedObject(view, &CDAutoHideMessageHUDKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [view bringSubviewToFront:label];
        
        CGSize lbSize=CGSizeZero;
        CGRect rect = [msg boundingRectWithSize:CGSizeMake(VIEW_MAX_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} context:nil];
        lbSize=CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
        lbSize.width+=20;
//        lbSize.width = MIN(VIEW_MAX_WIDTH, MAX(VIEW_MIN_WIDTH, lbSize.width+20));
        lbSize.height = MIN(VIEW_MAX_HEIGHT, MAX(VIEW_MIN_HEIGHT, lbSize.height+20));
        label.bounds = CGRectMake(0, 0, ceilf(lbSize.width), ceilf(lbSize.height));
        label.center = CGPointMake(view.bounds.size.width * 0.5f, view.bounds.size.height * 0.75f);
        label.text = msg;
        
        __weak __typeof(UILabel *) weakLabel=label;
        [UIView animateWithDuration:ANIMATION_DURATION_SEC animations:^{
            weakLabel.alpha=1;
        } completion:^(BOOL finished){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:ANIMATION_DURATION_SEC animations:^{
                    weakLabel.alpha=0;
                } completion:^(BOOL finished) {
                    [weakLabel removeFromSuperview];
                    objc_setAssociatedObject(view, &CDAutoHideMessageHUDKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
