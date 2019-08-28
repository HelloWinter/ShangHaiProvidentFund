//
//  CDUploadImageService.m
//  MoneyMore
//
//  Created by cdd on 15-5-12.
//  Copyright (c) 2015年 ___9188___. All rights reserved.
//

#import "CDUploadImageService.h"
#import "AFNetworking.h"
#import "SCYActivityIndicatorView.h"
#import "CDAutoHideMessageHUD.h"
#import "CDGlobalHTTPSessionManager.h"
//#import <NSData+ImageContentType.h>

@interface CDUploadImageService ()

@property (nonatomic, strong) NSURLSessionDataTask *uploadOperation;
@property (nonatomic, copy) id responseData;
@property (nonatomic, assign, readwrite) BOOL isUploading;

@end

@implementation CDUploadImageService

- (instancetype)init{
    self = [super init];
    if (self) {
        self.compressionQuality = 0.5;
    }
    return self;
}

- (void)uploadImageData:(NSData *)data params:(id)params toURL:(NSString *)url{
//    if ([NSData sd_imageFormatForImageData:data]!=SDImageFormatJPEG) {
//        [CDAutoHideMessageHUD showMessage:@"图片格式必须为jpeg格式"];
//        return;
//    }
    NSString *fileName = [self generateImageName];
    NSDictionary *paraDic = [self packParameters:params];
    CDGlobalHTTPSessionManager *manager=[CDGlobalHTTPSessionManager sharedManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    WS(weakSelf);
    self.uploadOperation = [manager POST:url parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
        [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(service:uploadImageProgress:)]) {
            [weakSelf.delegate service:self uploadImageProgress:uploadProgress];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self->_isUploading=NO;
        [SCYActivityIndicatorView stopAnimating];
        NSError *error=nil;
        _responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if (!error) {
            CDLog(@"uploadImageSuccessResponse->%@", _responseData);
            if ([_responseData isKindOfClass:[NSDictionary class]]) {
                NSString *code=[NSString stringWithFormat:@"%@",[_responseData objectForKey:@"code"]];
                if ([code isEqualToString:@"1"]) {
                    if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageSucceedWithResponseData:)]) {
                        [_delegate service:self uploadImageSucceedWithResponseData:_responseData];
                    }
                }else{
                    NSString *desc=[_responseData objectForKey:@"desc"];
                    [CDAutoHideMessageHUD showMessage:desc];
                    if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageFailedWithError:)]) {
                        [_delegate service:self uploadImageFailedWithError:error];
                    }
                }
            }
        }else{
            [CDAutoHideMessageHUD showMessage:@"返回json数据格式错误"];
            if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageFailedWithError:)]) {
                [_delegate service:self uploadImageFailedWithError:error];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _isUploading=NO;
        [SCYActivityIndicatorView stopAnimating];
        if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageFailedWithError:)]) {
            [_delegate service:self uploadImageFailedWithError:error];
        }
    }];
    _isUploading=YES;
    [SCYActivityIndicatorView startAnimating];
}

- (void)uploadImages:(NSArray<UIImage *> *)images name:(NSString *)name params:(id)params toURL:(NSString *)url{
    if (images == nil || images.count == 0) {
        return;
    }
    NSDictionary *paraDic = [self packParameters:params];
    CDGlobalHTTPSessionManager *manager=[CDGlobalHTTPSessionManager sharedManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.uploadOperation = [manager POST:url parameters:paraDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
        for (int i = 0; i < images.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(images[i], self.compressionQuality);
            //fileName ：要保存在服务器上的文件名
            NSString *fileName = [NSString stringWithFormat:@"%@%.0f.jpg",name, CFAbsoluteTimeGetCurrent() * 1000000];
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageProgress:)]) {
            [_delegate service:self uploadImageProgress:uploadProgress];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _isUploading=NO;
        [SCYActivityIndicatorView stopAnimating];
        NSError *error=nil;
        _responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if (!error) {
            CDLog(@"uploadImageSuccessResponse->%@", _responseData);
            if ([_responseData isKindOfClass:[NSDictionary class]]) {
                NSString *code=[NSString stringWithFormat:@"%@",[_responseData objectForKey:@"code"]];
                if ([code isEqualToString:@"1"]) {
                    if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageSucceedWithResponseData:)]) {
                        [_delegate service:self uploadImageSucceedWithResponseData:_responseData];
                    }
                }else{
                    NSString *desc=[_responseData objectForKey:@"desc"];
                    [CDAutoHideMessageHUD showMessage:desc];
                    if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageFailedWithError:)]) {
                        [_delegate service:self uploadImageFailedWithError:error];
                    }
                }
            }
        }else{
            [CDAutoHideMessageHUD showMessage:@"返回json数据格式错误"];
            if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageFailedWithError:)]) {
                [_delegate service:self uploadImageFailedWithError:error];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _isUploading=NO;
        [SCYActivityIndicatorView stopAnimating];
        if (_delegate && [_delegate respondsToSelector:@selector(service:uploadImageFailedWithError:)]) {
            [_delegate service:self uploadImageFailedWithError:error];
        }
    }];
    _isUploading=YES;
    [SCYActivityIndicatorView startAnimating];
}

- (void)stopUpload {
    [self.uploadOperation cancel];
}

/**
 *  生成图片名
 */
- (NSString *)generateImageName{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"usericon%@.jpg", str];
}

/**
 *  封装参数
 */
- (NSMutableDictionary *)packParameters:(NSMutableDictionary *)params {
    NSMutableDictionary *paraDic = params ? [params mutableCopy] : [[NSMutableDictionary alloc] init];
    //封装必传参数
    return paraDic ;
}

@end
