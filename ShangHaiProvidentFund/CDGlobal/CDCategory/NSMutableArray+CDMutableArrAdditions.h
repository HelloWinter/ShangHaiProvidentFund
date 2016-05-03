//
//  NSMutableArray+CDMutableArrAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (CDMutableArrAdditions)

/**
 *  可变数组倒序
 */
- (void)cd_reverse;

/**
 *  NSMutableArray addObject:的安全方法，避免anObject为nil时造成的崩溃
 */
- (void)cd_safeAddObject:(id)anObject;

/**
 *  NSMutableArray insertObject:atIndex:的安全方法，避免index越界以及anObject为nil时造成的崩溃
 */
- (void)cd_safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

/**
 *  NSMutableArray removeObjectAtIndex:的安全方法，避免数组越界造成的崩溃
 */
- (void)cd_safeRemoveObjectAtIndex:(NSUInteger)index;

/**
 *  NSMutableArray replaceObjectAtIndex:withObject:的安全方法，避免index越界以及anObject为nil时造成的崩溃
 */
- (void)cd_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/**
 *  NSMutableArray objectAtIndex:的安全方法，避免数组越界造成的崩溃
 */
- (id)cd_safeObjectAtIndex:(NSUInteger)index;

@end
