//
//  CDProvidentFundDetailHeaderView.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDAccountInfoItem,CDPayAccountItem;

@interface CDProvidentFundDetailHeaderView : UIView

- (void)setupAccountInfo:(CDAccountInfoItem *)item;

- (void)setupLoanInfo:(CDPayAccountItem *)item;

@end
