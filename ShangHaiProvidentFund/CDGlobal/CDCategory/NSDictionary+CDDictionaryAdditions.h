//
//  NSDictionary+CDDictionaryAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CDDictionaryAdditions)

/**
 *  返回字符串,如果为空返回@""
 */
- (NSString *)cd_stringObjectForKey:(id <NSCopying>)key;

/**
 *  如果为空返回nil
 */
- (id)cd_safeObjectForKey:(id <NSCopying>)key;

/**
 *  网络请求参数形式转换
 */
- (NSString *)cd_TransformToParamStringWithMethod:(HttpRequestType)method;

@end
