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
    [self.networkPointService loadNetworkPointIgnoreCache:NO ShowIndicator:YES];
}

- (CDNetworkPointService *)networkPointService{
    if(_networkPointService == nil){
        _networkPointService = [[CDNetworkPointService alloc]initWithDelegate:self];
    }
    return _networkPointService;
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)requestDidFinished:(CDJSONBaseNetworkService *)service{
    [super requestDidFinished:service];
    [self.tableView reloadData];
}

- (void)request:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super request:service didFailLoadWithError:error];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CDNetworkPointItem *item=[self.networkPointService.arrData cd_safeObjectAtIndex:indexPath.row];
    CLLocationCoordinate2D coordinate=[self transformFrom:item.point];
    if (CDUserLocation().length!=0) {
        CLLocationCoordinate2D startcoordinate = [self transformFrom:CDUserLocation()];
        [self pushToRoutePlanningVCWithCoordinateStart:startcoordinate end:coordinate name:item.districts address:item.address];
    }else{
        [self pushToAnnotationVCWithCoordinate:coordinate district:item.districts address:item.address];
    }
    
}

#pragma mark - override
- (void)startPullRefresh{
    [self.networkPointService loadNetworkPointIgnoreCache:YES ShowIndicator:NO];
}

#pragma mark - Events
/**
 *  路线规划
 */
- (void)pushToRoutePlanningVCWithCoordinateStart:(CLLocationCoordinate2D)startcoordinate end:(CLLocationCoordinate2D)coordinate name:(NSString *)name address:(NSString *)address{
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
- (void)pushToAnnotationVCWithCoordinate:(CLLocationCoordinate2D)coordinate district:(NSString *)district address:(NSString *)address{
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
