//
//  CDNewsAndTrendsCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNewsAndTrendsCell.h"
#import "CDNewsItem.h"
#import "NSString+CDEncryption.h"

static const CGFloat kCellMargin=8;
static const CGFloat klbTimeHeight=20;


@interface CDNewsAndTrendsCell ()

@property (strong, nonatomic) UILabel *lbTitle;
@property (strong, nonatomic) UILabel *lbTime;
@property (nonatomic, strong) UILabel *lbAuthor;

@end

@implementation CDNewsAndTrendsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.lbTitle];
        [self.contentView addSubview:self.lbAuthor];
        [self.contentView addSubview:self.lbTime];
    }
    return self;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    CDNewsItem *item=object;
    CGFloat lbPreferWidth=SCREEN_WIDTH-LEFT_RIGHT_MARGIN*3;
    NSString *author = [NSString stringWithFormat:@"【%@】%@",item.columnName,item.title];
    CGSize size=[author cd_sizeWithPreferWidth:lbPreferWidth font:[UIFont systemFontOfSize:15]];
    return size.height+klbTimeHeight+kCellMargin*3;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lbPreferWidth=SCREEN_WIDTH-LEFT_RIGHT_MARGIN*3;
    CGSize size=[self.lbTitle.text cd_sizeWithPreferWidth:lbPreferWidth font:[UIFont systemFontOfSize:15]];
    self.lbTitle.frame=CGRectMake(LEFT_RIGHT_MARGIN, kCellMargin, size.width, size.height);
    
    CGFloat lbWidth=lbPreferWidth*0.5;
    self.lbAuthor.frame=CGRectMake(LEFT_RIGHT_MARGIN, self.lbTitle.bottom+kCellMargin, lbWidth, klbTimeHeight);
    self.lbTime.frame=CGRectMake(self.lbAuthor.right, self.lbAuthor.top, lbWidth, klbTimeHeight);
}

- (UILabel *)lbTitle{
    if (_lbTitle==nil) {
        _lbTitle=[[UILabel alloc]init];
        _lbTitle.numberOfLines=0;
        _lbTitle.lineBreakMode=NSLineBreakByWordWrapping;
        _lbTitle.font=[UIFont systemFontOfSize:15];
        _lbTitle.textColor=[UIColor darkGrayColor];
//        _lbTitle.backgroundColor=[UIColor yellowColor];
    }
    return _lbTitle;
}

- (UILabel *)lbTime{
    if (_lbTime==nil) {
        _lbTime=[[UILabel alloc]init];
        _lbTime.font=[UIFont systemFontOfSize:13];
        _lbTime.textColor=[UIColor lightGrayColor];
        _lbTime.textAlignment=NSTextAlignmentRight;
//        _lbTime.backgroundColor=[UIColor yellowColor];
    }
    return _lbTime;
}

- (UILabel *)lbAuthor{
    if (_lbAuthor==nil) {
        _lbAuthor=[[UILabel alloc]init];
        _lbAuthor.font=[UIFont systemFontOfSize:13];
        _lbAuthor.textColor=[UIColor lightGrayColor];
        //        _lbTime.backgroundColor=[UIColor yellowColor];
    }
    return _lbAuthor;
}

#pragma mark - public
- (void)setupCellItem:(CDNewsItem *)item{
    self.lbTitle.text=[NSString stringWithFormat:@"【%@】%@",item.columnName,item.title];
    self.lbTime.text=item.pubDate;
    self.lbAuthor.text=item.author;
}

@end
