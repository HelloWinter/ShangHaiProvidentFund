//
//  CDOpinionsSuggestionsFieldCell.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTextFieldCell.h"

@class CDOpinionsSuggestionsItem;

@interface CDOpinionsSuggestionsFieldCell : CDBaseTextFieldCell

- (void)setupItem:(CDOpinionsSuggestionsItem *)item indexPath:(NSIndexPath *)path;

@end
