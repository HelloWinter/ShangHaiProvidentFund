//
//  CDHeaderTitleView.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDProvidentFundDetailCell.h"

@interface CDHeaderTitleView : UIView

@property (nonatomic, assign) CDCellLayoutType cellLayoutType;

- (void)setupWithFirstDesc:(NSString *)first secondDesc:(NSString *)second thirdDesc:(NSString *)third;

@end
