//
//  CDBaseService.h
//  MoneyMore
//
//  Created by cdd on 15-5-12.
//  Copyright (c) 2015年 ___9188___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HttpRequestType) {
    kHttpRequestTypePOST,
    kHttpRequestTypeGET
};

@interface CDBaseService : NSObject{
@protected
    NSString *_returnCode;
    NSString *_desc;
    id _rootData;
}

/**
 *  请求完成后收到的服务端返回的状态码，1为成功，其他则为失败
 */
@property (nonatomic, copy, readonly) NSString *returnCode;

/**
 *  请求完成后收到的服务端返回的描述
 */
@property (nonatomic, copy, readonly) NSString *desc;

/**
 *  服务端返回的根数据
 */
@property (nonatomic, strong, readonly) id rootData;

@end
