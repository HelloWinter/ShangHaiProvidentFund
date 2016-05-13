//
//  CDOpinionsSuggestionsFieldCell.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDOpinionsSuggestionsFieldCell.h"
#import "CDOpinionsSuggestionsItem.h"

@interface CDOpinionsSuggestionsFieldCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CDOpinionsSuggestionsFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _textField.textAlignment=NSTextAlignmentLeft;
        _textField.font=[UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setupItem:(CDOpinionsSuggestionsItem *)item indexPath:(NSIndexPath *)path{
    _textField.secureTextEntry=[item.security isEqualToString:@"1"] ? YES : NO;
    _textField.text=item.value;
    self.label.text=item.paramname;
    [super setupLeftView:self.label rightView:nil placeHolder:item.hint indexPath:path];
}

- (UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.font=[UIFont systemFontOfSize:14];
    }
    return _label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize textsize = [self.label.text sizeWithAttributes:@{NSFontAttributeName:self.label.font}];
    self.label.frame=CGRectMake(0, 0, textsize.width, _textField.height);
}

@end
