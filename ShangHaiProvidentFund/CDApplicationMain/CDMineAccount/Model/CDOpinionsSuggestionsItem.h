//
//  CDOpinionsSuggestionsItem.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDOpinionsSuggestionsItem : CDBaseItem

@property (nonatomic, copy) NSString *paramname;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *security;
@property (nonatomic, copy) NSString *paramsubmit;

@end
