//
//  CDNewsAndTrendsCell.m
//  ShangHaiProvidentFund
//
//  Created by cdd on 16/5/3.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDNewsAndTrendsCell.h"
#import "CDNewsItem.h"

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
    NSString *auttor = [NSString stringWithFormat:@"【%@】%@",item.columnName,item.title];
    CGSize size=[self getlbContentRectWith:auttor preferWidth:lbPreferWidth];
    return size.height+klbTimeHeight+kCellMargin*3;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat lbPreferWidth=SCREEN_WIDTH-LEFT_RIGHT_MARGIN*3;
    CGSize size=[CDNewsAndTrendsCell getlbContentRectWith:self.lbTitle.text preferWidth:lbPreferWidth];
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

- (void)setupCellItem:(CDNewsItem *)item{
    self.lbTitle.text=[NSString stringWithFormat:@"【%@】%@",item.columnName,item.title];
    self.lbTime.text=item.pubDate;
    self.lbAuthor.text=item.author;
}

+ (CGSize)getlbContentRectWith:(NSString *)str preferWidth:(CGFloat)lbContentPreferWidth{
    NSDictionary *dict=@{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    CGRect rectSingleLine=[@"我" boundingRectWithSize:CGSizeMake(lbContentPreferWidth, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    
    CGRect rect=[str boundingRectWithSize:CGSizeMake(lbContentPreferWidth, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    
//    CGFloat maxHeight=ceilf(CGRectGetHeight(rectSingleLine))*3;
//    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
//    if (sizeHieght > maxHeight) {
//        return CGSizeMake(sizeWidth, maxHeight);
//    }else{
//        return CGSizeMake(sizeWidth, sizeHieght);
//    }
    
    CGFloat maxHeight=CGRectGetHeight(rectSingleLine)*3;//;
    CGFloat sizeHieght=CGRectGetHeight(rect);//);
    if (sizeHieght > maxHeight) {
        return CGSizeMake(sizeWidth, ceilf(maxHeight));
    }else{
        return CGSizeMake(sizeWidth, ceilf(sizeHieght));
    }
}

@end
