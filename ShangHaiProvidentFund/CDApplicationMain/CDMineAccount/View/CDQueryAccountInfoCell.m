//
//  CDQueryAccountInfoCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/11.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDQueryAccountInfoCell.h"
#import "CDConvenientToolsItem.h"

@implementation CDQueryAccountInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

#pragma mark - public
- (void)setupCellItem:(CDConvenientToolsItem *)item{
    self.imageView.image=[UIImage imageNamed:item.imgName];
    self.textLabel.text=item.title;
}

@end
