//
//  UIView+CDBorder.m
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import "UIView+CDBorder.h"
#import <objc/runtime.h>

@interface CDBorderLayer : CALayer

@property (nonatomic, assign) CDBorderStyle customBorderStyle;

@property (nonatomic, strong) UIColor *customBorderColor;

@property (nonatomic, assign) CGFloat customBorderWidth;

@property (nonatomic, assign) UIEdgeInsets customBorderInsets;

@end

@implementation CDBorderLayer

- (instancetype)init{
    self = [super init];
    if (self) {
        self.contentsScale = [[UIScreen mainScreen]scale];
        _customBorderStyle = CDBorderStyleNone;
        _customBorderColor = [UIColor blackColor];
        _customBorderWidth = 0.5;
        _customBorderInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)setCustomBorderStyle:(CDBorderStyle)customBorderStyle{
    if (_customBorderStyle != customBorderStyle) {
        _customBorderStyle = customBorderStyle;
        [self setNeedsDisplay];
    }
}

- (void)setCustomBorderColor:(UIColor *)customBorderColor{
    _customBorderColor = customBorderColor;
    [self setNeedsDisplay];
}

- (void)setCustomBorderWidth:(CGFloat)customBorderWidth{
    if (_customBorderWidth != customBorderWidth) {
        _customBorderWidth = customBorderWidth;
        [self setNeedsDisplay];
    }
}

- (void)setCustomBorderInsets:(UIEdgeInsets)customBorderInsets{
    if (_customBorderInsets.top != customBorderInsets.top || _customBorderInsets.left != customBorderInsets.left || _customBorderInsets.bottom != customBorderInsets.bottom || _customBorderInsets.right != customBorderInsets.right) {
        _customBorderInsets = customBorderInsets;
        [self setNeedsDisplay];
    }
}

- (void)drawInContext:(CGContextRef)ctx {
    if (_customBorderStyle == CDBorderStyleNone) {
        return;
    }
    CGContextSetStrokeColorWithColor(ctx, _customBorderColor.CGColor);
    if ((_customBorderStyle & CDBorderStyleTop) == CDBorderStyleTop) {
        CGContextMoveToPoint(ctx, _customBorderInsets.left, _customBorderInsets.top);
        CGContextAddLineToPoint(ctx, self.bounds.size.width - _customBorderInsets.right, _customBorderInsets.top);
    }
    if ((_customBorderStyle & CDBorderStyleLeft) == CDBorderStyleLeft) {
        CGContextMoveToPoint(ctx, _customBorderInsets.left, _customBorderInsets.top);
        CGContextAddLineToPoint(ctx, _customBorderInsets.left, self.bounds.size.height - _customBorderInsets.bottom);
    }
    if ((_customBorderStyle & CDBorderStyleBottom) == CDBorderStyleBottom) {
        CGContextMoveToPoint(ctx, _customBorderInsets.left, self.bounds.size.height - _customBorderInsets.bottom);
        CGContextAddLineToPoint(ctx, self.bounds.size.width - _customBorderInsets.right, self.bounds.size.height - _customBorderInsets.bottom);
    }
    if ((_customBorderStyle & CDBorderStyleRight) == CDBorderStyleRight) {
        CGContextMoveToPoint(ctx, self.bounds.size.width - _customBorderInsets.right, _customBorderInsets.top);
        CGContextAddLineToPoint(ctx, self.bounds.size.width - _customBorderInsets.right, self.bounds.size.height - _customBorderInsets.bottom);
    }
    CGContextSetLineWidth(ctx, _customBorderWidth);
    CGContextStrokePath(ctx);
}

@end

@implementation UIView (CDBorder)

static const void *kBorderLayerIdentifier = &kBorderLayerIdentifier;

- (CDBorderLayer *)cd_borderLayer {
    CDBorderLayer *layer = objc_getAssociatedObject(self, kBorderLayerIdentifier);
    if (!layer) {
        layer = [CDBorderLayer layer];
        [self.layer addSublayer:layer];
        objc_setAssociatedObject(self, kBorderLayerIdentifier, layer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    layer.frame = self.layer.bounds;
    return layer;
}

- (void)cd_setBorderStyle:(CDBorderStyle)style{
    [[self cd_borderLayer] setCustomBorderStyle:style];
}

- (void)cd_setBorderColor:(UIColor *)color{
    [[self cd_borderLayer] setCustomBorderColor:color];
}

- (void)cd_setBorderWidth:(CGFloat)width{
    [[self cd_borderLayer] setCustomBorderWidth:width];
}

- (void)cd_setBorderInsets:(UIEdgeInsets)insets{
    [[self cd_borderLayer] setCustomBorderInsets:insets];
}

@end
