//
//  CDAPPURLConfigure.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAPPURLConfigure.h"

#ifdef DEBUG

NSString *const CDBaseURLString = @"http://person.shgjj.com";

NSString *const CDBaseWebURLString = @"http://www.shgjj.com";

#else

NSString *const CDBaseURLString = @"http://person.shgjj.com";

NSString *const CDBaseWebURLString = @"http://www.shgjj.com";

#endif

NSString* CDURLWithAPI(NSString* api) {
    return [NSString stringWithFormat:@"%@%@",CDBaseURLString,api];
}

NSString* CDWebURLWithAPI(NSString* api) {
    return [NSString stringWithFormat:@"%@%@",CDBaseWebURLString,api];
}

////////////////////////////////////////////////////////////////////////////////////////////

static NSString *const kUserLoginedKey = @"kUserLoginedKey";

void CDSaveUserLogined(BOOL logined) {
    [[NSUserDefaults standardUserDefaults] setBool:logined forKey:kUserLoginedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

BOOL CDIsUserLogined() {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserLoginedKey];
}

////////////////////////////////////////////////////////////////////////////////////////////

static NSString *const kUserLocationKey = @"kUserLocationKey";

void CDSaveUserLocation(NSString *location) {
    [[NSUserDefaults standardUserDefaults] setObject:location forKey:kUserLocationKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

NSString *CDUserLocation() {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserLocationKey];
}

void CDRemoveUserLocation(){
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserLocationKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

////////////////////////////////////////////////////////////////////////////////////////////

@implementation CDAPPURLConfigure

+ (NSString *)filePathforLoginInfo{
    return [CDCachesPath stringByAppendingPathComponent:@"info.data"];
}

+ (NSString *)AMapKey{
    return @"KrRRUyLkF7Pr2of2FFX8v2LZ3XkAP32E";
}

@end
