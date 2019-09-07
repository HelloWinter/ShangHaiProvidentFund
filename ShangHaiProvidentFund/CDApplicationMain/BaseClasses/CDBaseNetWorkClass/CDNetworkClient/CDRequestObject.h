//
//  CDRequestObject.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDRequestObject : NSObject

/**
 请求链接
 */
@property (nonatomic, copy) NSString *URLString;

/**
 请求参数
 */
@property (nonatomic, strong) id parameters;

/**
 是否添加通用参数(默认为YES)
 */
@property (nonatomic, assign, getter=isAddCommonParam) BOOL addCommonParam;

/////////////////////提示相关//////////////////////////
/**
 HUD提示
 */
@property (nonatomic, copy) NSString *hudTitle;

/**
 是否显示错误消息
 */
@property (nonatomic, assign, getter=isShowErrorMessage) BOOL showErrorMessage;

@property (nonatomic, assign, getter=isShowNoNetworkTips) BOOL showNoNetworkTips;

@property (nonatomic, assign, getter=isShowServerError) BOOL showServerError;

/**
 是否打印响应数据日志（默认为YES）
 */
@property (nonatomic, assign, getter=isPrintLog) BOOL printLog;

/////////////////////缓存相关//////////////////////////
/**
 是否缓存数据（默认为NO,不缓存）
 */
@property (nonatomic, assign) BOOL doCacheData;

/**
 数据的缓存id
 */
@property (nonatomic, copy, readonly) NSString *cacheID;

/**
 是否忽略缓存直接重新请求数据,此参数生效前提是已开启缓存数据（默认NO:有缓存就使用）
 */
@property (nonatomic, assign, getter=isIgnoreCache) BOOL ignoreCache;

@end
