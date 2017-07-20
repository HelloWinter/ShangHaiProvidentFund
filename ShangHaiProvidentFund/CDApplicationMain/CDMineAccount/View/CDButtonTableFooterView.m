//
//  CDButtonTableFooterView.m
//  ProvidentFund
//
//  Created by cdd on 15/12/24.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "CDButtonTableFooterView.h"

@interface CDButtonTableFooterView ()

@property (weak, nonatomic) IBOutlet UIButton *btnFooter;

@end

@implementation CDButtonTableFooterView

+ (instancetype)footerView{
    CDButtonTableFooterView *tableFooterView = [[[NSBundle mainBundle]loadNibNamed:@"CDButtonTableFooterView" owner:nil options:nil] lastObject];
    return tableFooterView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor=[UIColor clearColor];
    self.btnFooter.layer.cornerRadius=4;
    self.btnFooter.clipsToBounds=YES;
}

#pragma mark - public
- (void)setupBtnTitle:(NSString *)title{
    [self.btnFooter setTitle:title forState:(UIControlStateNormal)];
}

- (void)setupBtnBackgroundColor:(UIColor *)color{
    [self.btnFooter setBackgroundColor:color];
}

#pragma mark - private
- (IBAction)btnAction:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender);
    }
}

@end
