//
//  SCYAnnualBonusCalculateTool.h
//  ProvidentFund
//
//  Created by cdd on 17/1/17.
//  Copyright © 2017年 9188. All rights reserved.
//

#ifndef SCYAnnualBonusCalculateTool_h
#define SCYAnnualBonusCalculateTool_h

typedef NS_ENUM(NSInteger,SCYAnnualBonusCalculateType) {
    /**
     计算税后
     */
    SCYAnnualBonusCalculateType1,
    /**
     反推税前
     */
    SCYAnnualBonusCalculateType2
};

typedef NS_ENUM(NSInteger,SCYPersonalIncomeTaxCalculateType) {
    /**
     计算税后
     */
    SCYPersonalIncomeTaxCalculateType1,
    /**
     反推税前
     */
    SCYPersonalIncomeTaxCalculateType2
};

#endif /* SCYAnnualBonusCalculateTool_h */
