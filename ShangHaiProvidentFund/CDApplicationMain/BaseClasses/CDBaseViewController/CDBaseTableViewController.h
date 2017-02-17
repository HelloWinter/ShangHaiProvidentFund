//
//  CDBaseTableViewController.h
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//


#import "CDBaseViewController.h"

@interface CDBaseTableViewController : CDBaseViewController<UITableViewDataSource,UITableViewDelegate>{
@protected
    /**
     *  弹出键盘的bounds
     */
    CGRect _keyboardBounds;
    /**
     *  弹出键盘的动画时间
     */
    NSTimeInterval _keybardAnmiatedTimeinterval;
}

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, assign) BOOL showDragView;  //是否显示下拉加载(默认YES)

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

//- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle;

/**
 *  开始下拉刷新，需要子类覆写
 */
- (void)startPullRefresh;

/**
 结束下拉刷新
 */
- (void)endPullRefresh;

- (void)keyboardWillShow:(NSNotification *)notification;

- (void)keyboardDidShow:(NSNotification *)notification;

- (void)keyboardWillHide:(NSNotification *)notification;

- (void)keyboardDidHide:(NSNotification *)notification;

- (void)keyboardWillChange:(NSNotification *)notification;

@end
