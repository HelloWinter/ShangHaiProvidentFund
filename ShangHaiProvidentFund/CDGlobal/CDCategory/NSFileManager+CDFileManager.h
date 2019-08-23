//
//  NSFileManager+CDFileManager.h
//  CDAppDemo
//
//  Created by Cheng on 15/9/26.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CDFileManager)
/**
 *  documents文件夹路径
 *
 *  @return (NSString *)
 */
+ (NSString *)cd_documentPath;
/**
 *  library文件夹路径
 *
 *  @return (NSString *)
 */
+ (NSString *)cd_libraryPath;
/**
 *  caches文件夹路径
 *
 *  @return (NSString *)
 */
+ (NSString *)cd_cachesPath;

@end
