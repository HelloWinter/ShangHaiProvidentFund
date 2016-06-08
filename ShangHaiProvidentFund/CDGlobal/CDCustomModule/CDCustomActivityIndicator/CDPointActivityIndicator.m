//
//  CDPointActivityIndicator.m
//  CDAppDemo
//
//  Created by cdd on 15/10/28.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "CDPointActivityIndicator.h"

static const NSTimeInterval kANIMATION_DURATION_SECS = 0.5;
static const CGFloat kVIEW_WIDTH_HEIGHT = 60;

@interface CDPointActivityIndicator (){
    NSTimer *_timer;
}

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) float dotRadius;
@property (nonatomic, assign) int stepNumber;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) CGRect firstPoint, secondPoint, thirdPoint, fourthPoint;
@property (nonatomic, strong) CALayer *firstDot, *secondDot, *thirdDot;

@end

@implementation CDPointActivityIndicator

+ (CDPointActivityIndicator*)sharedView {
    static dispatch_once_t once;
    static CDPointActivityIndicator *sharedView;
    dispatch_once(&once, ^ {
        CGFloat X = ([[UIScreen mainScreen] bounds].size.width-kVIEW_WIDTH_HEIGHT)*0.5;
        CGFloat Y = ([[UIScreen mainScreen] bounds].size.height-kVIEW_WIDTH_HEIGHT)*0.5;
        sharedView = [[CDPointActivityIndicator alloc] initWithFrame:CGRectMake(X, Y, kVIEW_WIDTH_HEIGHT, kVIEW_WIDTH_HEIGHT)];
    });
    return sharedView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isAnimating=NO;
        _stepNumber = 0;
        self.color = [UIColor colorWithRed:241/255.0f green:196/255.0f blue:15/255.0f alpha:1.0];
        _dotRadius = frame.size.height <= frame.size.width ? frame.size.width/12 : frame.size.height/12;
        _firstPoint = CGRectMake(frame.size.width*0.25-_dotRadius, frame.size.height*0.5-_dotRadius, 2*_dotRadius, 2*_dotRadius);
        _secondPoint = CGRectMake(frame.size.width*0.5-_dotRadius, frame.size.height*0.25-_dotRadius, 2*_dotRadius, 2*_dotRadius);
        _thirdPoint = CGRectMake(3*frame.size.width*0.25-_dotRadius, frame.size.height*0.5-_dotRadius, 2*_dotRadius, 2*_dotRadius);
        _fourthPoint = CGRectMake(frame.size.width*0.5-_dotRadius, 3*frame.size.height*0.25-_dotRadius, 2*_dotRadius, 2*_dotRadius);
        [self setUpLayer];
    }
    return self;
}

- (void)setUpLayer{
    //上下
    _firstDot = [CALayer layer];
    [_firstDot setBackgroundColor:self.color.CGColor];
    [_firstDot setCornerRadius:_dotRadius];
    [_firstDot setMasksToBounds:YES];
    [_firstDot setBounds:CGRectMake(0.0f, 0.0f, _dotRadius*2, _dotRadius*2)];
    _firstDot.frame = _fourthPoint;
    
    //左右
    _secondDot = [CALayer layer];
    [_secondDot setBackgroundColor:self.color.CGColor];
    [_secondDot setCornerRadius:_dotRadius];
    [_secondDot setMasksToBounds:YES];
    [_secondDot setBounds:CGRectMake(0.0f, 0.0f, _dotRadius*2, _dotRadius*2)];
    _secondDot.frame = _firstPoint;
    
    //顺时针
    _thirdDot = [CALayer layer];
    [_thirdDot setBackgroundColor:self.color.CGColor];
    [_thirdDot setCornerRadius:_dotRadius];
    [_thirdDot setMasksToBounds:YES];
    [_thirdDot setBounds:CGRectMake(0.0f, 0.0f, _dotRadius*2, _dotRadius*2)];
    _thirdDot.frame = _thirdPoint;
    
    [self.layer addSublayer:_firstDot];
    [self.layer addSublayer:_secondDot];
    [self.layer addSublayer:_thirdDot];
}

- (void)showIndicator{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview){
            [[[UIApplication sharedApplication] keyWindow] addSubview:self];
            [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
        }
        if (!_isAnimating){
            _isAnimating = YES;
            _timer = [NSTimer timerWithTimeInterval:kANIMATION_DURATION_SECS target:self selector:@selector(animateNextStep) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
            [_timer fire];
        }
    });
}

- (void)dismissIndicator{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self timerInvalidate];
        _stepNumber = 0;
        _firstDot.frame = _fourthPoint;
        _secondDot.frame = _firstPoint;
        _thirdDot.frame = _thirdPoint;
        _isAnimating=NO;
        [self removeFromSuperview];
    });
}

- (void)timerInvalidate{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer=nil;
    }
}

-(void)animateNextStep{
    switch (_stepNumber){
        case 0:
            [CATransaction begin];
            [CATransaction setAnimationDuration:kANIMATION_DURATION_SECS];
            _firstDot.frame = _secondPoint;
            _thirdDot.frame = _fourthPoint;
            [CATransaction commit];
            break;
        case 1:
            [CATransaction begin];
            [CATransaction setAnimationDuration:kANIMATION_DURATION_SECS];
            _secondDot.frame = _thirdPoint;
            _thirdDot.frame = _firstPoint;
            [CATransaction commit];
            break;
        case 2:
            [CATransaction begin];
            [CATransaction setAnimationDuration:kANIMATION_DURATION_SECS];
            _firstDot.frame = _fourthPoint;
            _thirdDot.frame = _secondPoint;
            [CATransaction commit];
            break;
        case 3:
            [CATransaction begin];
            [CATransaction setAnimationDuration:kANIMATION_DURATION_SECS];
            _secondDot.frame = _firstPoint;
            _thirdDot.frame = _thirdPoint;
            [CATransaction commit];
            break;
        case 4:
            [CATransaction begin];
            [CATransaction setAnimationDuration:kANIMATION_DURATION_SECS];
            _firstDot.frame = _secondPoint;
            _thirdDot.frame = _fourthPoint;
            [CATransaction commit];
            _stepNumber = 0;
        default:
            break;
    }
    _stepNumber++;
}

+ (void)startAnimating{
    [[CDPointActivityIndicator sharedView] showIndicator];
}

+ (void)stopAnimating{
    [[CDPointActivityIndicator sharedView] dismissIndicator];
}

+ (BOOL)isAnimating{
    return [CDPointActivityIndicator sharedView].isAnimating;
}

@end
