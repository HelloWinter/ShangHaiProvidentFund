//
//  CDNewsAndTrendsController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNewsAndTrendsController.h"
#import "CDNewsAndTrendsService.h"

@interface CDNewsAndTrendsController ()

@property (nonatomic, strong) CDNewsAndTrendsService *newsAndTrendsService;

@end

@implementation CDNewsAndTrendsController

- (instancetype)init{
    self =[super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.newsAndTrendsService loadNewsAndTrendsShowIndicator:YES];
}

- (CDNewsAndTrendsService *)newsAndTrendsService{
    if (_newsAndTrendsService==nil) {
        _newsAndTrendsService=[[CDNewsAndTrendsService alloc]initWithDelegate:self];
    }
    return _newsAndTrendsService;
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)requestDidFinished:(CDJSONBaseNetworkService *)service{
    NSLog(@"请求成功");
}

- (void)request:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    
}

#pragma mark - override
- (void)startPullRefresh{
    [self.newsAndTrendsService loadNewsAndTrendsShowIndicator:NO];
}


@end
