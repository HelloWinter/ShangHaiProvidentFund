//
//  SCYAnnualBonusCalculatorCell.m
//  ProvidentFund
//
//  Created by Cheng on 17/1/15.
//  Copyright © 2017年 9188. All rights reserved.
//

#import "SCYAnnualBonusCalculatorCell.h"
#import "UITextField+cellIndexPath.h"

static const CGFloat cellTextFontSize=15.0;


@interface SCYAnnualBonusCalculatorCell ()//<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *lbLeft;
@property (nonatomic, strong) UILabel *lbRight;

@end

@implementation SCYAnnualBonusCalculatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _textField.font=[UIFont systemFontOfSize:cellTextFontSize];
        _textField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    }
    return self;
}

- (UILabel *)lbLeft{
    if (_lbLeft==nil) {
        _lbLeft=[[UILabel alloc]init];
        _lbLeft.font=[UIFont systemFontOfSize:cellTextFontSize];
    }
    return _lbLeft;
}

- (UILabel *)lbRight{
    if (_lbRight==nil) {
        _lbRight=[[UILabel alloc]init];
        _lbRight.font=[UIFont systemFontOfSize:cellTextFontSize];
        _lbRight.text=@"  元";
    }
    return _lbRight;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 46;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _textField.frame=CGRectMake(LEFT_RIGHT_MARGIN, 0, self.width-LEFT_RIGHT_MARGIN*2, self.height);
    CGSize leftTextsize = [self.lbLeft.text sizeWithAttributes:@{NSFontAttributeName:self.lbLeft.font}];
    self.lbLeft.bounds=CGRectMake(0, 0, leftTextsize.width, _textField.height);
    
    CGSize rightTextSize=[self.lbRight.text sizeWithAttributes:@{NSFontAttributeName:self.lbRight.font}];
    self.lbRight.bounds=CGRectMake(0, 0, rightTextSize.width, _textField.height);
}

#pragma mark - public
- (void)setupLeftText:(NSString *)left indexPath:(NSIndexPath *)path{
    _textField.indexPath=path;
    self.lbLeft.text=left;
    [super setupLeftView:self.lbLeft rightView:self.lbRight placeHolder:@"" defaultText:@"" indexPath:path];
}

- (void)setupTextFieldText:(NSString *)text{
    _textField.text=text;
}



@end
