//
//  SCYRowItem.h
//  ProvidentFund
//
//  Created by cdd on 16/2/29.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDBaseItem.h"

@interface SCYRowItem : CDBaseItem

@property (nonatomic, copy) NSString *itemkey;
@property (nonatomic, copy) NSString *itemtype;
@property (nonatomic, copy) NSString *itemvalue;
@property (nonatomic, copy) NSString *itemdesc;
@property (nonatomic, copy) NSString *editunit;
@property (nonatomic, copy) NSString *editunitvalue;
@property (nonatomic, copy) NSString *editemptytip;
@property (nonatomic, copy) NSString *radioorientation;
@property (nonatomic, copy) NSArray *radiosubitemsdata;

@end
