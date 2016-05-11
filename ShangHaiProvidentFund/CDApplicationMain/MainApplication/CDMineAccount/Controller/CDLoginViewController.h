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
- (void)userDidLogin;

- (void)userCanceledLogin;

@end

@interface CDLoginViewController : CDBaseTableViewController

@property (nonatomic, weak) id<CDLoginViewControllerDelegate> delegate;

@end
