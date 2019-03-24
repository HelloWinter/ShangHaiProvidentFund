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
#import "SCYMortgageCalculatorController.h"
#import "SCYAnnualBonusCalculatorController.h"

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
    self.collectionView.height-=self.tabBarController.tabBar.height;
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
    CGFloat cellWidthHeight = (currentScreenModel()==CurrentDeviceScreenModel_iPad) ? 98.5 : (self.collectionView.width-20)*0.25;
    return CGSizeMake(cellWidthHeight, cellWidthHeight);
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
            [self p_pushToNetworkPointController];
            break;
        case 1:{
            [self p_pushToWKWebVCWithTitle:@"业务办理" url:KNoticeByIdServlet showProgress:NO jsCode:nil];//CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=blgg")
        }
            break;
        case 2:{
            [self p_pushToWKWebVCWithTitle:@"公积金缴存额上下限/比例表" url:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=jcll") showProgress:NO jsCode:nil];
        }
            break;
        case 3:{
            NSString *str=@"document.querySelector('.nav').remove();";
            [self p_pushToWKWebVCWithTitle:@"住房公积金缴存计算" url:CDWebURLWithAPI(@"/app/wap/tools_paid_app.html") showProgress:YES jsCode:str];
        }
            break;
        case 4:
            [self p_pushToWKWebVCWithTitle:@"额度试算" url:CDWebURLWithAPI(@"/app/wap/tools_ammount.html") showProgress:NO jsCode:nil];
            break;
        case 5:
            [self p_pushToMortgageCalculatorController];
            break;
        case 6:
            [self p_pushToAnnualBonusCalculatorController];
            break;
        case 7:
            [self p_pushToWKWebVCWithTitle:@"叫号信息" url:CDWebURLWithAPI(@"/static/2010/mindex.html") showProgress:NO jsCode:nil];
            break;
        case 8:
            [self p_pushToWKWebVCWithTitle:@"公益短信" url:CDWebURLWithAPI(@"/static/sms/app_apply.html") showProgress:YES jsCode:nil];
            break;
            
        default:
            break;
    }
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - private
- (void)p_pushToNetworkPointController{
    CDNetworkPointController *controller=[[CDNetworkPointController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)p_pushToWKWebVCWithTitle:(NSString *)title url:(NSString *)urlstr showProgress:(BOOL)show jsCode:(NSString *)jscode{
    CDBaseWKWebViewController *webViewController=[[CDBaseWKWebViewController alloc]init];
    webViewController.title=title;
    webViewController.URLString=urlstr;
    webViewController.showProgressView=show;
    if (jscode && jscode.length!=0) {
        WKUserScript *script=[[WKUserScript alloc]initWithSource:jscode injectionTime:(WKUserScriptInjectionTimeAtDocumentEnd) forMainFrameOnly:NO];
        webViewController.arrWKUserScript=@[script];
    }
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)p_pushToMortgageCalculatorController{
    SCYMortgageCalculatorController *controller=[[SCYMortgageCalculatorController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)p_pushToAnnualBonusCalculatorController{
    SCYAnnualBonusCalculatorController *controller=[[SCYAnnualBonusCalculatorController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
