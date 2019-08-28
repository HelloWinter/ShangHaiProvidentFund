//
//  CDResponseObject.m
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import "CDResponseObject.h"

@interface CDResponseObject()

@property (nonatomic, copy, readwrite) NSString *statusKey;
@property (nonatomic, copy, readwrite) NSString *msgKey;
@property (nonatomic, copy, readwrite) NSString *dataKey;
@property (nonatomic, assign) NSInteger successStatus;

@end

@implementation CDResponseObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusKey = @"status";//@"stateCode";//
        self.msgKey = @"msg";
        self.dataKey = @"data";
        self.successStatus = 10000;//1;//
    }
    return self;
}

- (void)setStatus:(NSInteger)status{
    _status = status;
    _isSucceed = _status == _successStatus;
}

@end
