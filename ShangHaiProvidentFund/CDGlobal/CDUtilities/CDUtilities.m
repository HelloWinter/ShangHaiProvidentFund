//
//  CDUtilities.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "CDUtilities.h"
#import "SFHFKeychainUtils.h"
#import <AudioToolbox/AudioToolbox.h>
#import <LocalAuthentication/LocalAuthentication.h>

#ifdef DEBUG

NSString *const CDBaseURLString = @"http://person.shgjj.com";

#else

NSString *const CDBaseURLString = @"http://person.shgjj.com";

#endif

NSString* CDURLWithAPI(NSString* api) {
    return [NSString stringWithFormat:@"%@%@",CDBaseURLString,api];
}


CGFloat CDScale() {
    return [UIScreen mainScreen].scale;
}

//按角度旋转view
void rotateView(UIView* view,int degrees,float duration){
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformRotate(view.transform, Degrees_To_Radians(degrees));
    }];
}

UIViewController* CDFindTopModelViewController(UIViewController* vc){
    if (vc.presentedViewController) {
        while (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }
    }else {
        vc = nil;
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController*)vc visibleViewController];
    }
    return vc;
}

UIViewController* CDVisibalController() {
    
    UIViewController* appRootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ([appRootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tableBarVC = (UITabBarController*)appRootViewController;
        if (tableBarVC.presentedViewController) {
            return CDFindTopModelViewController(tableBarVC);
        }else {
            UINavigationController* selectedNav = (UINavigationController*)tableBarVC.selectedViewController;
            
            if (selectedNav.presentedViewController) {
                return CDFindTopModelViewController(selectedNav);
            }else {
                return selectedNav.topViewController;
            }
        }
    }else {
        if (appRootViewController.presentedViewController) {
            return CDFindTopModelViewController(appRootViewController);
        }else {
            return appRootViewController;
        }
    }
}

void showAlertViewWithTitleAndMessage(NSString *title, NSString *message) {
    if (!title || !message || message.length==0) {
        return;
    }
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:title.length>0 ? title:@"温馨提示"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil, nil];
    [alertView show];
}

void showAlertViewWithMessage(NSString *message) {
    showAlertViewWithTitleAndMessage(@"温馨提示", message);
}

CurrentDeviceScreenModel currentScreenModel(){
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        if (CGSizeEqualToSize(screenSize, CGSizeMake(320.0, 568.0))) {
            return CurrentDeviceScreenModel_4_0;
        }
        if (CGSizeEqualToSize(screenSize, CGSizeMake(375.0, 667.0))) {
            return CurrentDeviceScreenModel_4_7;
        }
        if (CGSizeEqualToSize(screenSize, CGSizeMake(414.0, 736.0))) {
            return CurrentDeviceScreenModel_5_5;
        }
    }
    return CurrentDeviceScreenModel_3_5;
}

UIColor* colorForHex(NSString* hexColor){
    if (hexColor.length) {
        NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        // String should be 6 or 8 characters
        
        if ([cString length] < 6) return [UIColor blackColor];
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
        if ([cString length] != 6) return [UIColor blackColor];
        
        // Separate into r, g, b substrings
        
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int r, g, b;
        
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }else {
        return nil;
    }
}

//一. 将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
//二. 将这17位数字和系数相乘的结果相加。
//三. 用加出来和除以11，看余数是多少？
//四. 余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2。
//五. 通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。如果余数是10，身份证的最后一位号码就是2。
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
 
 @param fifteenCardID
 @return (NSString *)
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
    if (isMatch){
        return YES;
    }else {
        return NO;
    }
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

NSString *pathForFileInDocumentsDirectory(NSString *filename) {
    return [CDDocumentPath stringByAppendingPathComponent:filename];
}

void removeAllCookies(){
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* cookies = [NSArray arrayWithArray:cookieStorage.cookies];
    for (NSHTTPCookie* cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
}

void setTokenToCookies(NSURL* url){
    removeAllCookies();
    //    NSString* token = replaceString(tokenLogin_accesstoken(), @"%2B", @"+") ;//tokenLogin_accesstoken();//
    //    NSString* appid = tokenLogin_appid();
    NSString* token = @"";
    NSString* appid = @"";
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    if (token&&appid) {
        NSString* cookieValue = [NSString stringWithFormat:@"&TOKEN=%@&APPID=%@&ALLEDN",token,appid];
        NSHTTPCookie *cookie1 = createCookieWithDomain(url.host, url.path, cookieValue, nil);
        [cookieStorage setCookie:cookie1];
    }
}


NSHTTPCookie *createCookieWithDomain(NSString* Tdomain,NSString* cookieName,NSString* cookieValue,NSDate* expiresDate){
    
    if (Tdomain&&cookieName&&cookieValue) {
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:cookieName forKey:NSHTTPCookieName];
        [cookieProperties setObject:cookieValue forKey:NSHTTPCookieValue];
        [cookieProperties setObject:Tdomain forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
        if (expiresDate) {
            [cookieProperties setObject:expiresDate forKey:NSHTTPCookieExpires];
        }
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        return cookie;
    }else {
        return nil;
    }
}

NSHTTPCookie *cookieForDomain(NSString* tDomain,NSString* cookieName){
    for (NSHTTPCookie* cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
        if ([cookie.domain isEqualToString:tDomain]) {
            if ([cookie.name isEqualToString:cookieName]) {
                return cookie;
            }
        }
    }
    return nil;
}

/**
 *清除域名下的session信息
 */
void removeSessionWitnDomain(NSString* domain){
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray* cookies = [NSArray arrayWithArray:cookieStorage.cookies];
    
    for (NSHTTPCookie* cookie in cookies) {
        if ([cookie.domain isEqualToString:domain]){
            if ([cookie.name isEqualToString:@"--------"]){
                [cookieStorage deleteCookie:cookie];
            }
            if ([cookie.name isEqualToString:@"--------"]){
                [cookieStorage deleteCookie:cookie];
            }
        }
    }
}
/**
 *强制将登录域名下的session刷如TDomain对应的cookies里实现联合登录
 */
void forceSetSessionToCookieWithDomain(NSString* FromDomain,NSString* Tdomain){
     NSHTTPCookie *orginCookie1 = cookieForDomain(FromDomain,@"--------");
     NSHTTPCookie *orginCookie2 = cookieForDomain(FromDomain,@"--------");
     if (orginCookie1&&orginCookie2) {
         if (Tdomain!=FromDomain) {
             removeSessionWitnDomain(Tdomain);
         }
         NSHTTPCookie *cookie1 = createCookieWithDomain(Tdomain, orginCookie1.name, orginCookie1.value, orginCookie1.expiresDate);
         NSHTTPCookie *cookie2 = createCookieWithDomain(Tdomain, orginCookie2.name, orginCookie2.value, orginCookie2.expiresDate);
 
         [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie1];
         [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie2];
     }
}

NSDictionary* sessionsForDomain(NSString* domain){
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSHTTPCookie* cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
        if ([cookie.domain isEqualToString:domain]) {
            [dic setObject:cookie.value forKey:cookie.name];
        }
    }
    return dic;
}

/**
 获取uuid
 */
NSString* gen_uuid(){
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

NSString *CDKeyChainUUID(){
    NSError *error;
    NSString *userName = @"UUIDKey";
    NSString *ServiceName = @"come.cd.product";
    NSString *struuid=[SFHFKeychainUtils getPasswordForUsername:userName andServiceName:ServiceName error:&error];
    if (struuid==nil || struuid.length==0) {
        NSString *str=gen_uuid();
        /* 保存uuid */
        BOOL saved = [SFHFKeychainUtils storeUsername:userName
                                          andPassword:str
                                       forServiceName:ServiceName
                                       updateExisting:YES
                                                error:&error ];
        if (!saved) {
            CDPRINT(@"保存时出错：%@", error);
        }
        error = nil;
        return str;
    }else{
        return struuid;
    }
}

NSDictionary* ProjectSettings(){
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProjectSettings" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

//NSString* defaultSource(){
//    NSDictionary* dic = ProjectSettings();
//    if (dic){
//        return [dic objectForKey:@"DefaultSource"];
//    }else {
//        return nil;
//    }
//}

NSString* bundleAppID(){
    NSDictionary* dic = ProjectSettings();
    if (dic){
        return [dic objectForKey:@"Appstore AppID"];
    }else {
        return nil;
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
        CDPRINT(@"motionStart!");
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
            //            CDPRINT(@"x:%f,y:%f,z:%f",a.x,a.y,a.z);
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
        CDPRINT(@"motionStoped!");
    }
}

void openURLToUpdateEnterpriseEditionAPP(NSString* url,UIView* parentView){
    UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [callPhoneWebVw loadRequest:request];
    [parentView addSubview:callPhoneWebVw];
}

void callPhoneNum(NSString* phoneNum){
    if ([CDDeviceModel isEqualToString:@"iPhone"]){
        NSURL *telUrl=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
        if ([[UIApplication sharedApplication]canOpenURL:telUrl]) {
            [[UIApplication sharedApplication] openURL:telUrl];
        }else{
            showAlertViewWithMessage(@"号码有误");
        }
    }else {
        NSString *strAlert=[NSString stringWithFormat:@"您的设备 %@ 不支持电话功能！",CDDeviceModel];
        showAlertViewWithMessage(strAlert);
    }
}

void commentApp(){
    NSString* url = nil;
    NSString* appId = bundleAppID();
    if (CDSystemVersionFloatValue>=7.0) {
        url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
    }else {
        url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appId];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

void shakeView(UIView* view){
    
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.1];
    
    shake.toValue = [NSNumber numberWithFloat:+0.1];
    
    shake.duration = 0.1;
    
    shake.autoreverses = YES; //是否重复
    
    shake.repeatCount = 4;
    
    [view.layer addAnimation:shake forKey:@"imageView"];
}

void shakeLeftAndRightWithView(UIView *view) {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.3;
    NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:8];
    for (int idx = 0; idx < 4; idx ++) {
        [values addObject:[NSValue valueWithCGPoint:CGPointMake(view.centerX - 15, view.centerY)]];
        [values addObject:[NSValue valueWithCGPoint:CGPointMake(view.centerX + 15, view.centerY)]];
    }
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
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

@implementation CDUtilities

+ (NSString *)transformToStringDateFromTimestamp:(NSTimeInterval)timestamp WithDateFormat:(NSString *)dateFormat{
    if (!dateFormat) {
        dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }
    NSDateFormatter *tempFormat = [[NSDateFormatter alloc] init];
    [tempFormat setDateFormat:dateFormat];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [tempFormat stringFromDate:confromTimesp];
}

+ (CGSize) sizeWithText:(NSString *)text WithFont:(UIFont *)font {
//    if ([NSString instanceMethodForSelector:@selector(sizeWithFont:)]) {
//        return [text sizeWithFont:font];
//    }
    if ([NSString instanceMethodForSelector:@selector(sizeWithAttributes:)]) {
        return [text sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    return CGSizeZero;
}

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
                CDPRINT(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:{
                        CDPRINT(@"指纹验证被系统取消");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:{
                        CDPRINT(@"指纹验证被用户取消");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:{
                        CDPRINT(@"选择输入密码");
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
                CDPRINT(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:{
                CDPRINT(@"A passcode has not been set");
                break;
            }
            default:{
                CDPRINT(@"TouchID not available");
                break;
            }
        }
        CDPRINT(@"%@",error.localizedDescription);
    }
    
}

@end
