//
//  CDLoginViewController.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTableViewController.h"

@protocol CDLoginViewControllerDelegate <NSObject>

@optional
/**
 *  用户已登录
 */
- (void)userDidLogin;

/**
 *  用户取消登录
 */
- (void)userCanceledLogin;

@end

@interface CDLoginViewController : CDBaseTableViewController

@property (nonatomic, weak) id<CDLoginViewControllerDelegate> delegate;

@end
