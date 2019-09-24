//
//  CDConvenientToolsCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDConvenientToolsCell.h"
#import "CDConvenientToolsItem.h"


static const CGFloat kMARGIN=4.0;

@interface CDConvenientToolsCell ()

@property (strong, nonatomic)  UIImageView *imageView;

@property (strong, nonatomic)  UILabel *lbTitle;

@end

@implementation CDConvenientToolsCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:({
            _imageView=[[UIImageView alloc]init];
            _imageView.contentMode=UIViewContentModeScaleAspectFit;
            _imageView;
        })];
        [self.contentView addSubview:({
            _lbTitle = [[UILabel alloc]init];
            UIColor *textColor = ColorFromHexRGB(0x212121);
            if (@available(iOS 13.0, *)) {
                textColor = [UIColor labelColor];
            }
            _lbTitle.textColor=textColor;
            _lbTitle.font=[UIFont systemFontOfSize:12];
            _lbTitle.textAlignment=NSTextAlignmentCenter;
            _lbTitle;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=CGRectMake(kMARGIN, kMARGIN, self.width-kMARGIN*2, (self.width-kMARGIN*2)*3*0.25);
    self.lbTitle.frame=CGRectMake(kMARGIN, self.imageView.bottom, self.width-kMARGIN*2, 18);
}

#pragma mark - public
- (void)setupCellItem:(CDConvenientToolsItem *)item{
    self.imageView.image=[UIImage imageNamed:item.imgName];
    self.lbTitle.text=item.title ? : @"";
}

@end
