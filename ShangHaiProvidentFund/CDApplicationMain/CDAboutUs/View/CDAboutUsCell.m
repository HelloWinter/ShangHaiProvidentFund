//
//  CDAboutUsCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDAboutUsCell.h"
#import "CDAboutUsItem.h"

@implementation CDAboutUsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark - public
- (void)setupCellItem:(CDAboutUsItem *)item{
    self.imageView.image=[UIImage imageNamed:item.imgName];
    self.textLabel.text=item.titleText;
    self.detailTextLabel.text=item.detailText;
    self.accessoryType=item.detailText.length==0 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

@end
