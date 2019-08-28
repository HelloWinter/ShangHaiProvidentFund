//
//  CDResponseObject.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDResponseObject : NSObject

@property (nonatomic, copy, readonly) NSString *statusKey;
@property (nonatomic, copy, readonly) NSString *msgKey;
@property (nonatomic, copy, readonly) NSString *dataKey;

/**
 是否请求成功
 */
@property (nonatomic, assign,readonly) BOOL isSucceed;

/**
 响应状态，10000：请求成功
 */
@property (nonatomic, assign) NSInteger status;

/**
 响应描述
 */
@property (nonatomic, copy) NSString  *msg;

/**
 响应数据(可以是数据模型数组,单一的数据模型,json数据)
 */
@property (nonatomic, strong) id  data;

/**
 取得的数据是否是缓存的数据
 */
@property (nonatomic, assign) BOOL isCacheData;

@end

NS_ASSUME_NONNULL_END
