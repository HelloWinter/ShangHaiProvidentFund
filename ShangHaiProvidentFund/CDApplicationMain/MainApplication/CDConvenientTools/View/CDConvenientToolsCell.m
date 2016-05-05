//
//  CDConvenientToolsCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDConvenientToolsCell.h"
#import "CDConvenientToolsItem.h"

#define MARGIN 4.0

@interface CDConvenientToolsCell ()

@property (strong, nonatomic)  UIImageView *imageView;

@property (strong, nonatomic)  UILabel *lbTitle;

@end

@implementation CDConvenientToolsCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
//        self.layer.borderColor=[UIColor redColor].CGColor;
//        self.layer.borderWidth=0.5;
//        self.backgroundColor=[UIColor whiteColor];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.lbTitle];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=CGRectMake(MARGIN, MARGIN, self.width-MARGIN*2, (self.width-MARGIN*2)*3*0.25);
    self.lbTitle.frame=CGRectMake(MARGIN, self.imageView.bottom, self.width-MARGIN*2, 18);
}

- (UIImageView *)imageView{
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc]init];
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
//        _imageView.layer.borderColor=[UIColor blackColor].CGColor;
//        _imageView.layer.borderWidth=0.5;
    }
    return _imageView;
}

- (UILabel *)lbTitle{
    if (_lbTitle==nil) {
        _lbTitle = [[UILabel alloc]init];
        _lbTitle.textColor=ColorFromHexRGB(0x212121);
        _lbTitle.font=[UIFont systemFontOfSize:12];
        _lbTitle.textAlignment=NSTextAlignmentCenter;
//        _lbTitle.layer.borderColor=[UIColor blueColor].CGColor;
//        _lbTitle.layer.borderWidth=0.5;
    }
    return _lbTitle;
}

- (void)setupCellItem:(CDConvenientToolsItem *)item{
    self.imageView.image=[UIImage imageNamed:item.imgName];
    self.lbTitle.text=item.title ? : @"";
}

@end
