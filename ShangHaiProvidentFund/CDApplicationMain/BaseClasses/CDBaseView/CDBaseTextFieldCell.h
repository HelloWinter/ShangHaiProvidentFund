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

- (void)setupLeftView:(UIView *)left rightView:(UIView *)right placeHolder:(NSString *)placeHolder indexPath:(NSIndexPath *)path;

- (void)cellTextFieldBecomeFirstResponder;

- (NSString *)cellText;

@end
