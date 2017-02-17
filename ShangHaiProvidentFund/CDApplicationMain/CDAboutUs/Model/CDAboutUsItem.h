//
//  CDAboutUsItem.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDAboutUsItem : CDBaseItem

@property (nonatomic, copy, readonly) NSString *imgName;
@property (nonatomic, copy, readonly) NSString *titleText;
@property (nonatomic, copy, readonly) NSString *detailText;

+ (instancetype)itemWithImgName:(NSString *)imgName title:(NSString *)titleText detail:(NSString *)detailText;

@end
