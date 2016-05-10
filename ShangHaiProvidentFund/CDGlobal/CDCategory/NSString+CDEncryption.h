//
//  NSString+CDEncryption.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CDEncryption)

/**
 *  md5加密
 *
 *  @return (NSString *) 密文
 */
- (NSString *)cd_md5HexDigest;

/**
 *  SHA-1加密
 *
 *  @return (NSString *) 密文
 */
- (NSString *)cd_sha1HexDigest;

- (NSString *)cd_AESencryptWithKey:(NSString*)key iv:(NSString *)Iv;

- (NSString *)cd_AESdecryptWithKey:(NSString *)key iv:(NSString *)Iv;

@end

@interface NSString (CDDateTransform)

/**
 *  将时间字符串按照给定的格式转换成date
 *
 *  @param dateFormat 转换的时间格式(默认为@"yyyy-MM-dd HH:mm:ss")
 *
 *  @return (NSDate *)
 */
- (NSDate *)cd_transformToDateWithDateFormat:(NSString *)dateFormat;

/**
 *  删除字符串里的某种字符(返回新的字符串)
 *
 *  @param character 特定字符
 *
 *  @return (NSMutableString *) 删除特定字符后的字符串
 */
- (NSMutableString*) cd_detleteCharacter:(NSString*) character;

/**
 *  将NSString类型转换为NSDictionary类型
 *
 *  @return (NSDictionary *)
 */
- (NSDictionary *) cd_transformToDictionary;

@end

@interface NSString (CDMatch)

/**
 *  是否不为空且不为空字符串
 *
 *  @return BOOL
 */
- (BOOL)cd_isNonEmpty;

/**
 *  输入字符内容匹配(主要用于过滤用户输入内容)
 *
 *  @param rules 匹配规则(例如:身份证@"0123456789xX")
 *
 *  @return (BOOL) 如果规则匹配成功返回YES,不成功返回NO
 */
- (BOOL)cd_matchingWithRules:(NSString *)rules;

/**
 *  正则匹配字符串中包含指定字符的个数
 *
 *  @param regex 正则表达式(例如:@"[0-9]",@"[A-Za-z]")
 *
 *  @return (NSInteger) 规则匹配字符的个数
 */
- (NSInteger)cd_matchingNumWithRegex:(NSString *)regex;

@end

@interface NSString (NumberStringFormat)

/**
 *  数字字符串超过三位，每隔3位加逗号格式化
 *
 *  @return (NSString *)格式化后的数字字符串
 */
-(NSString *)cd_numberStringFormat;

@end

