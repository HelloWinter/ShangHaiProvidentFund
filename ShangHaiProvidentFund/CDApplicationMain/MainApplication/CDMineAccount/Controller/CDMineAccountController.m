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
#import "CDBaseWKWebViewController.h"

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
    return UIEdgeInsetsMake(7, 7, 7, 7);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 6:{
            [self pushToWKWebViewControllerWithTitle:@"公益短信" javaScriptCode:nil URLString:CDWebURLWithAPI(@"/static/sms/app_apply.html")];
        }
            break;
            
        default:
            break;
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - Events
- (void)pushToWKWebViewControllerWithTitle:(NSString *)title javaScriptCode:(NSString *)jsCode URLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=title;
    webViewController.javaScriptCode=jsCode;
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
