//
//  SCYRefreshControl.m
//  CDRefreshControlDemo
//
//  Created by Cheng on 16/10/23.
//  Copyright © 2016年 Cheng. All rights reserved.
//

#import "SCYRefreshControl.h"

static const CGFloat kControlHeight=70.0;
static const CGFloat kCircleLayerRadius=13.0;

#define kOpenedViewHeight   70

@interface SCYRefreshControl(){
    BOOL willEnd;
    BOOL notTracking;
    BOOL _ignoreInset;
    BOOL _ignoreOffset;
    BOOL _didSetInset;
    BOOL _hasSectionHeaders;
}

/**
 *  需要滑动多大距离才能松开
 */
@property (nonatomic, assign) CGFloat pullDistance;

/**
 *  标志是否正在刷新
 */
@property (nonatomic, readwrite) BOOL refreshing;

/**
 *  关联的scrollview
 */

@property (nonatomic, assign) UIScrollView *scrollView;

/**
 *  scrollview原始ContentInset
 */
@property (nonatomic, assign) UIEdgeInsets originalContentInset;

/**
 *  scrollview原始ContentOffset
 */
@property (nonatomic, assign) CGPoint originalContentOffset;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation SCYRefreshControl

- (void)dealloc{
    //    CDLog(@"self.scrollView被释放");
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView removeObserver:self forKeyPath:@"contentInset"];
    self.scrollView=nil;
}

- (id)initInScrollView:(UIScrollView *)scrollView{
    self = [super initWithFrame:CGRectMake(0, -(kControlHeight+scrollView.contentInset.top), scrollView.bounds.size.width, kControlHeight)];
    if (self) {
        //        self.backgroundColor=[UIColor redColor];
        self.lineColor=NAVIGATION_COLOR;//[UIColor lightGrayColor]
        self.scrollView = scrollView;
        self.originalContentInset = scrollView.contentInset;
        self.originalContentOffset = scrollView.contentOffset;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.pullDistance = kControlHeight;
        [scrollView addSubview:self];
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
        [self.layer addSublayer:self.shapeLayer];
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor=lineColor;
    _circleLayer.strokeColor=lineColor.CGColor;
    _shapeLayer.strokeColor=lineColor.CGColor;
}

- (CAShapeLayer *)circleLayer{
    if(_circleLayer == nil){
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.bounds=CGRectMake(0, 0, kCircleLayerRadius*2, kCircleLayerRadius*2);
        _circleLayer.position=CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5+3);
        _circleLayer.anchorPoint=CGPointMake(0.5, 0.5);
//        _circleLayer.strokeColor=ColorFromHexRGB(0x0564da).CGColor;
        _circleLayer.strokeColor=self.lineColor.CGColor;
        _circleLayer.fillColor=[UIColor clearColor].CGColor;
        _circleLayer.lineWidth=1;
        _circleLayer.lineCap=kCALineCapRound;
        UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(_circleLayer.bounds.size.width*0.5, _circleLayer.bounds.size.height*0.5) radius:kCircleLayerRadius startAngle:M_PI_2 endAngle:M_PI*0.43 clockwise:YES];
        _circleLayer.strokeEnd=0.0;
        _circleLayer.path=path.CGPath;
    }
    return _circleLayer;
}

- (CAShapeLayer *)shapeLayer{
    if(_shapeLayer == nil){
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.bounds=CGRectMake(0, 0, 20, 17);
        _shapeLayer.position=CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5+2);
//        _shapeLayer.strokeColor=ColorFromHexRGB(0x0564da).CGColor;
        _shapeLayer.strokeColor=self.lineColor.CGColor;
        _shapeLayer.fillColor=[UIColor clearColor].CGColor;
        _shapeLayer.lineWidth=1;
        _shapeLayer.lineCap=kCALineCapRound;
        _shapeLayer.lineJoin=kCALineJoinRound;
        
        UIBezierPath *path=[UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(12, 17)];
        [path addLineToPoint:CGPointMake(16, 17)];
        [path addLineToPoint:CGPointMake(16, 10)];
        [path addLineToPoint:CGPointMake(20, 10)];
        [path addLineToPoint:CGPointMake(10, 0)];
        [path addLineToPoint:CGPointMake(0, 10)];
        [path addLineToPoint:CGPointMake(4, 10)];
        [path addLineToPoint:CGPointMake(4, 17)];
        [path addLineToPoint:CGPointMake(9, 17)];
        [path addLineToPoint:CGPointMake(12.5, 10.5)];//微调
        
        [path addArcWithCenter:CGPointMake(_shapeLayer.bounds.size.width*0.5, _shapeLayer.bounds.size.width*0.5-1) radius:_shapeLayer.bounds.size.width*0.14 startAngle:0.0 endAngle:-M_PI*2 clockwise:NO];
        
        _shapeLayer.strokeEnd=0.0;
        _shapeLayer.path=path.CGPath;
    }
    return _shapeLayer;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [self.scrollView removeObserver:self forKeyPath:@"contentInset"];
        self.scrollView=nil;
    }
}

#pragma mark - public
- (void)beginRefreshing{
    if (!_refreshing) {
        self.originalContentInset = self.scrollView.contentInset;
        self.originalContentOffset = self.scrollView.contentOffset;
        [self.scrollView setContentOffset:CGPointMake(0, -self.pullDistance-_originalContentInset.top) animated:YES];
        self.refreshing = YES;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = @(M_PI * 2.0);
        rotationAnimation.duration = 0.8f;
        rotationAnimation.repeatCount = MAXFLOAT;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [_circleLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [CATransaction commit];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)endRefreshing{
    if (_refreshing) {
        willEnd = YES;
        _refreshing = NO;
        __block UIScrollView *blockScrollView = self.scrollView;
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _ignoreInset = YES;
            blockScrollView.contentInset = self.originalContentInset;
            _ignoreInset = NO;
        } completion:^(BOOL finished) {
            blockScrollView.contentOffset=self.originalContentOffset;
            willEnd = NO;
            notTracking = NO;
            [_circleLayer removeAllAnimations];
            _circleLayer.strokeEnd=_shapeLayer.strokeEnd=0.0;
            _circleLayer.transform = CATransform3DIdentity;
        }];
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentInset"]) {
        if (!_ignoreInset) {
            self.originalContentInset = [[change objectForKey:@"new"] UIEdgeInsetsValue];
            self.frame = CGRectMake(0, -(kControlHeight + self.scrollView.contentInset.top), self.scrollView.frame.size.width, kControlHeight);
        }
        return;
    }
    
    if (!self.enabled || _ignoreOffset) {
        return;
    }
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change objectForKey:@"new"]CGPointValue];
        CGFloat offset=contentOffset.y + _originalContentInset.top;
        if (_refreshing) {
            if (offset != 0) {
                _ignoreInset = YES;
                _ignoreOffset = YES;
                if (offset < 0) {
                    if (offset >= -kOpenedViewHeight) {
                        if (!self.scrollView.dragging) {
                            if (!_didSetInset) {
                                _didSetInset = YES;
                                _hasSectionHeaders = NO;
                                if([self.scrollView isKindOfClass:[UITableView class]]){
                                    for (int i = 0; i < [(UITableView *)self.scrollView numberOfSections]; ++i) {
                                        if ([(UITableView *)self.scrollView rectForHeaderInSection:i].size.height) {
                                            _hasSectionHeaders = YES;
                                            break;
                                        }
                                    }
                                }
                            }
                            if (_hasSectionHeaders) {
                                [self.scrollView setContentInset:UIEdgeInsetsMake(MIN(-offset, kOpenedViewHeight) + self.originalContentInset.top, self.originalContentInset.left, self.originalContentInset.bottom, self.originalContentInset.right)];
                            } else {
                                [self.scrollView setContentInset:UIEdgeInsetsMake(kOpenedViewHeight + self.originalContentInset.top, self.originalContentInset.left, self.originalContentInset.bottom, self.originalContentInset.right)];
                            }
                        } else if (_didSetInset && _hasSectionHeaders) {
                            [self.scrollView setContentInset:UIEdgeInsetsMake(-offset + self.originalContentInset.top, self.originalContentInset.left, self.originalContentInset.bottom, self.originalContentInset.right)];
                        }
                        [self.scrollView setContentOffset:CGPointMake(0, -kControlHeight) animated:NO];
                    }
                } else if (_hasSectionHeaders) {
                    [self.scrollView setContentInset:self.originalContentInset];
                }
                _ignoreInset = NO;
                _ignoreOffset = NO;
            }
            return;
        }
        
        if (offset < 0) {
            CGFloat progress = MAX(0.0, MIN(fabs(offset)/self.pullDistance, 1.0));
            if (!willEnd && !_refreshing) {
                _shapeLayer.strokeEnd=_circleLayer.strokeEnd=progress;
            }
            CGFloat diff = fabs(offset) - self.pullDistance;
            if (diff > 0) {
                if (!self.scrollView.isTracking) {
                    if (!notTracking && !_refreshing) {
                        notTracking = YES;
                        _refreshing = YES;
                        _shapeLayer.strokeEnd=_circleLayer.strokeEnd=1;
                        
                        [CATransaction begin];
                        [CATransaction setDisableActions:YES];
                        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                        rotationAnimation.toValue = @(M_PI * 2.0);
                        rotationAnimation.duration = 0.8f;
                        rotationAnimation.repeatCount = MAXFLOAT;
                        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                        [_circleLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
                        [CATransaction commit];
                        
                        [self sendActionsForControlEvents:UIControlEventValueChanged];
                    }
                }
                if (!_refreshing && self.scrollView.isDragging) {
                    _circleLayer.transform = CATransform3DMakeRotation(M_PI * (diff*2/180), 0, 0, 1);
                }
            }
        }
    }
}

@end
