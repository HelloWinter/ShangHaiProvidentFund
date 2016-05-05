//
//  CDMineAccountController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDMineAccountController.h"
#import "CDConvenientToolsCell.h"
#import "CDConvenientToolsItem.h"
#import "CDMineAccountModel.h"

static NSString *cellIdentifier=@"cellIdentifier";

@interface CDMineAccountController ()

@property (nonatomic, strong) CDMineAccountModel *mineAccountModel;

@end

@implementation CDMineAccountController

- (instancetype)init{
    self =[super init];
    if (self) {
        self.title=@"账户查询";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.collectionView registerClass:[CDConvenientToolsCell class] forCellWithReuseIdentifier:cellIdentifier];
}

- (CDMineAccountModel *)mineAccountModel{
    if (_mineAccountModel==nil) {
        _mineAccountModel=[[CDMineAccountModel alloc]init];
    }
    return _mineAccountModel;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.mineAccountModel.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CDConvenientToolsItem *item=[self.mineAccountModel.arrData cd_safeObjectAtIndex:indexPath.row];
    CDConvenientToolsCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setupCellItem:item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth=(self.collectionView.width-20)*0.25;
    CGFloat cellHeight=cellWidth;
    return CGSizeMake(cellWidth, cellHeight);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 7, 7, 7);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
