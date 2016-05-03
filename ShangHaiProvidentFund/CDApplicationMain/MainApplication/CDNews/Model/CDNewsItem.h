//
//  CDNewsItem.h
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDNewsItem : CDBaseItem

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *columnId;
@property (nonatomic, copy) NSString *columnName;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *newsid;
@property (nonatomic, copy) NSString *keyWords;
@property (nonatomic, copy) NSString *lastDate;
@property (nonatomic, copy) NSString *origin;
@property (nonatomic, copy) NSString *pubDate;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;

@end
