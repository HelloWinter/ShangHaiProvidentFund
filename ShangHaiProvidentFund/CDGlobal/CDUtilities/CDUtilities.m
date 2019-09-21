//
//  CDUtilities.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "CDUtilities.h"
#import <AudioToolbox/AudioToolbox.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <SAMKeychain.h>


/**
 一. 将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
 二. 将这17位数字和系数相乘的结果相加。
 三. 用加出来和除以11，看余数是多少？
 四. 余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2。
 五. 通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。如果余数是10，身份证的最后一位号码就是2。
 */
NSString* getCheckDigit(NSString* eighteenCardID){
    NSArray *weightArr = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", nil ];
    NSArray *checkDigitArr = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    int remaining = 0;
    if (eighteenCardID.length == 18) {
        NSRange range = {0,17};
        eighteenCardID = [eighteenCardID substringWithRange:range];
    }
    if (eighteenCardID.length == 17) {
        NSInteger sum = 0;
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:17];
        // 先对前17位数字的权求和
        for (int i = 0; i < 17; i++) {
            NSRange range = {i,1};
            NSString* k = [eighteenCardID substringWithRange:range];
            [arr addObject:k];
            //            [arr addObject:k];
            //            arr[i] = Integer.parseInt(k);
        }
        for (int i = 0; i < 17; i++) {
            sum = sum + [weightArr[i] integerValue] * [arr[i] integerValue];
        }
        // 再与11取模
        remaining = sum % 11;
        arr = nil;
    }
    return  checkDigitArr[remaining];
}

/**
 将15位身份证升级成18位身份证号码
 */
NSString* update2eighteen(NSString *fifteenCardID){
    NSString *idCardStr = nil;
    // 15位身份证上的生日中的年份没有19，要加上
    NSRange range = {0,6};
    NSRange range1 = {6,9};
    idCardStr = [NSString stringWithFormat:@"%@19%@",[fifteenCardID substringWithRange:range],[fifteenCardID substringWithRange:range1]];
    idCardStr = [NSString stringWithFormat:@"%@%@",idCardStr,getCheckDigit(idCardStr)];
    return idCardStr;
}

BOOL verifyIDCard(NSString* idcard){
    if (idcard.length == 15) {
        idcard = update2eighteen(idcard);
    }
    if (idcard.length != 18) {
        return NO;
    }
    // 获取输入身份证上的最后一位，它是校验码
    NSRange rang = {17,1};
    NSString* checkDigit = [idcard substringWithRange:rang];
    // 比较获取的校验码与本方法生成的校验码是否相等
    if ([checkDigit isEqualToString:getCheckDigit(idcard)]) {
        return YES;
    }
    return NO;
}

BOOL stringMatchRex(NSString* str ,NSString* rex){
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

BOOL checkName(NSString *userName){
    BOOL canUse = NO;
    if (userName.length>0) {
        NSString * regex = @"^[\\u4e00-\\u9fa5·•.]+$";//校验姓名规则
        BOOL canChange = stringMatchRex(userName, regex);
        canUse = canChange;
    }
    return canUse;
}

NSString *CDKeyChainIDFV(){
    NSString *userName = @"IDFVKey";
    NSString *ServiceName = CDAppBundleID;
    NSString *strIDFV=[SAMKeychain passwordForService:ServiceName account:userName];
    if (strIDFV==nil || strIDFV.length==0) {
        NSError *setError=nil;
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        BOOL saved = [SAMKeychain setPassword:idfv forService:ServiceName account:userName error:&setError];
        if (!saved) {
            CDLog(@"保存时出错：%@", setError);
        }
        setError=nil;
        return idfv;
    }else{
        return strIDFV;
    }
}

CMMotionManager* shareMotion(){
    static dispatch_once_t onceToken;
    static CMMotionManager* _shakeMotion = nil;
    dispatch_once(&onceToken, ^{
        _shakeMotion = [[CMMotionManager alloc] init];
    });
    return _shakeMotion;
}

void startMotion(id target,SEL action){
    CMMotionManager* motion = shareMotion();
    if ([motion isDeviceMotionAvailable] == YES) {
        [motion startDeviceMotionUpdates];
        CDLog(@"motionStart!");
        [motion setDeviceMotionUpdateInterval:0.2];
        
        __block typeof(target) blockTarget = target;
        [motion startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            CGFloat devicevalue = 1.3;
            //            CMRotationRate rotationRate = deviceMotion.rotationRate;
            //            CMAttitude* attitude = deviceMotion.attitude;
            CMAcceleration acceleration = deviceMotion.userAcceleration;
            //            CMAcceleration gravaity = deviceMotion.gravity;
            
            CMAcceleration a ;
            a.x = ABS(acceleration.x);
            a.y = ABS(acceleration.y);
            a.z = ABS(acceleration.z);
            
            static NSInteger rotateCount = 0;
            //            CDLog(@"x:%f,y:%f,z:%f",a.x,a.y,a.z);
            if ((a.x>devicevalue &&a.x<10)||a.y>devicevalue||a.z>devicevalue){
                if (rotateCount==0){
                    if (blockTarget && [blockTarget respondsToSelector:action]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                        [blockTarget performSelector:action];
#pragma clang diagnostic pop
                    }
                    //播放震动
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
                rotateCount++;
            }else  {
                rotateCount = 0;
                //停止震动
                AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
            }
        }];
    }
}

void stopMotion(){
    if (shareMotion().deviceMotionActive){
        [shareMotion() stopDeviceMotionUpdates];
        CDLog(@"motionStoped!");
    }
}

BOOL isFirstLaunch() {
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSString *versionKey = CDAppVersion;
    NSInteger launchTimes = [userDefault integerForKey:versionKey];
    return launchTimes == 0;
}

void addLaunchTimes() {
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSString *versionKey = CDAppVersion;
    NSInteger launchTimes = [userDefault integerForKey:versionKey];
    launchTimes ++;
    [userDefault setInteger:launchTimes forKey:versionKey];
    [userDefault synchronize];
}

NSString *CDURLScheme() {
    NSArray *arr = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    NSString *scheme = nil;
    if (arr.count > 0) {
        NSDictionary *dic = arr[0];
        NSArray *subarr = [dic objectForKey:@"CFBundleURLSchemes"];
        if (subarr.count > 0) {
            scheme = subarr[0];
        }
    }
    return scheme;
}

void goToSettings(){
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
}

@implementation CDUtilities

+ (void)authenticateUserTouchID:(void (^)(void))completion{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //如果不设置的话,默认是"Enter Password(输入密码)",如果该属性设置为@""(空字符串),该按钮会被隐藏,只剩下取消按钮
        context.localizedFallbackTitle=@"";
        NSString* result = @"通过Home键验证已有手机指纹";
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                if (completion) {
                    completion();
                }
            } else {
                CDLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:{
                        CDLog(@"指纹验证被系统取消");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:{
                        CDLog(@"指纹验证被用户取消");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:{
                        CDLog(@"选择输入密码");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                        }];
                        break;
                    }
                    default:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    } else {
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:{
                CDLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:{
                CDLog(@"A passcode has not been set");
                break;
            }
            default:{
                CDLog(@"TouchID not available");
                break;
            }
        }
        CDLog(@"%@",error.localizedDescription);
    }
}

@end
