//
//  CDMeasurementGuideModel.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/27.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDMeasurementGuideModel.h"
#import "SCYLinkItem.h"
@implementation CDMeasurementGuideModel

- (instancetype)initWithGuideType:(SCYGuideMeasurementType)type{
    if (self = [super init]) {
        [self.arrData removeAllObjects];
        NSString *filepath;
        if (type==SCYGuideMeasurementTypeLoan) {
            filepath=[[NSBundle mainBundle]pathForResource:@"loanguide.json" ofType:nil];
        }else if (type==SCYGuideMeasurementTypeExtract){
            filepath=[[NSBundle mainBundle]pathForResource:@"extractguide.json" ofType:nil];
        }
        NSData *data=[NSData dataWithContentsOfFile:filepath];
        NSError *error=nil;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
        if (!error) {
//            if (type==SCYGuideMeasurementTypeLoan) {
                [self.arrData addObjectsFromArray:[SCYLinkItem mj_objectArrayWithKeyValuesArray:arr]];
//            }else if (type==SCYGuideMeasurementTypeExtract){
//                [self.arrData addObjectsFromArray:[SCYLinkItem mj_objectArrayWithKeyValuesArray:arr]];
//            }
        }
    }
    return self;
}

@end
