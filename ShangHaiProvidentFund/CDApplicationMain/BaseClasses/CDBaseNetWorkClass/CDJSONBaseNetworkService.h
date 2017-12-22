//
//  CDJSONBaseNetworkService.h
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "HttpRequestType.h"


/* ---------------------------------------------------------------- */
/** 网络请求基类 **/
/* ---------------------------------------------------------------- */

@protocol CDJSONBaseNetworkServiceDelegate;

@interface CDJSONBaseNetworkService : NSObject

/**
 *  代理协议
 */
@property (nonatomic, weak, readonly) id <CDJSONBaseNetworkServiceDelegate> delegate;

/**
 *  请求完成后收到的服务端返回的返回码，1为成功，其他均为失败
 */
@property (nonatomic, assign) NSInteger returnCode;//, readonly

/**
 *  请求完成后收到的服务端返回的描述
 */
@property (nonatomic, copy) NSString *desc;//, readonly

/**
 *  服务端返回的数据
 */
@property (nonatomic, strong) id rootData;//, readonly

/**
 *  请求方式，默认是POST
 */
@property (nonatomic, assign) HttpRequestType httpRequestMethod;

/**
 *  是否显示网络加载提示框，默认NO
 */
@property (nonatomic, assign) BOOL showLodingIndicator;

/**
 *  是否成功加载过
 *
 *  @return (BOOL)
 */
@property (readonly, nonatomic) BOOL isLoaded;

/**
 *  是否正在加载
 *
 *  @return (BOOL)
 */
@property (nonatomic, readonly) BOOL isLoading;

/**
 *  是否忽略缓存,重新请求,默认YES
 */
@property (nonatomic, assign) BOOL isIgnoreCache;

/**
 *  是否缓存数据（默认NO不缓存）
 */
@property (nonatomic, assign) BOOL toCacheData;

/**
 *  是否忽略缓存直接重新请求数据（默认NO:有缓存就先使用然后再刷新）
 */
@property (nonatomic, assign, getter=isIgnoreCache) BOOL ignoreCache;

/**
 *  取到的数据是否是缓存的数据
 */
@property (nonatomic, readonly) BOOL isUseCache;

/**
 是否打印该请求日志
 */
@property (nonatomic) BOOL printLog;

/**
 是否自动对返回数据进行json格式化，值为YES时：如果返回数据是json格式则请求成功，否则请求错误。值为NO时：需用户手动解析数据（数据有可能是html网页），状态为请求成功。默认为YES。
 */
@property (nonatomic) BOOL autoJSONDataSerializer;

/**
 *  初始化方法
 *
 *  @param delegate 代理协议
 *
 *  @return (instancetype)
 */
- (instancetype)initWithDelegate:(id <CDJSONBaseNetworkServiceDelegate>)delegate;

/**
 *  开始网络请求
 *
 *  @param url    请求的地址
 *  @param params 请求的参数
 */
- (void)request:(NSString *)urlString params:(id)params;

/**
 *  取消所有未完成的请求
 */
- (void)cancel;

/**
 *  请求完成取得数据，子类可override把数据转换为模型
 *
 *  @param rootData 请求到的原始数据
 */
- (void)requestDidFinish:(id)rootData;

/**
 *  封装所有接口必传的参数字段，需要时子类可以重写此方法，但必须调用父类方法
 *
 *  @param params 存储参数的字典
 *
 *  @return 封装好的参数字典
 */
//- (NSMutableDictionary *)packParameters:(NSMutableDictionary *)params;

@end

/* ---------------------------------------------------------------- */
/** 网络请求代理协议 **/
/* ---------------------------------------------------------------- */

@protocol CDJSONBaseNetworkServiceDelegate <NSObject>

@optional

/**
 *  网络请求已经开始，调用方法request:params:后触发
 *
 *  @param service 网络请求实例对象
 */
- (void)serviceDidStart:(CDJSONBaseNetworkService *)service;

/**
 *  网络请求已经完成
 *
 *  @param service 网络请求实例对象
 */
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service;

/**
 *  网络请求已经取消，由方法cancel触发
 *
 *  @param service 网络请求实例对象
 */
- (void)serviceDidCancel:(CDJSONBaseNetworkService *)service;

/**
 *  网络请求失败
 *
 *  @param service 网络请求实例对象
 *  @param error   错误描述
 */
- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error;

@end
