//
//  UpDownLBView.h
//  MoneyMore
//
//  Created by cdd on 15/4/20.
//  Copyright (c) 2015年 ___9188___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpDownLBView : UIView

@property (nonatomic, strong, readonly)UILabel *lbUp;
@property (nonatomic, strong, readonly)UILabel *lbDown;
@property (nonatomic, assign) CGFloat percentageOflbUp;

@end
