//
//  SCYActivityIndicator.m
//  SCYActivityIndicatorDemo
//
//  Created by cdd on 16/11/16.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "SCYActivityIndicator.h"

#define LAYER_WIDTH_HEIGHT 20.0
#define PATH_LINE_WIDTH 2.0
#define ANIMATION_DURATION 0.6

@interface SCYActivityIndicator ()

@property (nonatomic, strong) CALayer *backLayer;
@property (nonatomic, assign) BOOL animating;

@end

@implementation SCYActivityIndicator

+ (SCYActivityIndicator*)sharedView {
    static dispatch_once_t once;
    static SCYActivityIndicator *sharedView;
    dispatch_once(&once, ^ {
        CGFloat X = ([[UIScreen mainScreen] bounds].size.width-LAYER_WIDTH_HEIGHT)*0.5;
        CGFloat Y = ([[UIScreen mainScreen] bounds].size.height-LAYER_WIDTH_HEIGHT)*0.5;
        sharedView = [[SCYActivityIndicator alloc] initWithFrame:CGRectMake(X, Y, LAYER_WIDTH_HEIGHT, LAYER_WIDTH_HEIGHT)];
    });
    return sharedView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _animating=NO;
        [self.layer addSublayer:self.backLayer];
//        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (CALayer *)backLayer{
    if (_backLayer==nil) {
        _backLayer=[CALayer layer];
        _backLayer.frame=self.bounds;
        
        CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = CGRectMake(0, 0, LAYER_WIDTH_HEIGHT*0.5, LAYER_WIDTH_HEIGHT);
        gradientLayer1.colors = @[(__bridge id)[UIColor colorWithWhite:0.8 alpha:0.5].CGColor,
                                  (__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor];
        gradientLayer1.startPoint = CGPointMake(0.5, 0);
        gradientLayer1.endPoint = CGPointMake(0.5, 1);
        [_backLayer addSublayer:gradientLayer1];
        
        CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
        gradientLayer2.frame = CGRectMake(LAYER_WIDTH_HEIGHT*0.5, 0, LAYER_WIDTH_HEIGHT*0.5, LAYER_WIDTH_HEIGHT);
        gradientLayer2.colors = @[(__bridge id)[UIColor colorWithWhite:0.8 alpha:0.5].CGColor,
                                  (__bridge id)[UIColor colorWithWhite:0.6 alpha:1].CGColor];
        gradientLayer2.startPoint = CGPointMake(0.5, 0);
        gradientLayer2.endPoint = CGPointMake(0.5, 1);
        [_backLayer addSublayer:gradientLayer2];
        
        CGFloat radius = (LAYER_WIDTH_HEIGHT-PATH_LINE_WIDTH*2)*0.5;
        CGPoint arcCenter = CGPointMake(LAYER_WIDTH_HEIGHT*0.5, LAYER_WIDTH_HEIGHT*0.5);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:M_PI*0.55 endAngle:M_PI*0.45  clockwise:YES];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path.CGPath;
        maskLayer.fillColor = [UIColor clearColor].CGColor;
        maskLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        maskLayer.lineWidth = PATH_LINE_WIDTH;
        maskLayer.frame = _backLayer.bounds;
        maskLayer.lineCap=kCALineCapRound;
        maskLayer.lineJoin=kCALineJoinRound;
        _backLayer.mask=maskLayer;
    }
    return _backLayer;
}

- (void)showIndicator{
    if (self.animating) {
        [self.backLayer removeAllAnimations];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview){
            [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        }
        [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
        
        CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        spinAnimation.fromValue = [NSNumber numberWithInt:0];
        spinAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
        spinAnimation.duration = ANIMATION_DURATION;
        spinAnimation.repeatCount = HUGE_VALF;
        spinAnimation.removedOnCompletion=NO;
        [self.backLayer addAnimation:spinAnimation forKey:@"GradientRotateAniamtion"];
        _animating=YES;
    });
}

- (void)dismissIndicator{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.backLayer removeAllAnimations];
        _animating=NO;
        [self removeFromSuperview];
    });
}

+ (void)startAnimating{
    [[SCYActivityIndicator sharedView] showIndicator];
}

+ (void)stopAnimating{
    [[SCYActivityIndicator sharedView] dismissIndicator];
}

+ (BOOL)isAnimating{
    return [SCYActivityIndicator sharedView].animating;
}

@end
