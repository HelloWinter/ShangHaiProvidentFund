//
//  CDBaseModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/4.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseModel.h"

@implementation CDBaseModel
@synthesize arrData=_arrData;

- (NSMutableArray *)arrData{
    if (_arrData==nil) {
        _arrData=[[NSMutableArray alloc]init];
    }
    return _arrData;
}

@end
