//
//  CDNetworkClient.m
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import "CDNetworkClient.h"
#import <MJExtension.h>
#import <YYCache.h>
#import "CDHud.h"

@interface CDNetworkClient ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) YYMemoryCache *cache;

@end

@implementation CDNetworkClient

+ (instancetype)sharedClient{
    static CDNetworkClient *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CDNetworkClient alloc]init];
    });
    return instance;
}

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 20;
        _manager.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
    }
    return _manager;
}

- (YYMemoryCache *)cache{
    if (_cache==nil) {
        _cache=[[YYMemoryCache alloc]init];
        _cache.name = [NSString stringWithFormat:@"%@.network",CDAppBundleID];
        _cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        _cache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        //        _cache=[YYCache cacheWithName:cacheName];
        //        _cache.diskCache.ageLimit = 60 * 60 * 24;
    }
    return _cache;
}

/** POST请求，上传数据(监测上传进度) */
+ (NSURLSessionDataTask *)uploadRequest:(void(^)(CDRequestObject *requestObject))request
                              dataBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(void (^)(NSProgress * _Nonnull uploadProgress))progress
                                success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success
                                failure:(void(^)(NSURLSessionDataTask *task, NSError *error)) failure {
    CDRequestObject *requestObject = [[CDRequestObject alloc]init];
    request(requestObject);
    if (!requestObject.URLString)
        return nil;
    CDNetworkClient *client = [CDNetworkClient sharedClient];
    
    //打印请求信息
    CDLog(@">>> [POST] Request URL: %@ Headers:\n%@ Parameters:\n%@",requestObject.URLString,client.manager.requestSerializer.HTTPRequestHeaders,requestObject.parameters);
    __weak __typeof(CDNetworkClient *)weakSelf = client;
    NSURLSessionDataTask *task = [client.manager POST:requestObject.URLString parameters:requestObject.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf p_hideActivityToastWith:requestObject.hudTitle];
        //解析数据
        CDResponseObject *response = [weakSelf parseResponse:responseObject model:nil fromURL:task.currentRequest.URL.absoluteString method:@"POST" isCacheData:NO isPrintLog:requestObject.isPrintLog];
        if (success) {
            success(task,response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf p_hideActivityToastWith:requestObject.hudTitle];
        [weakSelf dealFailureInfoWithTask:task method:@"POST" error:error showNoNetworkTips:requestObject.isShowNoNetworkTips showServerError:requestObject.isShowServerError];
        if (failure) {
            failure(task,error);
        }
    }];
    
    return task;
}

+ (NSURLSessionDataTask *)sendPostRequest:(void(^)(CDRequestObject *requestObject))request model:(id)modelClass success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success{
    return [CDNetworkClient sendPostRequest:request model:modelClass success:success failure:nil];
}

+ (NSURLSessionDataTask *)sendPostRequest:(void(^)(CDRequestObject *requestObject))request model:(id)modelClass success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success failure:(nullable void(^)(NSURLSessionDataTask *task, NSError *error)) failure{
    CDRequestObject *requestObject = [[CDRequestObject alloc]init];
    request(requestObject);
    if (!requestObject.URLString)
        return nil;
    CDNetworkClient *client = [CDNetworkClient sharedClient];
    //如果有缓存取缓存
    if(requestObject.doCacheData && !requestObject.isIgnoreCache){
        if ([client.cache containsObjectForKey:requestObject.cacheID]) {
            id responseObject = [client.cache objectForKey:requestObject.cacheID];
            CDResponseObject *response = [client parseResponse:responseObject model:modelClass fromURL:requestObject.URLString method:@"POST" isCacheData:YES isPrintLog:requestObject.isPrintLog];
            success(nil,response);
            return nil;
        }
    }
    
    CDLog(@">>> [POST] Request URL: %@ Headers:\n%@ Parameters:\n%@",requestObject.URLString,client.manager.requestSerializer.HTTPRequestHeaders,requestObject.parameters);
    //显示ActivityToast
    [client p_showActivityToastWith:requestObject.hudTitle];
    //POST请求
    __weak __typeof(CDNetworkClient *)weakSelf = client;
    NSURLSessionDataTask *task = [client.manager POST:requestObject.URLString parameters:requestObject.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf p_hideActivityToastWith:requestObject.hudTitle];
        //解析数据
        CDResponseObject *response = [weakSelf parseResponse:responseObject model:modelClass fromURL:task.currentRequest.URL.absoluteString method:@"POST" isCacheData:NO isPrintLog:requestObject.isPrintLog];
        //数据错误提示
        if (!response.isSucceed && requestObject.isShowErrorMessage && requestObject.hudTitle && requestObject.hudTitle.length!=0) {
            [weakSelf showErrorMessage:response.msg];
        }
        //缓存数据
        if (requestObject.doCacheData && response.isSucceed) {
            [weakSelf.cache setObject:responseObject forKey:requestObject.cacheID];
        }
        
        //回调
        if (success) {
            success(task,response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf p_hideActivityToastWith:requestObject.hudTitle];
        [weakSelf dealFailureInfoWithTask:task method:@"POST" error:error showNoNetworkTips:requestObject.isShowNoNetworkTips showServerError:requestObject.isShowServerError];
        if (failure) {
            failure(task,error);
        }
    }];
    return task;
}

+ (NSURLSessionDataTask *)sendGetRequest:(void(^)(CDRequestObject *requestObject))request model:(id)modelClass success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success{
    return [CDNetworkClient sendGetRequest:request model:modelClass success:success failure:nil];
}

+ (NSURLSessionDataTask *)sendGetRequest:(void(^)(CDRequestObject *requestObject))request model:(id)modelClass success:(void(^)(NSURLSessionDataTask *task, CDResponseObject *responseObject)) success failure:(nullable void(^)(NSURLSessionDataTask *task, NSError *error)) failure{
    CDRequestObject *requestObject = [[CDRequestObject alloc]init];
    request(requestObject);
    if (!requestObject.URLString)
        return nil;
    CDNetworkClient *client = [CDNetworkClient sharedClient];
    //如果有缓存取缓存
    if(requestObject.doCacheData && !requestObject.isIgnoreCache){
        if ([client.cache containsObjectForKey:requestObject.cacheID]) {
            id responseObject = [client.cache objectForKey:requestObject.cacheID];
            CDResponseObject *response = [client parseResponse:responseObject model:modelClass fromURL:requestObject.URLString method:@"GET" isCacheData:YES isPrintLog:requestObject.isPrintLog];
            success(nil,response);
            return nil;
        }
    }
    //设置请求序列化
    CDLog(@">>> [GET] Request URL: %@ Headers:\n%@ Parameters:\n%@",requestObject.URLString,client.manager.requestSerializer.HTTPRequestHeaders,requestObject.parameters);
    //显示ActivityToast
    [client p_showActivityToastWith:requestObject.hudTitle];
    //GET请求
    __weak __typeof(CDNetworkClient *)weakSelf = client;
    NSURLSessionDataTask *task = [client.manager GET:requestObject.URLString parameters:requestObject.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf p_hideActivityToastWith:requestObject.hudTitle];
        //解析数据
        CDResponseObject *response = [weakSelf parseResponse:responseObject model:modelClass fromURL:task.currentRequest.URL.absoluteString method:@"GET" isCacheData:NO isPrintLog:requestObject.isPrintLog];
        //数据错误提示
        if (!response.isSucceed && requestObject.isShowErrorMessage  && requestObject.hudTitle && requestObject.hudTitle.length!=0) {
            [weakSelf showErrorMessage:response.msg];
        }
        //缓存数据
        if (requestObject.doCacheData && response.isSucceed) {
            [weakSelf.cache setObject:responseObject forKey:requestObject.cacheID];
        }
        //回调
        success(task,response);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf p_hideActivityToastWith:requestObject.hudTitle];
        [weakSelf dealFailureInfoWithTask:task method:@"GET" error:error showNoNetworkTips:requestObject.isShowNoNetworkTips showServerError:requestObject.isShowServerError];
        if (failure) {
            failure(task,error);
        }
    }];
    return task;
}

#pragma mark - private
/**
 请求成功，解析响应数据
 
 @param responseObject 响应数据
 @param modelClass 模型类
 @param url 请求url
 @param method 请求方式
 @param isCache 是否是缓存数据
 @return 响应对象
 */
- (CDResponseObject *)parseResponse:(id)responseObject model:(id)modelClass fromURL:(NSString *)url method:(NSString *)method isCacheData:(BOOL)isCache isPrintLog:(BOOL)isPrint{
    //打印
    if (isPrint) {
        CDLog(@">>> [%@] Request URL: %@ %@ResponseObject:\n%@",method,url,isCache ? @"Cache" : @"",[self stringFromJSON:responseObject]);
    }
    //解析
    CDResponseObject *response = [[CDResponseObject alloc]init];
    response.isCacheData = isCache;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        id returnCodeObj = [responseObject objectForKey:response.statusKey];
        if ([returnCodeObj isKindOfClass:[NSNumber class]]) {
            response.status = [returnCodeObj integerValue];
        } else if ([returnCodeObj isKindOfClass:[NSString class]]) {
            response.status = [returnCodeObj integerValue];
        }
        response.msg = [responseObject objectForKey:response.msgKey];
        id data = [responseObject objectForKey:response.dataKey];
        if (modelClass) {
            Class model = modelClass;
            if ([modelClass isKindOfClass:[NSString class]]) {
                model = NSClassFromString(modelClass);
            }
            if ([data isKindOfClass:[NSArray class]]) {
                response.data = [model mj_objectArrayWithKeyValuesArray:data];
            }else if ([data isKindOfClass:[NSDictionary class]]){
                NSDictionary *responseDic = data;
                if (responseDic.allKeys.count == 1 && [responseDic.allValues.firstObject isKindOfClass:[NSDictionary class]]) {
                    responseDic = responseDic.allValues.firstObject;
                }
                response.data = [model mj_objectWithKeyValues:responseDic];
            }else if([data isKindOfClass:[NSNull class]]){
                response.data = nil;
            }else{
                response.data = data;
            }
        }else{
            if([data isKindOfClass:[NSNull class]]){
                data = nil;
            }
            response.data = data;
        }
    }else{
        if([responseObject isKindOfClass:[NSNull class]]){
            responseObject = nil;
        }
        response.data = responseObject;
    }
    return response;
}

/**
 请求失败处理
 */
- (void)dealFailureInfoWithTask:(NSURLSessionDataTask * _Nullable)task method:(NSString *)method error:(NSError *)error showNoNetworkTips:(BOOL)show showServerError:(BOOL)serverError{
    //显示请求错误消息
    CDLog(@">>> [%@] Request URL: %@ Error:\n%@",method, task.currentRequest.URL.absoluteString, error.localizedDescription);
    if (![error.localizedDescription isEqualToString:@"已取消"]) {
        if (error.code == NSURLErrorNotConnectedToInternet && show) {
            [CDHud showToast:[CDNetworkClient messageFromError:error]];
        }
        if (error.code != NSURLErrorNotConnectedToInternet && serverError) {
            [CDHud showToast:[CDNetworkClient messageFromError:error]];
        }
    }
}

/**
 jsonDic转成jsonString,
 printed NO:去回车、空格格式化 YES:有换行、空格
 */
- (NSString*)stringFromJSON:(NSDictionary *)dic {
    if (dic == nil) {
        return nil;
    }
    if ([dic isKindOfClass:[NSString class]]) {
        return (NSString *)dic;
    }
    
    NSString *jsonString = nil;
    NSError *error;
    NSJSONWritingOptions jsonWritingOption = NSJSONWritingPrettyPrinted;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:jsonWritingOption
                                                         error:&error];
    if (!jsonData) {
        CDLog(@"Got an error: %@", error);
        return nil;
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

- (void)downLoadWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                     progerss:(void (^)(void))progress
                      success:(void (^)(void))success
                      failure:(void (^)(NSError *))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *downLoadTask = [self.manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return targetPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
    [downLoadTask resume];
}

/**
 显示ActivityToast指示器
 */
- (void)p_showActivityToastWith:(NSString *)hudTitle{
    if (hudTitle && hudTitle.length!=0) {
        [CDHud showIndicatorWithTitle:hudTitle];
    }
}

/**
 隐藏ActivityToast指示器
 */
- (void)p_hideActivityToastWith:(NSString *)hudTitle{
    if (hudTitle && hudTitle.length!=0) {
        [CDHud hideIndicatorForTitle:hudTitle];
    }
}

/**
 请求成功，但数据不正常提示
 */
- (void)showErrorMessage:(NSString *)errorMsg{
    NSString *message = (errorMsg && errorMsg.length > 0) ? errorMsg : @"请求失败";
    [CDHud showToast:message];
}

/**
 常见错误个性化描述
 */
+ (NSString *)messageFromError:(NSError *)error {
    if (error.code == NSURLErrorNotConnectedToInternet) {
        return @"当前网络不可用";//您的网络未连接，请连接后再试
    } else  {
        return @"请求失败";
    }
}

@end
