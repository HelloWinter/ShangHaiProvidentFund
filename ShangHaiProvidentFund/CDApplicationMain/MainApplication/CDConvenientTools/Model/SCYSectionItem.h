//
//  SCYSectionItem.h
//  ProvidentFund
//
//  Created by cdd on 16/2/29.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYSectionItem : CDBaseItem

@property (nonatomic, copy) NSString *sectionTitle;
@property (nonatomic, strong) NSMutableArray *sectionData;

@end
