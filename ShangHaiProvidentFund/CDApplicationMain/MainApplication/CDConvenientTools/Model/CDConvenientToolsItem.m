//
//  CDConvenientToolsItem.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDConvenientToolsItem.h"

@implementation CDConvenientToolsItem

+ (instancetype)itemWithImageName:(NSString *)imgname title:(NSString *)title{
    CDConvenientToolsItem *item=[[self alloc]init];
    item.imgName=imgname;
    item.title=title;
    return item;
}

@end
