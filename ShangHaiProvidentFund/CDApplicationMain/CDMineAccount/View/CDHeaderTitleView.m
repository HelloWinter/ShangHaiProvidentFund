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

- (instancetype)init{
    self =[super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor=ColorFromHexRGB(0xf0f5f8);
    [self addSubview:self.lbDate];
    [self addSubview:self.lbDescription];
    [self addSubview:self.lbAccountChange];
}

- (UILabel *)lbDate{
    if (_lbDate==nil) {
        _lbDate=[[UILabel alloc]init];
        _lbDate.textColor=[UIColor blackColor];
        _lbDate.font=[UIFont systemFontOfSize:12];
        _lbDate.textAlignment=NSTextAlignmentCenter;
    }
    return _lbDate;
}

- (UILabel *)lbDescription{
    if (_lbDescription==nil) {
        _lbDescription=[[UILabel alloc]init];
        _lbDescription.textColor=[UIColor blackColor];
        _lbDescription.font=[UIFont systemFontOfSize:12];
        _lbDescription.textAlignment=NSTextAlignmentCenter;
    }
    return _lbDescription;
}

- (UILabel *)lbAccountChange{
    if (_lbAccountChange==nil) {
        _lbAccountChange=[[UILabel alloc]init];
        _lbAccountChange.textColor=[UIColor blackColor];
        _lbAccountChange.font=[UIFont systemFontOfSize:12];
        _lbAccountChange.textAlignment=NSTextAlignmentCenter;
    }
    return _lbAccountChange;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.cellLayoutType==CDCellLayoutTypeAccountDetail) {
        self.lbDate.frame=CGRectMake(0, 0, 70, self.height);
        self.lbDescription.frame=CGRectMake(self.lbDate.right, 0, self.width-130, self.height);
        self.lbAccountChange.frame=CGRectMake(self.lbDescription.right, 0, 60, self.height);
    }else if (self.cellLayoutType==CDCellLayoutTypeLoanDetail){
        self.lbDate.frame=CGRectMake(0, 0, self.width-130, self.height);
        self.lbDescription.frame=CGRectMake(self.lbDate.right, 0, 70, self.height);
        self.lbAccountChange.frame=CGRectMake(self.lbDescription.right, 0, 60, self.height);
    }
}

- (void)setupWithFirstDesc:(NSString *)first secondDesc:(NSString *)second thirdDesc:(NSString *)third{
    self.lbDate.text=first;
    self.lbDescription.text=second;
    self.lbAccountChange.text=third;
}

@end
