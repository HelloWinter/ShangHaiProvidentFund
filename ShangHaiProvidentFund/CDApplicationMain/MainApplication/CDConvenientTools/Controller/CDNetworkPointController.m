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

@interface CDNetworkPointController ()

@property (nonatomic, strong) CDNetworkPointService *networkPointService;

@end

@implementation CDNetworkPointController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title=@"住房公积金管理中心网点";
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
    
}

#pragma mark - override
- (void)startPullRefresh{
    [self.networkPointService loadNetworkPointIgnoreCache:YES ShowIndicator:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
