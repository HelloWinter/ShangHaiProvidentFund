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
        [self.contentView addSubview:({
            _lbTitle=[[UILabel alloc]init];
            _lbTitle.numberOfLines=0;
            _lbTitle.lineBreakMode=NSLineBreakByWordWrapping;
            _lbTitle.font=[UIFont systemFontOfSize:15];
            _lbTitle.textColor=[UIColor darkGrayColor];
            _lbTitle;
        })];
        [self.contentView addSubview:({
            _lbAuthor=[[UILabel alloc]init];
            _lbAuthor.font=[UIFont systemFontOfSize:13];
            _lbAuthor.textColor=[UIColor lightGrayColor];
            _lbAuthor;
        })];
        [self.contentView addSubview:({
            _lbTime=[[UILabel alloc]init];
            _lbTime.font=[UIFont systemFontOfSize:13];
            _lbTime.textColor=[UIColor lightGrayColor];
            _lbTime.textAlignment=NSTextAlignmentRight;
            _lbTime;
        })];
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
    CGSize size=[_lbTitle.text cd_sizeWithPreferWidth:lbPreferWidth font:[UIFont systemFontOfSize:15]];
    _lbTitle.frame=CGRectMake(LEFT_RIGHT_MARGIN, kCellMargin, size.width, size.height);
    
    CGFloat lbWidth=lbPreferWidth*0.5;
    _lbAuthor.frame=CGRectMake(LEFT_RIGHT_MARGIN, _lbTitle.bottom+kCellMargin, lbWidth, klbTimeHeight);
    _lbTime.frame=CGRectMake(_lbAuthor.right, _lbAuthor.top, lbWidth, klbTimeHeight);
}

#pragma mark - public
- (void)setupCellItem:(CDNewsItem *)item{
    _lbTitle.text=[NSString stringWithFormat:@"【%@】%@",item.columnName,item.title];
    _lbTime.text=item.pubDate;
    _lbAuthor.text=item.author;
}

@end
