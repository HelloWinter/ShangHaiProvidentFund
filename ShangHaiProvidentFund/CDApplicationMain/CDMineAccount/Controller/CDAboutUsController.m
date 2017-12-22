//
//  CDAboutUsController.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAboutUsController.h"
#import "CDAboutUsItem.h"
#import "CDAboutUsModel.h"
#import "CDAboutUsCell.h"
#import "CDBaseWKWebViewController.h"

#import "CDHelpInfoViewController.h"
#import "CDOpinionsSuggestionsController.h"
#import "CDLoginViewController.h"
#import "CDNavigationController.h"

static NSString *cellidentifier = @"cellidentifier";

@interface CDAboutUsController ()<CDLoginViewControllerDelegate>

@property (nonatomic, strong) CDAboutUsModel *aboutUsModel;

@end

@implementation CDAboutUsController

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
    
    [self.tableView registerClass:[CDAboutUsCell class] forCellReuseIdentifier:cellidentifier];
}

- (CDAboutUsModel *)aboutUsModel{
    if (_aboutUsModel==nil) {
        _aboutUsModel=[[CDAboutUsModel alloc]init];
    }
    return _aboutUsModel;
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
            /*
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    NSString *strURL=CDWebURLWithAPI(@"/static/sms/forget-pass.html");
                    [self pushToWKWebViewControllerWithTitle:@"遗忘密码" URLString:[strURL stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)]];
                }break;
                case 1:{
                    NSString *strURL=@"https://persons.shgjj.com/get-pass.html";
                    [self pushToWKWebViewControllerWithTitle:@"手机取回用户名和密码" URLString:[strURL stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)]];
                }break;
                case 2:
                    [self pushToWKWebViewControllerWithTitle:@"个人公积金账号查询" URLString:@"http://m.shgjj.com/verifier/verifier/index"];
                    break;
                default:
                    break;
            }
        }
            break;
             */
            
        case 0:{
            switch (indexPath.row) {
//                case 0:{
//                    [self pushToWKWebViewControllerWithTitle:@"隐私声明" URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=yssm")];
//                }break;
                case 0:{
                    [self pushToOpinionsSuggestionsController];
                }break;
                default:
                    break;
            }
        }
            break;
        case 1:{
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
        case 2:{
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
        default:
            break;
    }
}

#pragma mark - private
- (void)pushToWKWebViewControllerWithTitle:(NSString *)title URLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[[CDBaseWKWebViewController alloc]init];
    webViewController.title=title;
    webViewController.URLString=urlstr;
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

@end
