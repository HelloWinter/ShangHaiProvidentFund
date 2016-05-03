//
//  CDJSONBaseNetworkService.h
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//


#import "CDBaseService.h"
//#import "AFNetworking.h"

/* ---------------------------------------------------------------- */
/** 网络请求基类 **/
/* ---------------------------------------------------------------- */

@protocol CDJSONBaseNetworkServiceDelegate;

@interface CDJSONBaseNetworkService : CDBaseService

/**
 *  代理协议
 */
@property (nonatomic, weak, readonly) id <CDJSONBaseNetworkServiceDelegate> delegate;

/**
 *  请求方式，默认是POST
 */
@property (nonatomic, assign) HttpRequestType httpRequestMethod;

/**
 *  是否显示加载框，默认NO
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
@property (readonly, nonatomic) BOOL isLoading;

/**
 *  是否取消了请求
 */
@property (readonly, nonatomic) BOOL isCancelled;

/**
 *  服务器时间
 */
@property (nonatomic, strong, readonly) NSDate *serverDate;

/**
 *  如果token无效或未登录，是否显示登录界面，默认为YES
 */
@property (nonatomic, assign) BOOL showLoginController;

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
 *  封装参数，需要时子类可以重写此方法，但必须调用父类方法
 *
 *  @param params 存储参数的字典
 *
 *  @return 封装好的参数字典
 */
//- (NSMutableDictionary *)packParameters:(NSMutableDictionary *)params;

- (void)requestDidFinish:(NSDictionary *)rootData;

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
- (void)requestDidStart:(CDJSONBaseNetworkService *)service;

/**
 *  网络请求已经完成
 *
 *  @param service 网络请求实例对象
 */
- (void)requestDidFinished:(CDJSONBaseNetworkService *)service;

/**
 *  网络请求已经取消，由方法cancel触发
 *
 *  @param service 网络请求实例对象
 */
- (void)requestDidCancel:(CDJSONBaseNetworkService *)service;

/**
 *  网络请求失败
 *
 *  @param service 网络请求实例对象
 *  @param error   错误描述
 */
- (void)request:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error;

@end