//
//  CDNewsAndTrendsCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNewsAndTrendsCell.h"
#import "CDNewsItem.h"

@implementation CDNewsAndTrendsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.numberOfLines=0;
        self.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.textLabel.textColor=[UIColor darkGrayColor];
        self.detailTextLabel.textColor=[UIColor darkGrayColor];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setupCellItem:(CDNewsItem *)item{
    self.textLabel.text=item.title;
    self.detailTextLabel.text=item.pubDate;
}

@end
