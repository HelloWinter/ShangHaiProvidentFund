//
//  CDNewsAndTrendsCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNewsAndTrendsCell.h"
#import "CDNewsItem.h"

@interface CDNewsAndTrendsCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;


@end

@implementation CDNewsAndTrendsCell

+ (instancetype)newsAndTrendsCell{
    CDNewsAndTrendsCell *cell=[[[NSBundle mainBundle]loadNibNamed:@"CDNewsAndTrendsCell" owner:nil options:nil]lastObject];
    return cell;
}

- (void)setupCellItem:(CDNewsItem *)item{
    self.lbTitle.text=item.title;
    self.lbTime.text=item.pubDate;
}

@end
