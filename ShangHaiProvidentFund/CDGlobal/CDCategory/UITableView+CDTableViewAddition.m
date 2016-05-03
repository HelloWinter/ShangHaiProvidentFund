//
//  UITableView+CDTableViewAddition.m
//  CDAppDemo
//
//  Created by Cheng on 15/9/4.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "UITableView+CDTableViewAddition.h"

@implementation UITableView (CDTableViewAddition)

- (void)cd_clearNeedlessCellLine{
    if (!self.tableFooterView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
    }
}

@end
