//
//  CDBaseCollectionViewController.m
//  YYDB
//
//  Created by cdd on 15/10/27.
//  Copyright (c) 2015年 ___9188___. All rights reserved.
//

#import "CDBaseCollectionViewController.h"
#import "ODRefreshControl.h"

@interface CDBaseCollectionViewController ()

@property (nonatomic, strong) ODRefreshControl *refreshControl;

@end

@implementation CDBaseCollectionViewController
@synthesize collectionView=_collectionView;

- (void)dealloc {
    self.collectionView.dataSource=nil;
    self.collectionView.delegate=nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit{
    self.showDragView=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    if (self.showDragView) {
        if (!self.navigationController.navigationBarHidden) {
            [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight];
        }
        _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.collectionView];
        [_refreshControl addTarget:self action:@selector(startPullRefresh) forControlEvents:UIControlEventValueChanged];
    }
}

- (UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.headerReferenceSize=CGSizeMake(self.view.width, 7);
        _collectionView =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        if (!self.hidesBottomBarWhenPushed) {
            _collectionView.height-=49;
        }
        if (!self.navigationController.navigationBarHidden) {//self.showDragView &&
            _collectionView.height-=64;
        }
        _collectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        //保证contentsize小于frame的size时也能下拉刷新
        _collectionView.alwaysBounceVertical = YES;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [[UICollectionViewCell alloc]init];
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
