//
//  CDJSONBaseNetworkService.m
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"
#import "CDNetworkRequestManager.h"
#import "CDGlobalHTTPSessionManager.h"
#import <YYCache/YYCache.h>
#import "NSDictionary+CDDictionaryAdditions.h"
#import "NSString+CDEncryption.h"

@interface CDJSONBaseNetworkService ()

@property (nonatomic, strong) NSURLSessionDataTask *currentTask;
@property (nonatomic, strong) CDGlobalHTTPSessionManager *manager;
@property (nonatomic, copy) NSString *cacheURLStringID;
@property (nonatomic, strong) YYCache *cache;

@end

@implementation CDJSONBaseNetworkService

- (instancetype)init {
    return [self initWithDelegate:nil];
}

- (instancetype)initWithDelegate:(id <CDJSONBaseNetworkServiceDelegate>)delegate {
    if (self = [super init]) {
        _isLoaded = NO;
        _toCacheData=NO;
        _delegate = delegate;
        _httpRequestMethod = kHttpRequestTypePOST;
        _isIgnoreCache=YES;
        _printLog=YES;
        _autoJSONDataSerializer=YES;
    }
    return self;
}

- (CDGlobalHTTPSessionManager *)manager{
    if (_manager==nil) {
        _manager = [CDGlobalHTTPSessionManager sharedManager];
    }
    return _manager;
}

- (YYCache *)cache{
    if (_cache==nil) {
        _cache=[YYCache cacheWithName:self.cacheURLStringID];
    }
    return _cache;
}

#pragma mark - public
- (void)request:(NSString *)urlString params:(id)params {
    if (!urlString || urlString.length == 0) { return; }
    [self p_resetNetworkService];
    
    /**
     *  先使用缓存数据
     */
    if (self.toCacheData && !self.isIgnoreCache) {
        NSString *paramsString = (params==nil ? @"" : [params cd_TransformToParamStringWithMethod:(kHttpRequestTypeGET)]);
        self.cacheURLStringID=[[NSString stringWithFormat:@"%@%@",urlString,paramsString] cd_md5HexDigest];
        if ([self.cache containsObjectForKey:self.cacheURLStringID]) {
            CDLog(@"使用缓存数据:%@",urlString);
            _isUseCache=YES;
            [self p_succeedGetResponse:[self.cache objectForKey:self.cacheURLStringID]];
        }
    }
    
    WS(weakSelf);
    switch (_httpRequestMethod) {
        case kHttpRequestTypePOST: {
            self.currentTask = [self.manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([weakSelf isKindOfClass:[CDJSONBaseNetworkService class]]) {
                    if (_autoJSONDataSerializer) {
                        NSError *error=nil;
                        id responseObj=[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:&error];
                        if (!error) {
                            [weakSelf p_taskDidFinish:task responseObject:responseObj];
                        }else{
                            CDLog(@"Serialization Error:%@",error);
                            [CDAutoHideMessageHUD showMessage:@"数据格式错误"];
                            [weakSelf p_taskDidFail:task error:error];
                        }
                    }else{
                        [weakSelf p_taskDidFinish:task responseObject:responseObject];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if ([weakSelf isKindOfClass:[CDJSONBaseNetworkService class]]) {
                    [weakSelf p_taskDidFail:task error:error];
                }
            }];
            
        }   break;
        case kHttpRequestTypeGET: {
            self.currentTask = [self.manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([weakSelf isKindOfClass:[CDJSONBaseNetworkService class]]) {
                    if (_autoJSONDataSerializer) {
                        NSError *error=nil;
                        id responseObj=[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:&error];
                        if (!error) {
                            [weakSelf p_taskDidFinish:task responseObject:responseObj];
                        }else{
                            CDLog(@"Serialization Error:%@",error);
                            [CDAutoHideMessageHUD showMessage:@"数据格式错误"];
                            [weakSelf p_taskDidFail:task error:error];
                        }
                    }else{
                        [weakSelf p_taskDidFinish:task responseObject:responseObject];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if ([weakSelf isKindOfClass:[CDJSONBaseNetworkService class]]) {
                    [weakSelf p_taskDidFail:task error:error];
                }
            }];
        }   break;
    }
    
    //打印请求信息
    _isLoading=YES;
    [CDNetworkRequestManager addService:self];
    //打印请求信息
    CDLog(@">>> %@ Request URL: %@ Parameters:\n%@",(_httpRequestMethod==kHttpRequestTypePOST ? @"POST":@"GET"),urlString,params);
}

- (void)cancel {
    if (!self.currentTask || self.currentTask.state == NSURLSessionTaskStateCanceling || self.currentTask.state == NSURLSessionTaskStateCompleted) {
        return;
    }
    [self.currentTask cancel];
    if (_delegate && [_delegate respondsToSelector:@selector(serviceDidCancel:)]) {
        [_delegate serviceDidCancel:self];
    }
    self.currentTask=nil;
    [CDNetworkRequestManager removeService:self];
}

- (void)requestDidFinish:(id)rootData {
    if (self.toCacheData && self.cacheURLStringID && _returnCode==1) {
        [self.cache setObject:rootData forKey:self.cacheURLStringID];
    }
}

#pragma mark - private
- (NSString *)p_requsetURLString{
    return self.currentTask.currentRequest.URL.absoluteString;
}

/* 请求完成 */
- (void)p_taskDidFinish:(NSURLSessionTask *)task responseObject:(id)responseObject {
    if (self.printLog) {
        CDLog(@">>> URL: %@ Response Data: %@ ", task.currentRequest.URL,responseObject);
    }
    if (task.state == NSURLSessionTaskStateCompleted) {
        [self p_succeedGetResponse:responseObject];
        [self p_requestFinished];
    }
}

- (void)p_requestFinished{
    _isLoaded=YES;
    _isLoading=NO;
    _isUseCache=NO;
    self.currentTask = nil;
    [CDNetworkRequestManager removeService:self];
}

/* 请求失败 */
- (void)p_taskDidFail:(NSURLSessionTask *)task error:(NSError *)error {
    if (self.printLog) {
        CDLog(@">>> URL: %@ Response Error: %@", task.currentRequest.URL,error.localizedDescription);
    }
    if (task.state == NSURLSessionTaskStateCompleted || task.state == NSURLSessionTaskStateCanceling) {
        _isLoading=NO;
        if (error.code==NSURLErrorBadServerResponse) {
            if (self.toCacheData && [self.cache containsObjectForKey:self.cacheURLStringID]) {
                if (self.printLog) {
                    CDLog(@"使用缓存数据(BadServer)%@",task.currentRequest.URL.absoluteString);
                }
                _isUseCache=YES;
                [self p_succeedGetResponse:[self.cache objectForKey:self.cacheURLStringID]];
            }else{
                _isUseCache=NO;
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(service:didFailLoadWithError:)]) {
            [self.delegate service:self didFailLoadWithError:error];
        }
        self.currentTask = nil;
        [CDNetworkRequestManager removeService:self];
    }
}

/**
 @param responseObject 有可能是json格式化后的数据，也有可能是其他类型数据，例如html网页
 */
- (void)p_succeedGetResponse:(id)responseObject{
    _rootData = responseObject;
//    if ([_rootData isKindOfClass:[NSDictionary class]]) {
//        id returnCode = [_rootData objectForKey:@"code"];
//        if ([returnCode isKindOfClass:[NSNumber class]]) {
//            _returnCode = [NSString stringWithFormat:@"%@",returnCode];
//        } else if ([returnCode isKindOfClass:[NSString class]]) {
//            _returnCode = returnCode;
//        }
//        _desc = [_rootData objectForKey:@"desc"];
//    }
    [self requestDidFinish:_rootData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(serviceDidFinished:)]) {
        [self.delegate serviceDidFinished:self];
    }
}

- (void)p_resetNetworkService{
    [self.currentTask cancel];
    self.currentTask=nil;
    _isLoading=NO;
    _isUseCache=NO;
    [CDNetworkRequestManager removeService:self];
}

@end
