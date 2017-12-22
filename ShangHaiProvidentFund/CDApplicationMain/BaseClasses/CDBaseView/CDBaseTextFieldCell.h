//
//  CDBaseTextFieldCell.h
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@interface CDBaseTextFieldCell : CDBaseTableViewCell{
@protected
    UITextField *_textField;
}

/**
 *  快速创建常见的带有输入框的cell
 *
 *  @param lView       输入框leftView
 *  @param rView       输入框rightView
 *  @param placeHolder 输入框占位内容
 *  @param defText     输入框显示内容
 *  @param path        cell的indexpath
 */
- (void)setupLeftView:(UIView *)lView rightView:(UIView *)rView placeHolder:(NSString *)placeHolder defaultText:(NSString *)defText indexPath:(NSIndexPath *)path;

/**
 *  取得cell中输入框的数据
 */
- (NSString *)cellText;

/**
 *  将当前cell变成第一响应者
 */
- (void)cellTextFieldBecomeFirstResponder;

@end
