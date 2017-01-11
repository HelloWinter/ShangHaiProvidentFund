//
//  CDOpinionsSuggestionsViewCell.m
//  ShangHaiProvidentFund
//
//  Created by Cheng on 16/5/7.
//  Copyright © 2016年 cheng dong. All rights reserved.
//

#import "CDOpinionsSuggestionsViewCell.h"
#import "CDOpinionsSuggestionsItem.h"
#import "UITextView+CDCategory.h"

@interface CDOpinionsSuggestionsViewCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbTitleName;
@property (weak, nonatomic) IBOutlet UITextView *tvLeaveMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbPlaceHolder;

@end

@implementation CDOpinionsSuggestionsViewCell

+ (instancetype)textViewCell{
    CDOpinionsSuggestionsViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CDOpinionsSuggestionsViewCell" owner:nil options:nil]lastObject];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib{
    [super awakeFromNib];
//    self.lbTitleName.layer.borderColor=[UIColor redColor].CGColor;
//    self.lbTitleName.layer.borderWidth=0.5;
//    
//    self.tvLeaveMessage.layer.borderColor=[UIColor blueColor].CGColor;
//    self.tvLeaveMessage.layer.borderWidth=0.5;
//    
//    self.lbPlaceHolder.layer.borderColor=[UIColor yellowColor].CGColor;
//    self.lbPlaceHolder.layer.borderWidth=0.5;
    
    self.tvLeaveMessage.delegate=self;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.lbPlaceHolder.hidden=YES;
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length==0) {
        self.lbPlaceHolder.hidden=NO;
    }
}

#pragma mark - public
- (void)setupCellItem:(CDOpinionsSuggestionsItem *)item indexPath:(NSIndexPath *)path{
    self.lbTitleName.text=item.paramname;
    self.lbPlaceHolder.text=item.hint;
    self.tvLeaveMessage.indexPath=path;
}

@end
