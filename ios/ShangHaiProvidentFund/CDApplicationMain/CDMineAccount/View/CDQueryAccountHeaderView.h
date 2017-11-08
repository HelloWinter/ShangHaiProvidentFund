//
//  CDQueryAccountHeaderView.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/7/4.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDAccountInfoItem;

typedef void(^CDViewTappedBlock)();

@interface CDQueryAccountHeaderView : UIView

@property (nonatomic, copy) CDViewTappedBlock viewTappedBlock;

- (void)setupViewItem:(CDAccountInfoItem *)item isLogined:(BOOL)islogined;

@end
