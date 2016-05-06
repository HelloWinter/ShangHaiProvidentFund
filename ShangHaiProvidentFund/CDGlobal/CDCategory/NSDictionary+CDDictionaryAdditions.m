//
//  NSDictionary+CDDictionaryAdditions.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "NSDictionary+CDDictionaryAdditions.h"
#import "NSArray+CDArrayAdditions.h"

@implementation NSDictionary (CDDictionaryAdditions)

- (NSString *)cd_stringObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null] || ob == nil) {
        return (@"");
    }
    if([ob isKindOfClass:[NSString class]]) {
        return (ob);
    }
    return ([NSString stringWithFormat:@"%@", ob]);
}

- (id)cd_safeObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null]) {
        return (nil);
    }
    return (ob);
}

- (NSString *)cd_TransformToParamStringWithMethod:(HttpRequestType)method{
    NSMutableString *str=[[NSMutableString alloc]init];
    for (int i=0; i<self.allKeys.count; i++) {
        [str appendFormat:@"%@%@=%@",(i==0 ? (method==kHttpRequestTypeGET ? @"?" : @"") : @"&"),[self.allKeys cd_safeObjectAtIndex:i],[self.allValues cd_safeObjectAtIndex:i]];
    }
    return str;
}

@end
