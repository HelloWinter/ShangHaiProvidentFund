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
#import "CDLoadMoreItem.h"
#import "CDLoadMoreCell.h"

@interface CDNewsAndTrendsController ()

@property (nonatomic, strong) CDNewsAndTrendsService *newsAndTrendsService;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation CDNewsAndTrendsController

- (instancetype)init{
    self =[super init];
    if (self) {
        self.showDragView=NO;
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
    CDBaseItem *item = [self.arrData cd_safeObjectAtIndex:indexPath.row];
    if ([item isKindOfClass:[CDNewsAndTrendsItem class]]) {
        CDNewsAndTrendsItem *newsItem =(CDNewsAndTrendsItem *)item;
        static NSString *cellIdentifier=@"cellIdentifier";
        CDNewsAndTrendsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[CDNewsAndTrendsCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellIdentifier];
        }
        [cell setupCellItem:newsItem.news];
        return cell;
    }else if([item isKindOfClass:[CDLoadMoreItem class]]){
        CDLoadMoreItem *moreItem =(CDLoadMoreItem *)item;
        static NSString *moreCellIdentifier=@"moreCellIdentifier";
        CDLoadMoreCell *cell=[tableView dequeueReusableCellWithIdentifier:moreCellIdentifier];
        if (!cell) {
            cell=[[CDLoadMoreCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:moreCellIdentifier];
        }
        [cell setupCellItem:moreItem];
        return cell;
    }else{
        return [[UITableViewCell alloc]init];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CDBaseItem *item = [self.arrData cd_safeObjectAtIndex:indexPath.row];
    if ([item isKindOfClass:[CDLoadMoreItem class]]){
        return 44;
    }
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CDBaseItem *item = [self.arrData cd_safeObjectAtIndex:indexPath.row];
    if ([item isKindOfClass:[CDNewsAndTrendsItem class]]) {
        CDNewsAndTrendsItem *newsitem = (CDNewsAndTrendsItem *)item;
        NSString *urlStr=[NSString stringWithFormat:@"/gjjManager/newsByIdServlet?id=%@",newsitem.news.newsid];
        [self pushToWKWebViewControllerWithURLString:CDURLWithAPI(urlStr)];
    }else if ([item isKindOfClass:[CDLoadMoreItem class]]){
        [self refreshTableViewFromTop:NO];
    }
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)requestDidFinished:(CDJSONBaseNetworkService *)service{
    [super requestDidFinished:service];
    [self refreshTableViewFromTop:YES];
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

- (void)refreshTableViewFromTop:(BOOL)isFromTop{
    if (isFromTop) {
        [self.arrData removeAllObjects];
    }else{
        [self.arrData removeLastObject];
    }
    [self refreshArrData];
    [self.tableView reloadData];
}

- (void)refreshArrData{
    if (self.arrData.count<self.newsAndTrendsService.arrData.count) {
        NSInteger subCount=self.newsAndTrendsService.arrData.count-self.arrData.count;
        [self.arrData addObjectsFromArray:[self.newsAndTrendsService.arrData subarrayWithRange:NSMakeRange(self.arrData.count,subCount>=20 ? 20 : subCount)]];
        if (subCount>20) {
            [self.arrData addObject:[CDLoadMoreItem itemWithTitle:@"更多资讯" showIndicator:NO]];
        }
    }
}

//- (void)pushToWebViewControllerWithURLString:(NSString *)urlstr{
//    SCYBaseWebViewController *webViewController=[SCYBaseWebViewController webViewControllerWithURL:[NSURL URLWithString:urlstr]];
//    webViewController.title=@"上海住房公积金网";
//    [self.navigationController pushViewController:webViewController animated:YES];
//}

@end
