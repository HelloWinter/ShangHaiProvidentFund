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
#import "CDNetworkPointController.h"
#import "CDBaseWKWebViewController.h"

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
    switch (indexPath.row) {
        case 0:
            [self pushToNetworkPointController];
            break;
        case 1:{
            NSString *jsCode=@"var element=document.getElementsByTagName('link')[0];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
            [self pushToWKWebViewControllerWithTitle:@"业务办理" javaScriptCode:jsCode URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=blgg")];
        }
            break;
        case 2:{
            [self pushToWKWebViewControllerWithTitle:@"公积金缴存额上下限/比例表" javaScriptCode:nil URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=jcll")];
        }
            break;
        case 3:
            [self pushToWKWebViewControllerWithTitle:@"住房公积金缴存计算" javaScriptCode:nil URLString:CDWebURLWithAPI(@"/app/wap/tools_paid_app.html")];
            break;
        case 7:
            [self pushToWKWebViewControllerWithTitle:@"叫号信息" javaScriptCode:nil URLString:CDWebURLWithAPI(@"/static/2010/mindex.html")];
            break;
            
        default:
            break;
    }
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - Events
- (void)pushToNetworkPointController{
    CDNetworkPointController *controller=[[CDNetworkPointController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushToWKWebViewControllerWithTitle:(NSString *)title javaScriptCode:(NSString *)jsCode URLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=title;
    webViewController.javaScriptCode=jsCode;
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
