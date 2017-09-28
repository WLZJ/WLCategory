//
//  NSDictionary+JSON.h
//  DowStoreSystem
//
//  Created by WangLei(王雷) on 2017/7/7.
//  Copyright © 2017年 dow_dev_zhangwenbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

- (NSString*)jsonString;
+ (NSDictionary*)initWithJsonString:(NSString*)json;

@end
