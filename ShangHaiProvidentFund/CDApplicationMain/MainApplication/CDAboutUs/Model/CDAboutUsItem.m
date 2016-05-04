//
//  CDAboutUsItem.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAboutUsItem.h"

@implementation CDAboutUsItem

+ (instancetype)itemWithImgName:(NSString *)imgName title:(NSString *)titleText detail:(NSString *)detailText{
    CDAboutUsItem *item=[[self alloc]init];
    item.imgName=imgName;
    item.titleText=titleText;
    item.detailText=detailText;
    return item;
}

@end
