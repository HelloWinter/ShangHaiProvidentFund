//
//  CDHelpInfoViewController.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/5.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDHelpInfoViewController.h"

@interface CDHelpInfoViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *lbVersion;
@property (nonatomic, strong) UILabel *lbContent;

@end

@implementation CDHelpInfoViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title=@"帮助信息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.lbVersion];
    [self.view addSubview:self.lbContent];
}

- (UIImageView *)imgView{
    if(_imgView == nil){
        _imgView = [[UIImageView alloc]init];
        _imgView.image=[UIImage imageNamed:@"shgjj_logo"];
        _imgView.frame=CGRectMake(0, 90, 109, 19);
        _imgView.centerX=self.view.width*0.5;
    }
    return _imgView;
}

- (UILabel *)lbVersion{
    if(_lbVersion == nil){
        _lbVersion = [[UILabel alloc]init];
        _lbVersion.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.imgView.bottom+10, self.view.width-LEFT_RIGHT_MARGIN*2, 20);
        _lbVersion.textColor=[UIColor darkGrayColor];
        _lbVersion.textAlignment=NSTextAlignmentCenter;
        _lbVersion.font=[UIFont systemFontOfSize:13];
        _lbVersion.text=[NSString stringWithFormat:@"当前版本 V%@",CDAppVersion];
    }
    return _lbVersion;
}

- (UILabel *)lbContent{
    if(_lbContent == nil){
        _lbContent = [[UILabel alloc]init];
        _lbContent.font=[UIFont systemFontOfSize:15];
        _lbContent.text=@"\t登录住房公积金客户端查询个人账户信息,更多查询请登录 www.shgjj.com\n\n上海住房公积金网 版权所有\n\n上海住房公积金热线：12329 电话接待时间：周一至周六9:00-17:00 (除法定节假日外)";
        CGRect rect=[_lbContent.text boundingRectWithSize:CGSizeMake(self.view.width-LEFT_RIGHT_MARGIN*2, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:_lbContent.font} context:nil];
        _lbContent.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.lbVersion.bottom+30, self.view.width-LEFT_RIGHT_MARGIN*2, CGRectGetHeight(rect));
        _lbContent.numberOfLines=0;
        _lbContent.lineBreakMode=NSLineBreakByWordWrapping;
    }
    return _lbContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
