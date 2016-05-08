//
//  CDOpinionsSuggestionsViewCell.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@class CDOpinionsSuggestionsItem;

@interface CDOpinionsSuggestionsViewCell : CDBaseTableViewCell

+ (instancetype)textViewCell;

- (void)setupCellItem:(CDOpinionsSuggestionsItem *)item indexPath:(NSIndexPath *)path;

@end
