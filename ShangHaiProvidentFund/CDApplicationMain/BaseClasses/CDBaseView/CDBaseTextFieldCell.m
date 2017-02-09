//
//  CDBaseTextFieldCell.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTextFieldCell.h"
#import "UITextField+cellIndexPath.h"


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
        //        _textField.layer.borderColor = [UIColor orangeColor].CGColor;
        //        _textField.layer.borderWidth = 0.5;
    }
    return _textField;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textField.frame=CGRectMake(CELL_MARGIN, 0, self.width-CELL_MARGIN*2, self.height);
}

#pragma mark - public
- (NSString *)cellText{
    return self.textField.text;
}

- (void)setupLeftView:(UIView *)lView rightView:(UIView *)rView placeHolder:(NSString *)placeHolder defaultText:(NSString *)defText indexPath:(NSIndexPath *)path{
    self.textField.indexPath=path;
    self.textField.leftView=lView;
    self.textField.leftViewMode=UITextFieldViewModeAlways;
    self.textField.rightView=rView;
    self.textField.rightViewMode=UITextFieldViewModeAlways;
    self.textField.placeholder=placeHolder ? : @"";
    self.textField.text=defText ? : @"";
}

- (void)cellTextFieldBecomeFirstResponder{
    [self.textField becomeFirstResponder];
}

@end
