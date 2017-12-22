//
//  CDVerificationCodeCell.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/17.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTextFieldCell.h"

typedef BOOL(^CDGetVerCodeBlock)();

@class CDNormalTextFieldConfigureItem;

@interface CDVerificationCodeCell : CDBaseTextFieldCell

@property (nonatomic, copy) CDGetVerCodeBlock getVerCodeBlock;

- (void)setupItem:(CDNormalTextFieldConfigureItem *)item indexPath:(NSIndexPath *)path;

@end
