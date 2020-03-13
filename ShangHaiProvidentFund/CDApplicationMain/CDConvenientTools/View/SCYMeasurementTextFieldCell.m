//
//  SCYMeasurementTextFieldCell.m
//  ProvidentFund
//
//  Created by cdd on 15/12/25.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "SCYMeasurementTextFieldCell.h"
#import "SCYMortgageCalculatorCellItem.h"
#import "UITextField+cellIndexPath.h"

static const CGFloat cellTextFontSize=15;

@interface SCYMeasurementTextFieldCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textFieldRight;
@property (nonatomic, strong) UILabel *lbTextFieldRight;

@end

@implementation SCYMeasurementTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryView=self.textFieldRight;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.textLabel.font=[UIFont systemFontOfSize:cellTextFontSize];
    }
    return self;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 46;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size= [self.textLabel.text sizeWithAttributes:@{NSFontAttributeName:self.textLabel.font}];
    self.textLabel.width=size.width;
    _textFieldRight.frame=CGRectMake(size.width+LEFT_RIGHT_MARGIN*2,0, self.width-size.width-LEFT_RIGHT_MARGIN*3, self.height);
}

- (UILabel *)lbTextFieldRight{
    if (_lbTextFieldRight==nil) {
        _lbTextFieldRight=[[UILabel alloc]init];
        _lbTextFieldRight.textAlignment=NSTextAlignmentCenter;
        _lbTextFieldRight.font=[UIFont systemFontOfSize:cellTextFontSize];
    }
    return _lbTextFieldRight;
}

- (UITextField *)textFieldRight{
    if (_textFieldRight==nil) {
        _textFieldRight=[[UITextField alloc]init];
        _textFieldRight.textAlignment=NSTextAlignmentRight;
        _textFieldRight.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        _textFieldRight.delegate=self;
        _textFieldRight.font=[UIFont systemFontOfSize:cellTextFontSize];
//        _textFieldRight.layer.borderColor=[UIColor blackColor].CGColor;
//        _textFieldRight.layer.borderWidth=0.5;
    }
    return _textFieldRight;
}

#pragma mark - public
- (void)setupLeftText:(NSString *)left rightText:(NSString *)right defaultText:(NSString *)defaultText indexPath:(NSIndexPath *)path{
    _textFieldRight.indexPath=path;
    self.textLabel.text=left;
    _lbTextFieldRight.text=right;
    CGSize rightLabelSize= [_lbTextFieldRight.text sizeWithAttributes:@{NSFontAttributeName:_lbTextFieldRight.font}];
    _lbTextFieldRight.frame=CGRectMake(0, 0, rightLabelSize.width, self.height);
    _textFieldRight.rightView=_lbTextFieldRight;
    _textFieldRight.rightViewMode=UITextFieldViewModeAlways;
    _textFieldRight.text=(defaultText.length!=0) ? defaultText : @"";
}

- (void)setupMortgageCalculatorCellItem:(SCYMortgageCalculatorCellItem *)item IndexPath:(NSIndexPath *)path{
    [self setupLeftText:item.paramdesc rightText:item.paramunit defaultText:item.paramvalue indexPath:path];
}

- (void)setupTextFieldText:(NSString *)text{
    _textFieldRight.text=text;
}

- (NSString *)cellText{
    return _textFieldRight.text;
}

- (void)textfieldBecomeFirstResponder{
    [_textFieldRight becomeFirstResponder];
}

@end
