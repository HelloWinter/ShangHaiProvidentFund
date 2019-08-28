//
//  CDRequestObject.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/4/28.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDRequestObject : NSObject

/**
 请求链接
 */
@property (nonatomic, copy) NSString *URLString;

/**
 请求参数
 */
@property (nonatomic, strong) id parameters;

/**
 是否添加通用参数(默认为YES)
 */
@property (nonatomic, assign, getter=isAddCommonParam) BOOL addCommonParam;

@end
