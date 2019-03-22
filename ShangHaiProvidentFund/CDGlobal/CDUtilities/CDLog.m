//
//  CDLog.m
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/3/22.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import "CDLog.h"

@implementation NSString (CDLog)

- (NSString *)unicodeString{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSPropertyListFormat format = NSPropertyListOpenStepFormat;
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:&format error:nil];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end

@implementation NSArray (CDLog)

- (NSString *)descriptionWithLocale:(id)locale{
    return self.description.unicodeString;
}

@end

@implementation NSDictionary (CDLog)

- (NSString *)descriptionWithLocale:(id)locale{
    return self.description.unicodeString;
}

@end

@implementation NSSet (CDLog)

- (NSString *)descriptionWithLocale:(id)locale{
    return self.description.unicodeString;
}

@end
