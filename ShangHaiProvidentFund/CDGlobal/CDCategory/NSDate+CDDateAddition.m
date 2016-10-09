//
//  NSDate+CDDateAddition.m
//  CDAppDemo
//
//  Created by Cheng on 15/9/4.
//  Copyright (c) 2015年 Cheng. All rights reserved.
//

#import "NSDate+CDDateAddition.h"

@implementation NSDate (CDDateAddition)

- (NSString *)cd_transformToStringWithDateFormat:(NSString *)dateFormat {
    if (!dateFormat) {
        dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }
    if (!self) {
        return @"";
    }
    NSDateFormatter *tempFormat = [[NSDateFormatter alloc] init];
    [tempFormat setDateFormat:dateFormat];
    NSString *dateString = [tempFormat stringFromDate:self];
    return dateString;
}

- (BOOL)cd_isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *todayCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == todayCmps.year) && (selfCmps.month == todayCmps.month) && (selfCmps.day == todayCmps.day);
}

@end
