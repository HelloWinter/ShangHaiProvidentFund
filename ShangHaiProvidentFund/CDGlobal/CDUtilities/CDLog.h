//
//  CDLog.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/3/22.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//  打印日志
#ifdef IS_DEV
//#define CDLog(...) NSLog(__VA_ARGS__)
#define CDLog(...) printf("%s : %s\n", __FUNCTION__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define CDLog(...) //NSLog(__VA_ARGS__)
#endif


@interface NSString (CDLog)
@end

@interface NSArray (CDLog)
@end

@interface NSDictionary (CDLog)
@end

@interface NSSet (CDLog)
@end

NS_ASSUME_NONNULL_END
