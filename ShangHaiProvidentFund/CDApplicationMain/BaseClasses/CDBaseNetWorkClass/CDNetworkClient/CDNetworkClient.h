//
//  CDNetworkClient.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "CDRequestObject.h"
#import "CDResponseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDNetworkClient : NSObject

+ (NSURLSessionDataTask *)uploadRequest:(void(^)(CDRequestObject *requestObject))request
                              dataBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress
                                success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject))success
                                failure:(void(^)(NSURLSessionDataTask *task, NSError *error)) failure;

/**
 发送POST请求
 
 @param request 配置请求对象
 @param modelClass 字典转模型的模型类（或类名字符串，不建议）
 @param success 请求成功回调
 @return 本次请求的task
 */
+ (NSURLSessionDataTask *)sendPostRequest:(void(^)(CDRequestObject *  requestObject))request model:(nullable id)modelClass success:(nullable void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success;

/**
 发送POST请求
 
 @param request 配置请求对象
 @param modelClass 字典转模型的模型类（或类名字符串，不建议）
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 本次请求的task
 */
+ (NSURLSessionDataTask *)sendPostRequest:(void(^)(CDRequestObject *requestObject))request model:(nullable id)modelClass success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success failure:(nullable void(^)(NSURLSessionDataTask *task, NSError *error)) failure;

/**
 发送GET请求
 
 @param request 配置请求对象
 @param modelClass 字典转模型的模型类（或类名字符串，不建议）
 @param success 请求成功回调
 @return 本次请求的task
 */
+ (NSURLSessionDataTask *)sendGetRequest:(nullable void(^)(CDRequestObject *requestObject))request model:(id)modelClass success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success;

/**
 发送GET请求
 
 @param request 配置请求对象
 @param modelClass 字典转模型的模型类（或类名字符串，不建议）
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 本次请求的task
 */
+ (NSURLSessionDataTask *)sendGetRequest:(void(^)(CDRequestObject *requestObject))request model:(nullable id)modelClass success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success failure:(nullable void(^)(NSURLSessionDataTask *task, NSError *error)) failure;

@end

NS_ASSUME_NONNULL_END
