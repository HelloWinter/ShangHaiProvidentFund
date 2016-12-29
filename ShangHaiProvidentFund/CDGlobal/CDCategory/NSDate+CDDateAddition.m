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
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    if (!self) {
        return @"";
    }
    NSDateFormatter *tempFormat = [[NSDateFormatter alloc] init];
    [tempFormat setDateFormat:dateFormat];
    tempFormat.locale=[NSLocale currentLocale];
    NSString *dateString = [tempFormat stringFromDate:self];
    return dateString;
}

- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *todayCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == todayCmps.year) && (selfCmps.month == todayCmps.month) && (selfCmps.day == todayCmps.day);
}

- (NSString *)cd_timeintervalDescriptionToCurrentTime{
    NSTimeInterval intevalTime = [[NSDate date] timeIntervalSinceReferenceDate] - [self timeIntervalSinceReferenceDate];
    
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger days = intevalTime / 60 / 60 / 24;
    NSInteger months = intevalTime / 60 / 60 / 24 / 30;
    NSInteger years = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes == 0) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (days < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)days];
    }else if (months < 12){
        NSDateFormatter * formatter =[[NSDateFormatter alloc]init];
        formatter.dateFormat = @"MM-dd";
        NSString * strTime = [formatter stringFromDate:self];
        return strTime;
    }else if (years >= 1){
        NSDateFormatter * formatter =[[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *strTime = [formatter stringFromDate:self];
        return strTime;
    }
    return @"--";
}

@end
