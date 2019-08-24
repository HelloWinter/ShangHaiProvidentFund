//
//  CDUserManagerController.m
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/7/17.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDUserManagerController.h"
#import "CDAboutUsItem.h"
#import "CDUserManagerModel.h"
#import "CDAboutUsCell.h"
#import "CDBaseWKWebViewController.h"
#import "CDButtonTableFooterView.h"
#import "CDHelpInfoViewController.h"
#import "CDOpinionsSuggestionsController.h"
#import "CDLoginViewController.h"
#import "CDNavigationController.h"

static NSString *cellidentifier = @"cellidentifier";

@interface CDUserManagerController ()<CDLoginViewControllerDelegate>

@property (nonatomic, strong) CDUserManagerModel *aboutUsModel;
@property (nonatomic, strong) CDButtonTableFooterView *footerView;

@end

@implementation CDUserManagerController

- (instancetype)init{
    self =[super init];
    if (self) {
        self.title=@"关于我们";
        self.hidesBottomBarWhenPushed=YES;
        self.tableViewStyle=UITableViewStyleGrouped;
        self.showDragView=NO;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView=self.footerView;
    [self.tableView registerClass:[CDAboutUsCell class] forCellReuseIdentifier:cellidentifier];
}

- (CDUserManagerModel *)aboutUsModel{
    if (_aboutUsModel==nil) {
        _aboutUsModel=[[CDUserManagerModel alloc]init];
    }
    return _aboutUsModel;
}

- (CDButtonTableFooterView *)footerView{
    if (_footerView==nil) {
        _footerView=[CDButtonTableFooterView footerView];
        [_footerView setupBtnTitle:([CDCacheManager isUserLogined] ? @"退出登录" : @"登录")];
        [_footerView setupBtnBackgroundColor:([CDCacheManager isUserLogined] ? ColorFromHexRGB(0xfe6565) : ColorFromHexRGB(0x36c362))];
        __weak typeof(self) weakSelf=self;
        _footerView.buttonClickBlock=^(UIButton *sender){
            [weakSelf footerViewButtonClicked];
        };
    }
    return _footerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.aboutUsModel.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=[self.aboutUsModel.arrData cd_safeObjectAtIndex:section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CDAboutUsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    NSArray *arr=[self.aboutUsModel.arrData cd_safeObjectAtIndex:indexPath.section];
    CDAboutUsItem *item=[arr cd_safeObjectAtIndex:indexPath.row];
    [cell setupCellItem:item];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    if (![CDCacheManager isUserLogined] && indexPath.section!=3) {
                        [self p_presentLoginViewController];
                    }else{
                        
                    }
                }break;
                case 1:{
//                    NSString *strURL=CDWebURLWithAPI(@"/static/sms/forget-pass.html");
                    [self pushToWKWebViewControllerWithTitle:@"遗忘密码" URLString:[KH5ForgetPass stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)] jsCode:nil];
                }break;
                case 2:{
                    NSString *strURL=@"http://persons.shgjj.com/get-pass.html";
                    [self pushToWKWebViewControllerWithTitle:@"手机取回用户名和密码" URLString:[strURL stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)] jsCode:nil];
                }break;
                case 3:{
                    NSString *str=@"var element=document.getElementsByClassName('notes')[1];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
                    [self pushToWKWebViewControllerWithTitle:@"个人公积金账号查询" URLString:@"http://m.shgjj.com/verifier/verifier/index" jsCode:str];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            /*
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    [self pushToWKWebViewControllerWithTitle:@"隐私声明" URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=yssm")];
                }break;
                case 1:{
                    [self pushToOpinionsSuggestionsController];
                }break;
                default:
                    break;
            }
        }
            break;
        case 2:{
            switch (indexPath.row) {
                case 0:
                    [self showCallTelephoneAlert];
                    break;
                case 1:
                    [self pushToHelpInfoController];
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    NSString *strUrl=[@"http://m.weibo.cn/u/3547969482" stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
                    [self pushToWKWebViewControllerWithTitle:@"上海公积金微博" URLString:strUrl];
                }break;
                default:
                    break;
            }
        }
            break;
             */
        default:
            break;
    }
}

#pragma mark - CDLoginViewControllerDelegate
- (void)userDidLogin{
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserLoginStateChangedNotification object:nil];
    [self refreshFooterView];
}

- (void)userCanceledLogin{
    
}

#pragma mark - private
- (void)pushToWKWebViewControllerWithTitle:(NSString *)title URLString:(NSString *)urlstr jsCode:(NSString *)jsCode{
    CDBaseWKWebViewController *webViewController=[[CDBaseWKWebViewController alloc]init];
    webViewController.title=title;
    webViewController.URLString=urlstr;
    if (jsCode && jsCode.length != 0) {
        WKUserScript *script= [[WKUserScript alloc]initWithSource:jsCode injectionTime:(WKUserScriptInjectionTimeAtDocumentEnd) forMainFrameOnly:NO];
        webViewController.arrWKUserScript=@[script];
    }
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)pushToHelpInfoController{
    CDHelpInfoViewController *controller=[[CDHelpInfoViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushToOpinionsSuggestionsController{
    CDOpinionsSuggestionsController *controller=[[CDOpinionsSuggestionsController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)presentLoginViewController{
    CDLoginViewController *controller=[[CDLoginViewController alloc]init];
    controller.delegate=self;
    CDNavigationController *nav=[[CDNavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)showCallTelephoneAlert{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"客服工作时间:周一至周六9:00-17:00(除法定假日外)\n现在是否拨打电话?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *actionCall=[UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        callPhoneNum(@"02112329");
    }];
    [alert addAction:actionCancel];
    [alert addAction:actionCall];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)footerViewButtonClicked{
    if ([CDCacheManager isUserLogined]) {
        [CDCacheManager saveUserLogined:NO];
        [[NSNotificationCenter defaultCenter]postNotificationName:kUserLoginStateChangedNotification object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [self refreshFooterView];
    }else{
        [self presentLoginViewController];
    }
}

- (void)p_presentLoginViewController{
    CDLoginViewController *controller=[[CDLoginViewController alloc]init];
    controller.delegate=self;
    CDNavigationController *nav=[[CDNavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)refreshFooterView{
    [self.footerView setupBtnTitle:([CDCacheManager isUserLogined] ? @"退出登录" : @"登录")];
    [self.footerView setupBtnBackgroundColor:([CDCacheManager isUserLogined] ? ColorFromHexRGB(0xfe6565) : ColorFromHexRGB(0x36c362))];
}

@end
