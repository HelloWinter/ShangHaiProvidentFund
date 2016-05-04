//
//  CDMineAccountItem.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDMineAccountItem.h"

@implementation CDMineAccountItem

+ (instancetype)itemWithImageName:(NSString *)imgname title:(NSString *)title{
    CDMineAccountItem *item=[[self alloc]init];
    item.imgName=imgname;
    item.title=title;
    return item;
}

@end
