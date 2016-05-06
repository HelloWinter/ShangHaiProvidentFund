//
//  CDLoadMoreCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/6.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDLoadMoreCell.h"
#import "CDLoadMoreItem.h"

@interface CDLoadMoreCell ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CDLoadMoreCell

- (void)dealloc{
    [self.indicatorView stopAnimating];
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.indicatorView];
    }
    return self;
}

- (UIActivityIndicatorView *)indicatorView{
    if (_indicatorView==nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _indicatorView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat space = 5.0f;
    CGFloat textWidth = 0;
    CGFloat textHeight = 0;
    
    NSString *text = self.textLabel.text;
    if (text.length>0) {
        CGSize size=[text sizeWithAttributes:@{NSFontAttributeName:self.textLabel.font}];
        textWidth=size.width;
        textHeight=size.height;
    }
    
    self.textLabel.bounds = CGRectMake(0, 0, textWidth, textHeight);
    self.textLabel.center = CGPointMake(self.bounds.size.width * 0.5f, self.bounds.size.height * 0.5f);
    [self.textLabel sizeToFit];
    
    if (!self.indicatorView.hidden) {
        self.indicatorView.left = self.textLabel.left-self.indicatorView.width-space;
        self.indicatorView.centerY =self.bounds.size.height * 0.5f;
        [self.indicatorView startAnimating];
    }
}

- (void)setupCellItem:(CDLoadMoreItem *)loadMoreItem {
    self.indicatorView.hidden=!loadMoreItem.showIndicator;
    self.textLabel.text = loadMoreItem.loadingTitle;
}

@end
