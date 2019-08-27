//
//  ImagePickerManager.h
//  ProvidentFund
//
//  Created by cdd on 16/9/12.
//  Copyright © 2016年 9188. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CDFinishPickingMedia)(NSDictionary *info);

@interface ImagePickerManager : NSObject
AS_SINGLETON(ImagePickerManager)

- (void)selectFromViewController:(UIViewController *)controller allowsEditing:(BOOL)allowsEdit canSelectAlbum:(BOOL)canSelectAlbum finifsh:(CDFinishPickingMedia)finish;

@end
