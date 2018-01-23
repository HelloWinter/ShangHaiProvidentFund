//
//  SCYUserScreenshotManager.h
//  ProvidentFund
//
//  Created by cd on 2018/1/17.
//  Copyright © 2018年 9188. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SCYUserDidTakeScreenshotBlock)(UIImage *);

@interface SCYUserScreenshotManager : NSObject

+ (SCYUserScreenshotManager *)sharedManager;

@property (nonatomic, copy) SCYUserDidTakeScreenshotBlock screenshotBlock;

/**
 开始监视用户屏幕截图
 */
- (void)startObserve;

/**
 停止监视用户屏幕截图
 */
- (void)stopObserve;

@end

@interface SCYScreentshotButton : UIButton

@end
