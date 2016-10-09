//
//  SCYMeasurementTextFieldCell.m
//  ProvidentFund
//
//  Created by cdd on 15/12/25.
//  Copyright © 2015年 9188. All rights reserved.
//

#import "SCYMeasurementTextFieldCell.h"
//#import "SCYRowItem.h"
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
//        self.textLabel.layer.borderColor=[UIColor redColor].CGColor;
//        self.textLabel.layer.borderWidth=0.5f;
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
    self.textFieldRight.frame=CGRectMake(size.width+LEFT_RIGHT_MARGIN*2,0, self.width-size.width-LEFT_RIGHT_MARGIN*3, self.height);
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
        _textFieldRight.keyboardType=UIKeyboardTypeNumberPad;
        _textFieldRight.delegate=self;
        _textFieldRight.font=[UIFont systemFontOfSize:cellTextFontSize];
//        _textFieldRight.layer.borderColor=[UIColor blackColor].CGColor;
//        _textFieldRight.layer.borderWidth=0.5;
    }
    return _textFieldRight;
}

- (void)setupLeftText:(NSString *)left RightText:(NSString *)right defaultText:(NSString *)defaultText IndexPath:(NSIndexPath *)path{
    self.textFieldRight.indexPath=path;
    self.textLabel.text=left;
    self.lbTextFieldRight.text=right;
    
    CGSize rightLabelSize= [self.lbTextFieldRight.text sizeWithAttributes:@{NSFontAttributeName:self.lbTextFieldRight.font}];
    self.lbTextFieldRight.frame=CGRectMake(0, 0, rightLabelSize.width, self.height);
    self.textFieldRight.rightView=self.lbTextFieldRight;
    self.textFieldRight.rightViewMode=UITextFieldViewModeAlways;
    
    if (defaultText.length!=0) {
        self.textFieldRight.text=defaultText;
    }else{
        self.textFieldRight.text=@"";
    }
}

//- (void)setupRowItem:(SCYRowItem *)item IndexPath:(NSIndexPath *)path{
//    [self setupLeftText:item.itemdesc RightText:item.editunit defaultText:item.itemvalue IndexPath:path];
//}

- (void)setupMortgageCalculatorCellItem:(SCYMortgageCalculatorCellItem *)item IndexPath:(NSIndexPath *)path{
    [self setupLeftText:item.paramdesc RightText:item.paramunit defaultText:item.paramvalue IndexPath:path];
}

- (void)setupTextFieldText:(NSString *)text{
    self.textFieldRight.text=text;
}

- (NSString *)cellText{
    return self.textFieldRight.text;
}

- (void)textfieldBecomeFirstResponder{
    [self.textFieldRight becomeFirstResponder];
}

@end
