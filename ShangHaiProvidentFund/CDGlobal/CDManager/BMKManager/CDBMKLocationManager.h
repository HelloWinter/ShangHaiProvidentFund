//
//  CDBMKLocationManager.h
//  ShangHaiProvidentFund
//
//  Created by chengdong on 2019/8/24.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDBMKLocationManager : NSObject

AS_SINGLETON(CDBMKLocationManager)

- (void)startLocation;

@end
