//
//  CDUploadImageService.h
//  MoneyMore
//
//  Created by cdd on 15-5-12.
//  Copyright (c) 2015年 ___9188___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDUploadImageService;

@protocol CDUploadImageServiceDelegate <NSObject>

@optional
/**
 *  上传进度
 */
- (void)service:(CDUploadImageService *)service uploadImageProgress:(NSProgress *)uploadProgress;

/**
 *  上传图片成功
 *
 *  @param service      CDUploadImageService
 *  @param responseData 上传图片成功响应json数据
 */
- (void)service:(CDUploadImageService *)service uploadImageSucceedWithResponseData:(id)responseData;

/**
 *  上传图片失败
 *
 *  @param service CDUploadImageService
 *  @param error   上传图片失败错误信息
 */
- (void)service:(CDUploadImageService *)service uploadImageFailedWithError:(NSError *)error;

@end

@interface CDUploadImageService : NSObject

@property (nonatomic, weak) id<CDUploadImageServiceDelegate> delegate;

/**
 *  图片压缩质量（默认0.5）
 */
@property (nonatomic, assign) CGFloat compressionQuality;

/**
 *  是否正在上传图片
 */
@property (nonatomic, assign, readonly) BOOL isUploading;

/**
 *  上传单张图片的数据
 *
 *  @param data   图片数据
 *  @param params 参数
 *  @param url    上传地址
 */
- (void)uploadImageData:(NSData *)data params:(id)params toURL:(NSString *)url;

/**
 *  多图上传
 *  images : 多图数组
 *  name : 服务器端处理文件的字段
 *  mimeType ：上传的文件的类型
 */
- (void)uploadImages:(NSArray<UIImage *> *)images name:(NSString *)name params:(id)params toURL:(NSString *)url;

/**
 *  停止上传
 */
- (void)stopUpload;

@end
