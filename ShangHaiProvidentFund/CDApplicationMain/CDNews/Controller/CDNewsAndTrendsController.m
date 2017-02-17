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
@property (nonatomic, strong) NSMutableArray *arrCellHeight;

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
    self.tableView.height -= self.tabBarController.tabBar.height;
    [self.newsAndTrendsService loadNewsAndTrendsIgnoreCache:NO showIndicator:NO];
}

- (NSMutableArray *)arrData{
    if(_arrData == nil){
        _arrData = [[NSMutableArray alloc]init];
    }
    return _arrData;
}

- (NSMutableArray *)arrCellHeight{
    if (_arrCellHeight==nil) {
        _arrCellHeight=[[NSMutableArray alloc]init];
    }
    return _arrCellHeight;
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
        static NSString *newsCellIdentifier=@"newsCellIdentifier";
        CDNewsAndTrendsCell *cell=[tableView dequeueReusableCellWithIdentifier:newsCellIdentifier];
        if (!cell) {
            cell=[[CDNewsAndTrendsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:newsCellIdentifier];
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
    }
    return [[UITableViewCell alloc]init];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *height = [self.arrCellHeight cd_safeObjectAtIndex:indexPath.row];
    if (height) {
        return [height floatValue];
    }else{
        CDBaseItem *item = [self.arrData cd_safeObjectAtIndex:indexPath.row];
        CGFloat cellHeight=44;
        if ([item isKindOfClass:[CDNewsAndTrendsItem class]]) {
            CDNewsAndTrendsItem *mitem=(CDNewsAndTrendsItem *)item;
            cellHeight = [CDNewsAndTrendsCell tableView:tableView rowHeightForObject:mitem.news];
        }
        [self.arrCellHeight addObject:[NSNumber numberWithFloat:cellHeight]];
        return cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CDBaseItem *item = [self.arrData cd_safeObjectAtIndex:indexPath.row];
    if ([item isKindOfClass:[CDNewsAndTrendsItem class]]) {
        CDNewsAndTrendsItem *newsitem = (CDNewsAndTrendsItem *)item;
        NSString *urlStr=[NSString stringWithFormat:@"/gjjManager/newsByIdServlet?id=%@",newsitem.news.newsid];
        [self p_pushToWKWebViewControllerWithURLString:CDURLWithAPI(urlStr)];
    }else if ([item isKindOfClass:[CDLoadMoreItem class]]){
        [self p_refreshTableViewFromTop:NO];
    }
}

#pragma mark - CDJSONBaseNetworkServiceDelegate
- (void)serviceDidFinished:(CDJSONBaseNetworkService *)service{
    [super serviceDidFinished:service];
    [self p_refreshTableViewFromTop:YES];
}

- (void)service:(CDJSONBaseNetworkService *)service didFailLoadWithError:(NSError *)error{
    [super service:service didFailLoadWithError:error];
}

#pragma mark - override
- (void)startPullRefresh{
    [self.newsAndTrendsService loadNewsAndTrendsIgnoreCache:YES showIndicator:NO];
}

#pragma mark - private
- (void)p_pushToWKWebViewControllerWithURLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=@"上海住房公积金网";
    webViewController.javaScriptCode=@"var element=document.getElementsByTagName('link')[0];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)p_refreshTableViewFromTop:(BOOL)isFromTop{
    if (isFromTop) {
        [self.arrData removeAllObjects];
        [self.arrCellHeight removeAllObjects];
    }else{
        [self.arrData removeLastObject];
        [self.arrCellHeight removeLastObject];
    }
    [self p_refreshArrData];
    [self.tableView reloadData];
}

- (void)p_refreshArrData{
    if (self.arrData.count<self.newsAndTrendsService.arrData.count) {
        NSInteger subCount=self.newsAndTrendsService.arrData.count-self.arrData.count;
        [self.arrData addObjectsFromArray:[self.newsAndTrendsService.arrData subarrayWithRange:NSMakeRange(self.arrData.count,subCount>=20 ? 20 : subCount)]];
        if (subCount>20) {
            [self.arrData addObject:[CDLoadMoreItem itemWithTitle:@"查看更多资讯" showIndicator:NO]];
        }
    }
}

@end
