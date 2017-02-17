//
//  CDConvenientToolsItem.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDConvenientToolsItem : CDBaseItem

@property (nonatomic, copy, readonly) NSString *imgName;
@property (nonatomic, copy, readonly) NSString *title;

+ (instancetype)itemWithImageName:(NSString *)imgname title:(NSString *)title;

@end
