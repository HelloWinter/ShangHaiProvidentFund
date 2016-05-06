//
//  CDNewsAndTrendsController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNewsAndTrendsController.h"
#import "CDNewsAndTrendsService.h"
#import "CDNewsAndTrendsCell.h"
#import "CDNewsAndTrendsItem.h"
#import "CDNewsItem.h"
#import "CDBaseWKWebViewController.h"
//#import "SCYBaseWebViewController.h"

@interface CDNewsAndTrendsController ()

@property (nonatomic, strong) CDNewsAndTrendsService *newsAndTrendsService;
@property (nonatomic, strong) NSMutableArray *arrData;

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
    [self.newsAndTrendsService loadNewsAndTrendsIgnoreCache:NO showIndicator:YES];
}

- (NSMutableArray *)arrData{
    if(_arrData == nil){
        _arrData = [[NSMutableArray alloc]init];
    }
    return _arrData;
}

- (CDNewsAndTrendsService *)newsAndTrendsService{
    if (_newsAndTrendsService==nil) {
        _newsAndTrendsService=[[CDNewsAndTrendsService alloc]initWithDelegate:self];
    }
    return _newsAndTrendsService;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cellIdentifier";
    CDNewsAndTrendsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[CDNewsAndTrendsCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentifier];
    }
    CDNewsAndTrendsItem *item = [self.arrData cd_safeObjectAtIndex:indexPath.row];
    [cell setupCellItem:item.news];
    return cell;
}

#pragma mark - mark
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CDNewsAndTrendsItem *item = [self.arrData cd_safeObjectAtIndex:indexPath.row];
    NSString *urlStr=[NSString stringWithFormat:@"/gjjManager/newsByIdServlet?id=%@",item.news.newsid];
    [self pushToWKWebViewControllerWithURLString:CDURLWithAPI(urlStr)];
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)requestDidFinished:(CDJSONBaseNetworkService *)service{
    [self.arrData removeAllObjects];
    [self.arrData addObjectsFromArray:[self.newsAndTrendsService.arrData subarrayWithRange:NSMakeRange(0, 20)]];
    [self.tableView reloadData];
}

- (void)request:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super request:service didFailLoadWithError:error];
}

#pragma mark - override
- (void)startPullRefresh{
    [self.newsAndTrendsService loadNewsAndTrendsIgnoreCache:YES showIndicator:NO];
}


#pragma mark - Events
- (void)pushToWKWebViewControllerWithURLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=@"上海住房公积金网";
    webViewController.javaScriptCode=@"var element=document.getElementsByTagName('link')[0];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
    [self.navigationController pushViewController:webViewController animated:YES];
}

//- (void)pushToWebViewControllerWithURLString:(NSString *)urlstr{
//    SCYBaseWebViewController *webViewController=[SCYBaseWebViewController webViewControllerWithURL:[NSURL URLWithString:urlstr]];
//    webViewController.title=@"上海住房公积金网";
//    [self.navigationController pushViewController:webViewController animated:YES];
//}

@end
