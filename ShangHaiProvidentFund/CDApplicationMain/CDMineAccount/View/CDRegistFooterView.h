//
//  CDRegistFooterView.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/13.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CDShowProtocolBlock)(void);
typedef void(^CDRegistBlock)(void);
typedef void(^CDShowProblemBlock)(void);

@interface CDRegistFooterView : UIView

@property (nonatomic, copy) CDShowProtocolBlock showProtocolBlock;
@property (nonatomic, copy) CDRegistBlock registBlock;
@property (nonatomic, copy) CDShowProblemBlock showProblemBlock;

@end
