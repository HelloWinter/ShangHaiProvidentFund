//
//  CDAccountBasicInfoCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAccountBasicInfoCell.h"
#import "CDAccountInfoItem.h"


@interface CDAccountBasicInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbBalance;
@property (weak, nonatomic) IBOutlet UILabel *lbAccountState;

@end

@implementation CDAccountBasicInfoCell

+ (instancetype)basicInfoCell{
    CDAccountBasicInfoCell *cell=[[[NSBundle mainBundle]loadNibNamed:@"CDAccountBasicInfoCell" owner:nil options:nil]lastObject];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 80;
}

- (void)setupCellItem:(CDAccountInfoItem *)item isLogined:(BOOL)islogined{
    if (islogined) {
        self.lbBalance.hidden=self.lbAccountState.hidden=NO;
        self.lbName.text=item.name ? : @"--";
        self.lbBalance.text=[NSString stringWithFormat:@"账户余额：%@",item.surplus_def];
        self.lbAccountState.text=[NSString stringWithFormat:@"账户状态：%@",item.state];
    }else{
        self.lbName.text=@"未登录";
        self.lbBalance.hidden=self.lbAccountState.hidden=YES;
    }
}

@end
