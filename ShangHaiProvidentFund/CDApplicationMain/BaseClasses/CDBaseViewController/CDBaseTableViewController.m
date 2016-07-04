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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setupPullRefreshView];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
        if (!self.hidesBottomBarWhenPushed) {
            _tableView.height-=49;
        }
        if (!self.navigationController.navigationBarHidden) {//self.showDragView && 
            _tableView.height-=64;
        }
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

#pragma mark - KeyBoardNotification
- (void)keyboardWillShow:(NSNotification *)notification{
    NSValue* keyboardboundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue* keybardAnimatedValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [keyboardboundsValue getValue:&_keyboardBounds];
    [keybardAnimatedValue getValue:&_keybardAnmiatedTimeinterval];
    
    UIEdgeInsets insets=self.tableView.contentInset;
    insets.bottom=_keyboardBounds.size.height;
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (void)keyboardDidShow:(NSNotification*)notification {
}

- (void)keyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:_keybardAnmiatedTimeinterval animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
    }];
}

- (void)keyboardDidHide:(NSNotification*)notification {
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

#pragma mark - private
- (void)setupPullRefreshView{
    if (self.showDragView) {
        if (!self.navigationController.navigationBarHidden) {
            [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeRight];//UIRectEdgeBottom |
        }
        _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        [_refreshControl addTarget:self action:@selector(startPullRefresh) forControlEvents:UIControlEventValueChanged];
    }
}

@end
