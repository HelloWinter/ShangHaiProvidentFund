//
//  ImagePickerManager.h
//  ProvidentFund
//
//  Created by cdd on 16/9/12.
//  Copyright © 2016年 9188. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImagePickerManagerDelegate <NSObject>

- (void)imagePickerManagerdidFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;

@end

@interface ImagePickerManager : NSObject

@property (nonatomic, weak) UIViewController<ImagePickerManagerDelegate> *delgate;

/**
 是否允许编辑
 */
@property (nonatomic, assign) BOOL allowsEditing;

/**
 选择图片
 */
- (void)selectPicture;

@end
