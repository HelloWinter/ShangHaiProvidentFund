//
//  CDBaseTableViewController.m
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDBaseTableViewController.h"
#import "UITableView+CDTableViewAddition.h"
#import "ODRefreshControl.h"


@interface CDBaseTableViewController ()

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, strong) ODRefreshControl * refreshControl;

@end

@implementation CDBaseTableViewController
@synthesize tableView=_tableView;

- (void)dealloc{
    _tableView.dataSource=nil;
    _tableView.delegate=nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpInitWithTableViewStyle:UITableViewStylePlain];
    }
    return self;
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super init];
    if (self) {
        [self setUpInitWithTableViewStyle:tableViewStyle];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUpInitWithTableViewStyle:UITableViewStylePlain];
    }
    return self;
}

- (void)setUpInitWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    _tableViewStyle= tableViewStyle;
    self.showDragView = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    if (self.showDragView) {
        if (!self.navigationController.navigationBarHidden) {
            [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight];
        }
        _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        [_refreshControl addTarget:self action:@selector(startPullRefresh) forControlEvents:UIControlEventValueChanged];
    }
}

- (UITableView *)tableView{
    if (_tableView == nil) {
//        CGRect rect=self.view.bounds;
//        if (self.showDragView && !self.navigationController.navigationBarHidden) {
            CGRect rect=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
//        }
        _tableView = [[UITableView alloc] initWithFrame:rect style:_tableViewStyle];
        _tableView.dataSource=self;
        _tableView.delegate = self;
        _tableView.backgroundView = nil;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        [_tableView cd_clearNeedlessCellLine];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc]init];
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)requestDidFinished:(CDJSONBaseNetworkService *)service {
    [super requestDidFinished:service];
    if (self.showDragView) {
        [self.refreshControl endRefreshing];
    }
}

- (void)requestDidCancel:(CDJSONBaseNetworkService *)service {
    [super requestDidCancel:service];
    if (self.showDragView) {
        [self.refreshControl endRefreshing];
    }
}

- (void)request:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error {
    [super request:service didFailLoadWithError:error];
    if (self.showDragView) {
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - Public
- (void)startPullRefresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (void)endPullRefresh{
    [self.refreshControl endRefreshing];
}

@end
