//
//  CDConvenientToolsController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDConvenientToolsController.h"
#import "CDConvenientToolsCell.h"
#import "CDConvenientToolsItem.h"
#import "CDConvenientModel.h"

static NSString *cellIdentifier=@"cellIdentifier";

@interface CDConvenientToolsController ()

@property (nonatomic, strong) CDConvenientModel *convenientToolsModel;

@end

@implementation CDConvenientToolsController

- (instancetype)init{
    self =[super init];
    if (self) {
        self.title=@"便民工具";
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.collectionView registerClass:[CDConvenientToolsCell class] forCellWithReuseIdentifier:cellIdentifier];
}

- (CDConvenientModel *)convenientToolsModel{
    if (_convenientToolsModel==nil) {
        _convenientToolsModel=[[CDConvenientModel alloc]init];
    }
    return _convenientToolsModel;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.convenientToolsModel.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CDConvenientToolsItem *item=[self.convenientToolsModel.arrData cd_safeObjectAtIndex:indexPath.row];
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
    return UIEdgeInsetsMake(7, 7, 7, 7);
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
