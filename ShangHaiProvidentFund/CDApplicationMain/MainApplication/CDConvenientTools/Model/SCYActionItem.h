//
//  SCYActionItem.h
//  ProvidentFund
//
//  Created by cdd on 16/2/29.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYActionItem : CDBaseItem

@property (nonatomic, copy) NSString *actionKey;
@property (nonatomic, copy) NSString *actionType;
@property (nonatomic, copy) NSArray *data;

@end
