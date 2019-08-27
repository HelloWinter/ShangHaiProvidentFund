//
//  ImagePickerManager.m
//  ProvidentFund
//
//  Created by cdd on 16/9/12.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "ImagePickerManager.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@interface ImagePickerManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, assign) BOOL allowsEditing;
@property (nonatomic, copy) CDFinishPickingMedia finish;

@end

@implementation ImagePickerManager
DEF_SINGLETON(ImagePickerManager)

- (instancetype)init{
    self = [super init];
    if (self) {
        _allowsEditing = YES;
    }
    return self;
}

- (void)selectFromViewController:(UIViewController *)controller allowsEditing:(BOOL)allowsEdit canSelectAlbum:(BOOL)canSelectAlbum finifsh:(CDFinishPickingMedia)finish{
    if (!controller) {return;}
    self.controller = controller;
    _allowsEditing = allowsEdit;
    self.finish = finish;
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:actionCancel];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self p_presentUIImagePickerControllerWith:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertController addAction:actionCamera];
    if (canSelectAlbum) {
        UIAlertAction *actionPhotoLibrary=[UIAlertAction actionWithTitle:@"从手机相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self p_presentUIImagePickerControllerWith:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
        [alertController addAction:actionPhotoLibrary];
    }
    alertController.popoverPresentationController.sourceView = controller.view;
    alertController.popoverPresentationController.sourceRect = CGRectMake(controller.view.bounds.size.width*0.5, controller.view.bounds.size.height, 1.0, 1.0);
    [controller presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - private
- (void)p_presentUIImagePickerControllerWith:(UIImagePickerControllerSourceType)type{
    NSString *srcDesc = type == UIImagePickerControllerSourceTypeCamera ? @"相机" : @"相册";
    NSString *msg = [NSString stringWithFormat:@"请到设置-隐私-%@中开启%@的%@权限，感谢您的配合。",srcDesc,CDAppName,srcDesc];
    
    if (type == UIImagePickerControllerSourceTypeCamera) {
        if (![AVCaptureDevice defaultDeviceWithMediaType:(AVMediaTypeVideo)]) {
            [CDUIUtil showAlertWithTitle:nil message:@"您的设备不支持相机功能"];
            return;
        }
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            [CDUIUtil showAlertWithTitle:nil message:msg cancelButton:@"取消" cancelHandler:nil sureButton:@"去设置" sureHandler:^(UIAlertAction *action) {
                [self p_gotoSetting];
            }];
            return;
        }
    } else {
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied) {
            [CDUIUtil showAlertWithTitle:nil message:msg cancelButton:@"取消" cancelHandler:nil sureButton:@"去设置" sureHandler:^(UIAlertAction *action) {
                [self p_gotoSetting];
            }];
            return;
        }
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = self.allowsEditing;
    imagePicker.sourceType = type;
    [self.controller presentViewController:imagePicker animated:YES completion:nil];
}

- (void)p_gotoSetting{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (self.finish) {
        self.finish(info);
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

@end
