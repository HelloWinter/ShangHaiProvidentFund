//
//  CDBaseCollectionViewController.h
//  YYDB
//
//  Created by cdd on 15/10/27.
//  Copyright (c) 2015年 ___9188___. All rights reserved.
//

#import "CDBaseViewController.h"

@interface CDBaseCollectionViewController : CDBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL showDragView;  //是否显示下拉加载(默认YES)

/**
 *  下拉开始刷新
 */
- (void)startPullRefresh;

- (void)endPullRefresh;

@end
