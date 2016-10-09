//
//  CDBottomButtonView.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CDForgotPSWBlock)();
typedef void(^CDRegistBlock)();

@interface CDBottomButtonView : UIView

//+ (instancetype)bottomButtonView;

@property (nonatomic, copy) CDForgotPSWBlock forgotPSWBlock;
@property (nonatomic, copy) CDRegistBlock registBlock;

@end
