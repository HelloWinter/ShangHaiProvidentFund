//
//  NSData+CDDataAddition.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by cdd on 15/7/20.
//  Copyright (c) 2015年 9188. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CDDataAddition)

/**
 *  AES128加密
 *
 *  @param key 加密秘钥
 *
 *  @return (NSData *)加密后数据
 */
- (NSData *)cd_encryptionWithKey:(NSString *)key iv:(NSString *)Iv;

/**
 *  AES2128解密
 *
 *  @param key 解密秘钥
 *
 *  @return 源数据
 */
- (NSData *)cd_decryptionWithKey:(NSString *)key iv:(NSString *)Iv;

@end
