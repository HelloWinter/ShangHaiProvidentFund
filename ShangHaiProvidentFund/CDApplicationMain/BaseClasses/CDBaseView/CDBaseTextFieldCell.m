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
        [self.contentView addSubview:({
            _textField=[[UITextField alloc]init];
            _textField.textAlignment=NSTextAlignmentRight;
            _textField.autocorrectionType = NO;
            _textField;
        })];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _textField.frame=CGRectMake(CELL_MARGIN, 0, self.width-CELL_MARGIN*2, self.height);
}

#pragma mark - public
- (NSString *)cellText{
    return _textField.text;
}

- (void)setupLeftView:(UIView *)lView rightView:(UIView *)rView placeHolder:(NSString *)placeHolder defaultText:(NSString *)defText indexPath:(NSIndexPath *)path{
    _textField.indexPath=path;
    _textField.leftView=lView;
    _textField.leftViewMode=UITextFieldViewModeAlways;
    _textField.rightView=rView;
    _textField.rightViewMode=UITextFieldViewModeAlways;
    _textField.placeholder=placeHolder ? : @"";
    _textField.text=defText ? : @"";
}

- (void)cellTextFieldBecomeFirstResponder{
    [_textField becomeFirstResponder];
}

@end
