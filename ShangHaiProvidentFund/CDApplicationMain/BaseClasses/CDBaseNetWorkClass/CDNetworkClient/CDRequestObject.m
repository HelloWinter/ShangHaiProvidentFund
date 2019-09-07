//
//  CDRequestObject.m
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import "CDRequestObject.h"
#import "NSString+CDEncryption.h"

@implementation CDRequestObject

@synthesize parameters = _parameters;

- (instancetype)init{
    self = [super init];
    if (self) {
        self.addCommonParam = YES;
        self.URLString = nil;
        self.parameters = nil;
        self.printLog = YES;
    }
    return self;
}

- (void)setParameters:(id)parameters{
    if (parameters) {
        NSAssert([parameters isKindOfClass:[NSDictionary class]], @"参数非字典类型");
    }
    _parameters = self.addCommonParam ? [self packParameters:parameters] : parameters;
}

- (NSDictionary *)packParameters:(NSMutableDictionary *)params {
    NSMutableDictionary *parametersDic = params ? [params mutableCopy] : [[NSMutableDictionary alloc] init];
    [parametersDic setObject:@"iOS" forKey:@"os"];
    [parametersDic setValue:CDAppVersion forKey:@"appVersion"];
    NSString *sysVersion = [NSString stringWithFormat:@"%@，%@",CDDeviceModel,CDSystemVersion];
    [parametersDic setValue:sysVersion forKey:@"sysVersion"];
    [parametersDic setObject:CDKeyChainIDFV() forKey:@"mac"];
    return parametersDic;
}

- (NSString *)cacheID{
    NSMutableString *str=[NSMutableString stringWithString:self.URLString];
    if (self.parameters) {
        NSDictionary *dict = self.parameters;
        for (int i=0; i<dict.allKeys.count; i++) {
            NSString *key = [dict.allKeys objectAtIndex:i];
            [str appendFormat:@"%@%@=%@",(i==0 ? @"?" : @"&"),key,[dict.allValues objectAtIndex:i]];
        }
    }
    return [str cd_md5HexDigest];
}

@end
