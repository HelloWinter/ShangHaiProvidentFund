//
//  NSFileManager+CDFileManager.m
//  CDAppDemo
//
//  Created by Cheng on 15/9/26.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "NSFileManager+CDFileManager.h"

@implementation NSFileManager (CDFileManager)

+ (NSString *)pathForDirectory:(NSSearchPathDirectory)directory{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

+ (NSString *)cd_documentPath{
    return [self pathForDirectory:NSDocumentDirectory];
}

+ (NSString *)cd_libraryPath{
    return [self pathForDirectory:NSLibraryDirectory];
}

+ (NSString *)cd_cachesPath{
    return [self pathForDirectory:NSCachesDirectory];
}

@end
