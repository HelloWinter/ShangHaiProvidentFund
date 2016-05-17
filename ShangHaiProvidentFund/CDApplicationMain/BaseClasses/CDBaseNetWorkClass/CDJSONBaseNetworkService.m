//
//  CDJSONBaseNetworkService.m
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDJSONBaseNetworkService.h"
#import "CDPointActivityIndicator.h"
#import "CDNetworkRequestManager.h"
#import "CDGlobalHTTPSessionManager.h"
#import <YYCache/YYCache.h>
#import "NSDictionary+CDDictionaryAdditions.h"
#import "NSString+CDEncryption.h"

@interface CDJSONBaseNetworkService ()

@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) CDGlobalHTTPSessionManager *manager;
@property (nonatomic, copy) NSString *cacheURLStringID;//cacheurlstring
@property (nonatomic, strong) YYCache *cache;

@end

@implementation CDJSONBaseNetworkService

- (instancetype)init {
    return [self initWithDelegate:nil];
}

- (instancetype)initWithDelegate:(id <CDJSONBaseNetworkServiceDelegate>)delegate {
    if (self = [super init]) {
        _isLoaded = NO;
        _delegate = delegate;
        _httpRequestMethod = kHttpRequestTypePOST;
        _showLoginController=YES;
        _isNeedCache=NO;
        _isIgnoreCache=YES;
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

- (void)request:(NSString *)urlString params:(id)params {
    [self.task cancel];
    self.task=nil;
    _isCancelled = NO;
    
    [CDNetworkRequestManager removeService:self];
    
//    NSDictionary *paramsDic = [self packParameters:params];
    
    NSString *paramsString = params==nil ? @"" : [params cd_TransformToParamStringWithMethod:(kHttpRequestTypeGET)];
    self.cacheURLStringID=[[NSString stringWithFormat:@"%@%@",urlString,paramsString] cd_md5HexDigest];
    
    if (!self.isIgnoreCache  && [self.cache containsObjectForKey:self.cacheURLStringID]) {
        [self successfulGetResponse:[self.cache objectForKey:self.cacheURLStringID]];
        return;
    }
    
    switch (_httpRequestMethod) {
        case kHttpRequestTypePOST: {
            self.task = [self.manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error=nil;
                id responseObj=[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:&error];
                if (!error) {
                    if ([self isKindOfClass:[CDJSONBaseNetworkService class]]) {
                        _isLoaded = YES;
                        [self p_taskDidFinish:task responseObject:responseObj];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if ([self isKindOfClass:[CDJSONBaseNetworkService class]]) {
                    [self p_taskDidFail:task error:error];
                }
            }];
        }   break;
            
        case kHttpRequestTypeGET: {
            self.task = [self.manager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError *error=nil;
                id responseObj=[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:&error];
                if (!error) {
                    if ([self isKindOfClass:[CDJSONBaseNetworkService class]]) {
                        _isLoaded = YES;
                        [self p_taskDidFinish:task responseObject:responseObj];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if ([self isKindOfClass:[CDJSONBaseNetworkService class]]) {
                    [self p_taskDidFail:task error:error];
                }
            }];
        }   break;
    }
    
    //打印请求信息
    NSString *requestMethod=_httpRequestMethod==kHttpRequestTypePOST ? @"POST":@"GET";
    CDPRINT(@">>> %@ request url:%@",requestMethod,urlString);
    CDPRINT(@">>> %@ request parameters:\n%@",requestMethod,params);
    [CDNetworkRequestManager addService:self];
}

- (BOOL)isLoading {
    return (self.task.state == NSURLSessionTaskStateRunning || self.task.state == NSURLSessionTaskStateSuspended);
}

/**
 *  所有接口必传的参数在此封装
 */
- (NSMutableDictionary *)packParameters:(NSMutableDictionary *)params {
    NSMutableDictionary *paraDic = params ? [params mutableCopy] : [[NSMutableDictionary alloc] init];
//    [paraDic setObject:[CDUtilities cd_DefaultSource] forKey:@"source"];
//    [paraDic setObject:CDAppVersion forKey:@"appVersion"];
//    [paraDic setObject:(CDAccessToken() ?: @"") forKey:@"accessToken"];
//    [paraDic setObject:(CDAppId() ?: @"") forKey:@"appId"];
    return paraDic;
}

/* 请求完成 */
- (void)p_taskDidFinish:(NSURLSessionTask *)task responseObject:(id)responseObject {
    CDPRINT(@">>> URL:%@ response data:%@ ", task.currentRequest.URL,responseObject);
    if (self.task.state == NSURLSessionTaskStateCompleted) {
        [self successfulGetResponse:responseObject];
        self.task = nil;
        [CDNetworkRequestManager removeService:self];
    }
}

/* 请求失败 */
- (void)p_taskDidFail:(NSURLSessionTask *)task error:(NSError *)error {
    CDPRINT(@">>> response error:%@",[error localizedDescription]);// URL:%@ , task.currentRequest.URL
    if (self.task.state == NSURLSessionTaskStateCompleted || self.task.state == NSURLSessionTaskStateCanceling) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(request:didFailLoadWithError:)]) {
            [self.delegate request:self didFailLoadWithError:error];
        }
        self.task = nil;
        [CDNetworkRequestManager removeService:self];
    }
}

- (void)cancel {
    if (!self.task || self.task.state == NSURLSessionTaskStateCanceling || self.task.state == NSURLSessionTaskStateCompleted) {
        return;
    }
    [self.task cancel];
    _isCancelled = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(requestDidCancel:)]) {
        [_delegate requestDidCancel:self];
    }
    self.task=nil;
    [CDNetworkRequestManager removeService:self];
}

- (void)successfulGetResponse:(id)responseObject{
    _isLoaded = YES;
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestDidFinished:)]) {
        [self.delegate requestDidFinished:self];
    }
}

/**
 *  子类可覆写，把请求到的数据转换成模型
 */
- (void)requestDidFinish:(id)rootData {
    if (self.isNeedCache && self.cacheURLStringID) {
        if (!self.isIgnoreCache  && [self.cache containsObjectForKey:self.cacheURLStringID]) {
            return;
        }
        [self.cache setObject:rootData forKey:self.cacheURLStringID];
    }
}

@end
