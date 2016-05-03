//
//  NSDate+CDDateAddition.h
//  CDAppDemo
//
//  Created by Cheng on 15/9/4.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CDDateAddition)

/**
 *  将NSDate对象按照给定的格式转换成时间字符串
 *
 *  @param dateFormat 转换的时间格式(默认为@"yyyy-MM-dd HH:mm:ss")
 *
 *  @return (NSString *)
 */
- (NSString *)cd_transformToStringWithDateFormat:(NSString *)dateFormat;

/**
 *  判断日期是否是今天
 */
- (BOOL)isToday;

@end
