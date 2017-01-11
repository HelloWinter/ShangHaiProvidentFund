//
//  SCYMortgageCalculatorSelectCell.m
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYMortgageCalculatorSelectCell.h"
#import "SCYMortgageCalculatorCellItem.h"
#import "SCYLoanRateItem.h"

@implementation SCYMortgageCalculatorSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font=[UIFont systemFontOfSize:15];
        self.detailTextLabel.font=[UIFont systemFontOfSize:13];
    }
    return self;
}

#pragma mark - public
- (void)setupCellItem:(SCYMortgageCalculatorCellItem *)item indexPath:(NSIndexPath *)path{
    if ([item.paramselect isEqualToString:@"1"]) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryType=UITableViewCellAccessoryNone;
    }
    self.textLabel.text=item.paramdesc;
    self.detailTextLabel.text=@"";
    for (SCYLoanRateItem *rateItem in item.paramsubitemsdata) {
        if ([item.paramvalue isEqualToString:rateItem.rate]) {
            self.detailTextLabel.text=rateItem.date;
        }
    }
}

@end
