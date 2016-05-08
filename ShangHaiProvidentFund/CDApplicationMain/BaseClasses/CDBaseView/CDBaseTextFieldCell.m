//
//  CDBaseTextFieldCell.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTextFieldCell.h"
#import "UITextField+cellIndexPath.h"

//#define MARGIN 8

@interface CDBaseTextFieldCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation CDBaseTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (UITextField *)textField{
    if (_textField==nil) {
        _textField=[[UITextField alloc]init];
        _textField.textAlignment=NSTextAlignmentRight;
        _textField.autocorrectionType = NO;
    }
    return _textField;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textField.frame=CGRectMake(CELL_MARGIN, CELL_MARGIN, self.width-CELL_MARGIN*2, self.height-CELL_MARGIN*2);
}

- (void)setupLeftView:(UIView *)left rightView:(UIView *)right placeHolder:(NSString *)placeHolder indexPath:(NSIndexPath *)path{
    self.textField.indexPath=path;
    self.textField.leftView=left;
    self.textField.leftViewMode=UITextFieldViewModeAlways;
    self.textField.rightView=right;
    self.textField.rightViewMode=UITextFieldViewModeAlways;
    self.textField.placeholder=placeHolder ? : @"";
}

- (void)cellTextFieldBecomeFirstResponder{
    [self.textField becomeFirstResponder];
}

- (NSString *)cellText{
    return self.textField.text;
}

@end
