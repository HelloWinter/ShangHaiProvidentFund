//
//  CDNetWorkPointCell.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNetWorkPointCell.h"
#import "CDNetworkPointItem.h"
#import "NSString+CDEncryption.h"

@interface CDNetWorkPointCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbManagementDepartment;
@property (weak, nonatomic) IBOutlet UILabel *lbCurrentNum;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;

@end

@implementation CDNetWorkPointCell

+ (instancetype)netWorkPointCell{
    CDNetWorkPointCell *cell=[[[NSBundle mainBundle]loadNibNamed:@"CDNetWorkPointCell" owner:nil options:nil]lastObject];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - public
- (void)setupCellItem:(CDNetworkPointItem *)item{
    self.lbManagementDepartment.text=[item.districts cd_detleteCharacter:@" "];
    self.lbCurrentNum.text=[NSString stringWithFormat:@"当前人数:%@",item.num];
    self.lbAddress.text=[item.address cd_detleteCharacter:@" "];
}

@end
