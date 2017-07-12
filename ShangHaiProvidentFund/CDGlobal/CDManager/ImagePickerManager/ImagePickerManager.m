//
//  ImagePickerManager.m
//  ProvidentFund
//
//  Created by cdd on 16/9/12.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "ImagePickerManager.h"

@interface ImagePickerManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ImagePickerManager

- (void)selectPicture{
    if (_delgate) {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"请选择文件来源" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [controller addAction:actionCancel];
        UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self p_presentUIImagePickerControllerWith:0];
        }];
        [controller addAction:actionCamera];
        UIAlertAction *actionPhotoLibrary=[UIAlertAction actionWithTitle:@"从手机相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self p_presentUIImagePickerControllerWith:1];
        }];
        [controller addAction:actionPhotoLibrary];
        controller.popoverPresentationController.sourceView = _delgate.view;
        controller.popoverPresentationController.sourceRect = CGRectMake(_delgate.view.bounds.size.width*0.5, _delgate.view.bounds.size.height, 1.0, 1.0);
        [_delgate presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - private
- (void)p_presentUIImagePickerControllerWith:(NSInteger)type{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = self.allowsEditing;
    imagePicker.sourceType = (type==0) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    [_delgate presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (_delgate && [_delgate respondsToSelector:@selector(imagePickerManagerdidFinishPickingMediaWithInfo:)]) {
        [_delgate imagePickerManagerdidFinishPickingMediaWithInfo:info];
        [picker dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

@end
