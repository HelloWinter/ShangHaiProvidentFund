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

- (void)setupLeftView:(UIView *)lView rightView:(UIView *)rView placeHolder:(NSString *)placeHolder defaultText:(NSString *)defText indexPath:(NSIndexPath *)path;

- (NSString *)cellText;

- (void)cellTextFieldBecomeFirstResponder;

@end
