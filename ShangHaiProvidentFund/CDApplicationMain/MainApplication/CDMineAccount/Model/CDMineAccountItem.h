//
//  CDMineAccountItem.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDMineAccountItem : CDBaseItem

@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *title;

+ (instancetype)itemWithImageName:(NSString *)imgname title:(NSString *)title;

@end
