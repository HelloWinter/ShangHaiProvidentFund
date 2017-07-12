//
//  SCYActivityIndicatorView.m
//  ProvidentFund
//
//  Created by cd on 2017/7/4.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYActivityIndicatorView.h"

#define LAYER_WIDTH_HEIGHT 50.0
#define PATH_LINE_WIDTH 4.0
#define ANIMATION_DURATION 0.6

@interface SCYActivityIndicatorView ()

@property (nonatomic, weak) CALayer *animateLayer;
@property (nonatomic, assign) BOOL animating;

@end

@implementation SCYActivityIndicatorView

+ (SCYActivityIndicatorView*)sharedView {
    static dispatch_once_t once;
    static SCYActivityIndicatorView *sharedView;
    dispatch_once(&once, ^ {
        CGFloat X = ([[UIScreen mainScreen] bounds].size.width-LAYER_WIDTH_HEIGHT)*0.5;
        CGFloat Y = ([[UIScreen mainScreen] bounds].size.height-LAYER_WIDTH_HEIGHT)*0.5;
        sharedView = [[SCYActivityIndicatorView alloc] initWithFrame:CGRectMake(X, Y, LAYER_WIDTH_HEIGHT, LAYER_WIDTH_HEIGHT)];
    });
    return sharedView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:1 alpha:0.9];
        self.layer.cornerRadius=8;
        self.layer.masksToBounds=YES;
        _animating=NO;
        
        CGFloat margin=8;
        CGFloat radius = (LAYER_WIDTH_HEIGHT-margin*2)*0.5;
        CGPoint arcCenter = CGPointMake(LAYER_WIDTH_HEIGHT*0.5, LAYER_WIDTH_HEIGHT*0.5);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:0 endAngle:M_PI*2  clockwise:YES];
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.path = path.CGPath;
        circleLayer.fillColor = [UIColor clearColor].CGColor;
        circleLayer.strokeColor = ColorFromHexRGB(0xf0f0f0).CGColor;
        circleLayer.lineWidth = PATH_LINE_WIDTH;
        circleLayer.frame = self.bounds;
        
        UIBezierPath *animatepath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:0 endAngle:M_PI*0.5  clockwise:YES];
        CAShapeLayer *animateLayer = [CAShapeLayer layer];
        animateLayer.path = animatepath.CGPath;
        animateLayer.fillColor = [UIColor clearColor].CGColor;
        animateLayer.strokeColor = NAVIGATION_COLOR.CGColor;
        animateLayer.lineWidth = PATH_LINE_WIDTH;
        animateLayer.frame = self.bounds;
        animateLayer.lineCap=kCALineCapRound;
        
        [self.layer addSublayer:circleLayer];
        [self.layer addSublayer:animateLayer];
        self.animateLayer=animateLayer;
    }
    return self;
}

#pragma mark - private
- (void)p_showIndicator{
    if (self.animating) {
        return;
    }
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
    [self.animateLayer addAnimation:spinAnimation forKey:@"RotateAniamtionKey"];
    _animating=YES;
}

- (void)p_dismissIndicator{
    [self.animateLayer removeAllAnimations];
    _animating=NO;
    [self removeFromSuperview];
}

#pragma mark - public
+ (void)startAnimating{
    [[SCYActivityIndicatorView sharedView] p_showIndicator];
}

+ (void)stopAnimating{
    [[SCYActivityIndicatorView sharedView] p_dismissIndicator];
}

+ (BOOL)isAnimating{
    return [SCYActivityIndicatorView sharedView].animating;
}

@end
