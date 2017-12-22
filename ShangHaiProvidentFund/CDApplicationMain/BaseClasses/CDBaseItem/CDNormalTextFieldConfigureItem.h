//
//  CDNormalTextFieldConfigureItem.h
//  ShangHaiProvidentFund
//
//  Created by cd on 2017/9/11.
//  Copyright © 2017年 cheng dong. All rights reserved.
//

#import "CDBaseItem.h"

@interface CDNormalTextFieldConfigureItem : CDBaseItem

@property (nonatomic, copy) NSString *type;//cell类型：0：普通输入cell,1：右侧带button输入cell,2：验证码输入cell//,3：带弹出框选择的cell
@property (nonatomic, copy) NSString *paramname;//左边输入内容描述
@property (nonatomic, copy) NSString *paramsubmit;//接口参数字段
@property (nonatomic, copy) NSString *value;//value
@property (nonatomic, copy) NSString *hint;//plcaceholder
@property (nonatomic, copy) NSString *security;//是否密文输入
//@property (nonatomic, copy) NSString *btn;//带有发送验证码按钮标志

@end
