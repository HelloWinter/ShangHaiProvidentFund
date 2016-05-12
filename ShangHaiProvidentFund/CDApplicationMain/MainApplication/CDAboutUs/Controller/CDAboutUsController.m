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

@interface CDAboutUsController ()

@property (nonatomic, strong) CDAboutUsModel *aboutUsModel;


@end

@implementation CDAboutUsController

- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super initWithTableViewStyle:tableViewStyle];
    if (self) {
        self.title=@"关于我们";
        self.showDragView=NO;
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
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
    static NSString *cellidentifier = @"cellidentifier";
    CDAboutUsCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[CDAboutUsCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellidentifier];
    }
    NSArray *arr=[self.aboutUsModel.arrData cd_safeObjectAtIndex:indexPath.section];
    CDAboutUsItem *item=[arr cd_safeObjectAtIndex:indexPath.row];
    [cell setupCellItem:item];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

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
//                    NSString *jsCode=@"var element=document.getElementsByTagName('link')[0];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
//                    [self pushToWKWebViewControllerWithTitle:@"隐私声明" javaScriptCode:jsCode URLString:CDURLWithAPI(@"/gjjManager/noticeByIdServlet?id=yssm")];
                    
                    
                    NSString *jsCode1=[self removeHTMLNodeWith:@"element" className:@"ctitle"];
                    NSString *jsCode2=[self removeHTMLNodeWith:@"element1" className:@"nav"];
                    NSString *jscode = [NSString stringWithFormat:@"%@%@",jsCode1,jsCode2];
//                    @"var element = document.getElementsByTagName('ctitle')[0];element.parentNode.removeChild(element);";
                    [self pushToWKWebViewControllerWithTitle:@"隐私声明" javaScriptCode:jscode URLString:CDWebURLWithAPI(@"/html/wap/more/79839.html")];
//                    http://www.shgjj.com
                }
                    break;
                case 1:{
                    [self pushToOpinionsSuggestionsController];
                }
                    break;
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
                case 2:
//                    [self pushToMineAccountVC];
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    NSString *strUrl=@"http://m.weibo.cn/u/3547969482";
                    strUrl=[strUrl stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
//                    NSString *jsCode=@"var element=document.getElementsByClassName('download-wrapper')[0];var parentElement=element.parentNode;if(parentElement){parentElement.removeChild(element);}";
                    [self pushToWKWebViewControllerWithTitle:@"上海公积金微博" javaScriptCode:nil URLString:strUrl];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - Events
- (void)pushToWKWebViewControllerWithTitle:(NSString *)title javaScriptCode:(NSString *)jsCode URLString:(NSString *)urlstr{
    CDBaseWKWebViewController *webViewController=[CDBaseWKWebViewController webViewWithURL:[NSURL URLWithString:urlstr]];
    webViewController.title=title;
    webViewController.javaScriptCode=jsCode;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)pushToHelpInfoController{
    CDHelpInfoViewController *controller=[[CDHelpInfoViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)pushToOpinionsSuggestionsController{
    CDOpinionsSuggestionsController *controller=[[CDOpinionsSuggestionsController alloc]initWithTableViewStyle:(UITableViewStyleGrouped)];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)showCallTelephoneAlert{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"客服工作时间:周一至周六9:00-17:00(除法定假日外)\n现在是否拨打电话?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *actionCall=[UIAlertAction actionWithTitle:@"拨打" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self callThePhoneNum:@"12329"];
    }];
    [alert addAction:actionCancel];
    [alert addAction:actionCall];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)callThePhoneNum:(NSString *)phoneNum{
    if ([CDDeviceModel isEqualToString:@"iPhone"]){
        NSURL *telUrl=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
        if ([[UIApplication sharedApplication]canOpenURL:telUrl]) {
            [[UIApplication sharedApplication] openURL:telUrl];
        }else{
            [self showAlertControllerWithTitle:@"提示" message:@"号码有误"];
        }
    }else {
        NSString *strAlert=[NSString stringWithFormat:@"您的设备 %@ 不支持电话功能！",CDDeviceModel];
        [self showAlertControllerWithTitle:@"提示" message:strAlert];
    }
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *actionCancel=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:actionCancel];
    [CDKeyWindow.rootViewController presentViewController:alert animated:YES completion:NULL];
}

- (NSString *)removeHTMLNodeWith:(NSString *)elementName className:(NSString *)className{
    return [NSString stringWithFormat:@"var %@ = document.getElementsByClassName('%@')[0];element.parentNode.removeChild(%@);",elementName,className,elementName];
}

//- (void)pushToMineAccountVC{
//    CDMineAccountController *controller=[[CDMineAccountController alloc]init];
//    controller.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:controller animated:YES];
//}

@end
