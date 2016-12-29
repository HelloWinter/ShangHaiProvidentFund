//
//  ImagePickerManager.m
//  ProvidentFund
//
//  Created by cdd on 16/9/12.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "ImagePickerManager.h"

@interface ImagePickerManager ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ImagePickerManager

- (void)selectPicture{
    if (_delgate) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择文件来源"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"拍照",@"从手机相册选择",nil];
        [actionSheet showInView:_delgate.view];
    }
}

#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0 || buttonIndex==1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = self.allowsEditing;
        imagePicker.sourceType = (buttonIndex==0) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
        [_delgate presentViewController:imagePicker animated:YES completion:nil];
    }
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
