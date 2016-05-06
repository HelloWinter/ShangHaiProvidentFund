//
//  CDLoadMoreItem.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/6.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDLoadMoreItem : CDBaseItem

@property (nonatomic, copy, readonly) NSString *loadingTitle;

@property (nonatomic, assign) BOOL showIndicator;

+ (id)itemWithTitle:(NSString*)title showIndicator:(BOOL)show;

@end
