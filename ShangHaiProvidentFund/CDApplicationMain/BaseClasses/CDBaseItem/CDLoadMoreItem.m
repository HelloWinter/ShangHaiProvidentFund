//
//  CDLoadMoreItem.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/6.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoadMoreItem.h"

@interface CDLoadMoreItem ()

@property (nonatomic, copy) NSString *loadingTitle;

@end

@implementation CDLoadMoreItem

+ (id)itemWithTitle:(NSString*)title showIndicator:(BOOL)show {
    CDLoadMoreItem *item = [[self alloc] init];
    item.loadingTitle = title;
    item.showIndicator = show;
    return item;
}

@end
