//
//  CDCacheManager.m
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/26.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import "CDCacheManager.h"
#import "NSFileManager+CDFileManager.h"


@interface CDCacheManager ()

@property (nonatomic, strong, readwrite) YYCache *cache;
@property (nonatomic, strong, readwrite) YYMemoryCache *memorycache;

@end

@implementation CDCacheManager
DEF_SINGLETON(CDCacheManager)

- (YYCache *)cache{
    if (_cache==nil) {
        NSString *docPath = [[NSFileManager cd_documentPath] stringByAppendingString:[NSString stringWithFormat:@"/%@",CDAppBundleID]];
        _cache=[YYCache cacheWithPath:docPath];
    }
    return _cache;
}

- (YYMemoryCache *)memorycache{
    if (_memorycache == nil) {
        _memorycache = [[YYMemoryCache alloc]init];
        _memorycache.name = @"KCDCacheManagerMemoryCache";
        _memorycache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        _memorycache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
    }
    return _memorycache;
}

+ (NSString *)filePathforLoginInfo{
    return [[NSFileManager cd_cachesPath] stringByAppendingPathComponent:@"info.data"];
}

////////////////////////////////////////////////////////////////////////////////////////////

static NSString *const kUserLoginedKey = @"kUserLoginedKey";

+ (void)saveUserLogined:(BOOL)logined {
    [[CDCacheManager sharedInstance].cache setObject:@(logined) forKey:kUserLoginedKey];
}

+ (BOOL)isUserLogined {
    NSNumber *num = (NSNumber *)[[CDCacheManager sharedInstance].cache objectForKey:kUserLoginedKey];
    return num.boolValue;
}

////////////////////////////////////////////////////////////////////////////////////////////

static NSString *const kUserLocationKey = @"kUserLocationKey";

+ (void)saveUserLocation:(NSString *)location {
    [[CDCacheManager sharedInstance].cache setObject:location forKey:kUserLocationKey];
}

+ (NSString *)userLocation {
    return (NSString *)[[CDCacheManager sharedInstance].cache objectForKey:kUserLocationKey];
}

+ (void)removeUserLocation{
    [[CDCacheManager sharedInstance].cache removeObjectForKey:kUserLocationKey];
}

////////////////////////////////////////////////////////////////////////////////////////////

static NSString *const kUserNickNameKey = @"kUserNickNameKey";

+ (void)saveUserNickName:(NSString *)nickname {
    [[CDCacheManager sharedInstance].cache setObject:nickname forKey:kUserNickNameKey];
}

+ (NSString *)userNickName {
    return (NSString *)[[CDCacheManager sharedInstance].cache objectForKey:kUserNickNameKey];
}

+ (void)removeUserNickName{
    [[CDCacheManager sharedInstance].cache removeObjectForKey:kUserNickNameKey];
}

////////////////////////////////////////////////////////////////////////////////////////////

//+ (NSString *)getIPWithHostName:(NSString *)hostName {
//    const char * c_ip = [hostName UTF8String];
//    char * ipchar = calloc(hostName.length, sizeof(char));
//    strcpy(ipchar, c_ip);
//
//    struct addrinfo hints, *res, *res0;
//    int error, s;
//    const char * newChar = "No";
//
//    memset(&hints, 0, sizeof(hints));
//    hints.ai_family = PF_UNSPEC;
//    hints.ai_socktype = SOCK_STREAM;
//    hints.ai_flags = AI_DEFAULT;
//
//    error = getaddrinfo(ipchar, "http", &hints, &res0);
//    free(ipchar);
//
//    if (error) {
//        errx(1, "%s", gai_strerror(error));
//        /*NOTREACHED*/
//    }
//    s = -1;
//
//    static struct sockaddr_in6 * addr6;
//    static struct sockaddr_in * addr;
//    //    NSString * NewStr = NULL;
//    char ipbuf[32];
//
//    NSString * TempA = NULL;
//
//    for (res = res0; res; res = res->ai_next) {
//
//        if (res->ai_family == AF_INET6) {
//            addr6 =( struct sockaddr_in6*)res->ai_addr;
//            newChar = inet_ntop(AF_INET6, &addr6->sin6_addr, ipbuf, sizeof(ipbuf));
//            TempA = [[NSString alloc] initWithCString:(const char*)newChar
//                                             encoding:NSASCIIStringEncoding];
//
//            //            address = TempA;
//
//            //            NSString * TempB = [NSString stringWithUTF8String:"&&ipv6"];
//            //
//            //            NewStr = [TempA stringByAppendingString: TempB];
//            printf("%s\n", newChar);
//
//        } else {
//            addr =( struct sockaddr_in*)res->ai_addr;
//            newChar = inet_ntop(AF_INET, &addr->sin_addr, ipbuf, sizeof(ipbuf));
//            TempA = [[NSString alloc] initWithCString:(const char*)newChar
//                                             encoding:NSASCIIStringEncoding];
//            //            NSString * TempB = [NSString stringWithUTF8String:"&&ipv4"];
//            //
//            //            NewStr = [TempA stringByAppendingString: TempB];
//            printf("%s\n", newChar);
//        }
//
//        break;
//    }
//
//    freeaddrinfo(res0);
//
//    return TempA;
//}

@end
