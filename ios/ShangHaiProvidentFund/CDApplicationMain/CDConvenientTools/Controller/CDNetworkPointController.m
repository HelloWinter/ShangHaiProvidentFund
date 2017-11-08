//
//  CDNetworkPointController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/8.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNetworkPointController.h"
#import "CDNetworkPointItem.h"
#import "CDNetworkPointService.h"
#import "CDNetWorkPointCell.h"
#import "CDMapAnnotationController.h"
#import "CDMapRouteSearchController.h"
#import "UIBarButtonItem+CDCategory.h"

@interface CDNetworkPointController ()

@property (nonatomic, strong) CDNetworkPointService *networkPointService;

@end

@implementation CDNetworkPointController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title=@"住房公积金管理中心网点";
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=66;
    [self p_setupRightBarItem];
    [self.networkPointService loadNetworkPointIgnoreCache:NO ShowIndicator:YES];
}

- (CDNetworkPointService *)networkPointService{
    if(_networkPointService == nil){
        _networkPointService = [[CDNetworkPointService alloc]initWithDelegate:self];
    }
    return _networkPointService;
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    [super serviceDidFinished:service];
    [self.tableView reloadData];
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super service:service didFailLoadWithError:error];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.networkPointService.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *networkPointIdentifier = @"networkPointIdentifier";
    CDNetWorkPointCell *cell = [tableView dequeueReusableCellWithIdentifier:networkPointIdentifier];
    if (nil == cell) {
        cell = [CDNetWorkPointCell netWorkPointCell];
    }
    CDNetworkPointItem *item=[self.networkPointService.arrData cd_safeObjectAtIndex:indexPath.row];
    [cell setupCellItem:item];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CDNetworkPointItem *item=[self.networkPointService.arrData cd_safeObjectAtIndex:indexPath.row];
    CLLocationCoordinate2D coordinate=[self transformFrom:item.point];
    if (CDUserLocation().length!=0) {
        CLLocationCoordinate2D startcoordinate = [self transformFrom:CDUserLocation()];
        [self p_pushToRoutePlanningVCWithCoordinateStart:startcoordinate end:coordinate name:item.districts address:item.address];
    }else{
        [self p_pushToAnnotationVCWithCoordinate:coordinate district:item.districts address:item.address];
    }
    
}

#pragma mark - override
- (void)startPullRefresh{
    [self.networkPointService loadNetworkPointIgnoreCache:YES ShowIndicator:NO];
}

#pragma mark - private
- (void)p_setupRightBarItem{
    UIBarButtonItem *item=[UIBarButtonItem cd_ItemWidth:40 imageName:@"home_phone" target:self action:@selector(p_callThePhoneNum)];
    self.navigationItem.rightBarButtonItem=item;
}

- (void)p_callThePhoneNum{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:nil message:@"确定拨打021-12329？" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *call=[UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        callPhoneNum(@"02112329");
    }];
    [controller addAction:cancel];
    [controller addAction:call];
    [self presentViewController:controller animated:YES completion:nil];
}

/**
 *  路线规划
 */
- (void)p_pushToRoutePlanningVCWithCoordinateStart:(CLLocationCoordinate2D)startcoordinate end:(CLLocationCoordinate2D)coordinate name:(NSString *)name address:(NSString *)address{
    CDMapRouteSearchController *routePlaning=[[CDMapRouteSearchController alloc]init];
    routePlaning.startCoordinate=startcoordinate;
    routePlaning.endCoordinate  = coordinate;
    routePlaning.destinationName=name;
    routePlaning.destinationAddress=address;
    routePlaning.cityname=@"上海市";
    [self.navigationController pushViewController:routePlaning animated:YES];
}

/**
 *  地图标注
 */
- (void)p_pushToAnnotationVCWithCoordinate:(CLLocationCoordinate2D)coordinate district:(NSString *)district address:(NSString *)address{
    CDMapAnnotationController *annotationVC=[[CDMapAnnotationController alloc]init];
    annotationVC.coordinate=coordinate;
    annotationVC.districts=district;
    annotationVC.address=address;
    [self.navigationController pushViewController:annotationVC animated:YES];
}

- (CLLocationCoordinate2D)transformFrom:(NSString *)str{
    NSArray *arr=[str componentsSeparatedByString:@","];
    CLLocationDegrees latitude=[[arr firstObject] doubleValue];
    CLLocationDegrees longitude=[[arr lastObject] doubleValue];
    return CLLocationCoordinate2DMake(latitude, longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
