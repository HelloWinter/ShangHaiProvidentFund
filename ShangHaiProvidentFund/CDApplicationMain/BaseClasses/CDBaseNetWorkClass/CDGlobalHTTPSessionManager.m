//
//  CDGlobalHTTPSessionManager.m
//  ProvidentFund
//
//  Created by cdd on 16/4/29.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "CDGlobalHTTPSessionManager.h"

@interface CDGlobalHTTPSessionManager ()

@end

@implementation CDGlobalHTTPSessionManager

+ (instancetype)sharedManager{
    static CDGlobalHTTPSessionManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        manager = [[CDGlobalHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:configuration];
//        manager.securityPolicy=[CDGlobalHTTPSessionManager customSecurityPolicy];
//        manager.securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval=60;
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        /*
         <AFURLRequestSerialization>
         AFHTTPRequestSerializer
         AFJSONRequestSerializer
         AFPropertyListRequestSerializer
         <AFURLResponseSerialization>
         AFHTTPResponseSerializer
         AFJSONResponseSerializer
         AFXMLParserResponseSerializer
         AFXMLDocumentResponseSerializer (Mac OS X)
         AFPropertyListResponseSerializer
         AFImageResponseSerializer
         AFCompoundResponseSerializer
         */
        
        //    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        //    manager.securityPolicy.allowInvalidCertificates = YES;
        //    manager.securityPolicy.validatesDomainName = NO;
        
        //    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"cookie"];
        //    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"If-Modified-Since"];
        //    [manager.requestSerializer setTimeoutInterval:15];
        //    manager.requestSerializer.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    });
    return manager;
}

+ (AFSecurityPolicy*)customSecurityPolicy{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"rainbow" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    return securityPolicy;
}

@end
