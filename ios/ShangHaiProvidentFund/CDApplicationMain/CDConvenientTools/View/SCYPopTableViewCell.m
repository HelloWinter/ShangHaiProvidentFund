//
//  SCYPopTableViewCell.m
//  ProvidentFund
//
//  Created by cdd on 16/3/21.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYPopTableViewCell.h"
#import "SCYLoanRateItem.h"

@interface SCYPopTableViewCell ()

@property (nonatomic, strong) UILabel *lbContent;

@end

@implementation SCYPopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.lbContent];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)lbContent{
    if (_lbContent==nil) {
        _lbContent=[[UILabel alloc]init];
        _lbContent.textAlignment=NSTextAlignmentCenter;
        _lbContent.textColor=ColorFromHexRGB(0x9e9e9e);
        _lbContent.font=[UIFont systemFontOfSize:15];
    }
    return _lbContent;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.lbContent.frame=CGRectMake(0, 0, self.contentView.width, self.contentView.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.lbContent.textColor= selected ? NAVIGATION_COLOR : ColorFromHexRGB(0x9e9e9e);
}

#pragma mark - public
- (void)setupCellItem:(SCYLoanRateItem *)item indexPath:(NSIndexPath *)path{
    self.lbContent.text=item.date;
}

@end
