//
//  CDBaseTableViewController.h
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//


#import "CDBaseViewController.h"

@interface CDBaseTableViewController : CDBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, assign) BOOL showDragView;  //是否显示下拉加载(默认YES)

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle;

/**
 *  开始下拉刷新，需要子类覆写
 */
- (void)startPullRefresh;

- (void)endPullRefresh;

@end
