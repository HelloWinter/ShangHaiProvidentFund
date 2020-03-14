//
//  CDHeaderTitleView.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDHeaderTitleView.h"

@interface CDHeaderTitleView ()

@property (strong, nonatomic) UILabel *lbDate;
@property (strong, nonatomic) UILabel *lbDescription;
@property (strong, nonatomic) UILabel *lbAccountChange;

@end

@implementation CDHeaderTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=ColorFromHexRGB(0xf0f5f8);
        [self addSubview:({
            _lbDate=[[UILabel alloc]init];
            _lbDate.textColor=[UIColor blackColor];
            _lbDate.font=[UIFont systemFontOfSize:12];
            _lbDate.textAlignment=NSTextAlignmentCenter;
            _lbDate;
        })];
        [self addSubview:({
            _lbDescription=[[UILabel alloc]init];
            _lbDescription.textColor=[UIColor blackColor];
            _lbDescription.font=[UIFont systemFontOfSize:12];
            _lbDescription.textAlignment=NSTextAlignmentCenter;
            _lbDescription;
        })];
        [self addSubview:({
            _lbAccountChange=[[UILabel alloc]init];
            _lbAccountChange.textColor=[UIColor blackColor];
            _lbAccountChange.font=[UIFont systemFontOfSize:12];
            _lbAccountChange.textAlignment=NSTextAlignmentCenter;
            _lbAccountChange;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat minWidth=self.width*0.25;
    if ([CDUIUtil currentScreenType]==CurrentDeviceScreenType_3_5 | [CDUIUtil currentScreenType]==CurrentDeviceScreenType_4_0) {
        minWidth=75;
    }
    if ([CDUIUtil currentScreenType]==CurrentDeviceScreenType_iPad) {
        minWidth=self.width*0.3;
    }
    if (self.cellLayoutType==CDCellLayoutTypeAccountDetail) {
        _lbDate.frame=CGRectMake(0, 0, minWidth, self.height);
        _lbDescription.frame=CGRectMake(_lbDate.right, 0, self.width-minWidth*2, self.height);
        _lbAccountChange.frame=CGRectMake(_lbDescription.right, 0, minWidth, self.height);
    }else if (self.cellLayoutType==CDCellLayoutTypeLoanDetail){
        _lbDate.frame=CGRectMake(0, 0, self.width-minWidth*2, self.height);
        _lbDescription.frame=CGRectMake(_lbDate.right, 0, minWidth, self.height);
        _lbAccountChange.frame=CGRectMake(_lbDescription.right, 0, minWidth, self.height);
    }
}

#pragma mark - public
- (void)setupWithFirstDesc:(NSString *)first secondDesc:(NSString *)second thirdDesc:(NSString *)third{
    _lbDate.text=first;
    _lbDescription.text=second;
    _lbAccountChange.text=third;
}

@end
