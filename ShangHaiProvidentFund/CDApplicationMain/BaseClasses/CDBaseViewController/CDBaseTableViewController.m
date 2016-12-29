//
//  CDBaseTableViewController.m
//  ProvidentFund
//
//  Created by cdd on 15/12/9.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDBaseTableViewController.h"
#import "UITableView+CDTableViewAddition.h"
//#import "ODRefreshControl.h"
#import "SCYRefreshControl.h"


@interface CDBaseTableViewController ()

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
//@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (nonatomic, strong) SCYRefreshControl *refreshControl;

@end

@implementation CDBaseTableViewController
@synthesize tableView=_tableView;

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setupPullRefreshView];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
        _tableView = [[UITableView alloc] initWithFrame:rect style:_tableViewStyle];
//        if (!self.hidesBottomBarWhenPushed) {
//            _tableView.height-=49;
//        }
//        if (!self.navigationController.navigationBarHidden) {//self.showDragView && 
//            _tableView.height-=64;
//        }
        _tableView.dataSource=self;
        _tableView.delegate = self;
        _tableView.backgroundView = nil;
        _tableView.showsVerticalScrollIndicator=NO;
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

#pragma mark - KeyBoard Notification
- (void)keyboardWillShow:(NSNotification *)notification{
    NSValue* keyboardboundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue* keybardAnimatedValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [keyboardboundsValue getValue:&_keyboardBounds];
    [keybardAnimatedValue getValue:&_keybardAnmiatedTimeinterval];
}

- (void)keyboardDidShow:(NSNotification*)notification {
}

- (void)keyboardWillChange:(NSNotification *)notification {
    NSValue* keyboardboundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue* keybardAnimatedValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [keyboardboundsValue getValue:&_keyboardBounds];
    [keybardAnimatedValue getValue:&_keybardAnmiatedTimeinterval];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    NSValue* keyboardboundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue* keybardAnimatedValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [keyboardboundsValue getValue:&_keyboardBounds];
    [keybardAnimatedValue getValue:&_keybardAnmiatedTimeinterval];
}

- (void)keyboardDidHide:(NSNotification*)notification {
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service {
    [super serviceDidFinished:service];
    if (self.showDragView) {
        [self.refreshControl endRefreshing];
    }
}

- (void)serviceDidCancel:(CDJSONBaseNetworkService *)service {
    [super serviceDidCancel:service];
    if (self.showDragView) {
        [self.refreshControl endRefreshing];
    }
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error {
    [super service:service didFailLoadWithError:error];
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
//        _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        _refreshControl = [[SCYRefreshControl alloc] initInScrollView:self.tableView];
        [_refreshControl addTarget:self action:@selector(startPullRefresh) forControlEvents:UIControlEventValueChanged];
    }
}

@end
