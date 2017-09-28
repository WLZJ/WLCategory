//
//  NSString+DowAction.h
//  DowCarMaster
//
//  Created by WangLei(王雷) on 2017/9/1.
//  Copyright © 2017年 Shanghai Daou Baixite Auto Parts Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DowAction)

/**
 *  数字“万化”
 *
 *  @param count 数字
 *
 *  @return 字符串
 */
+ (NSString *)byFormat:(NSInteger)count;
/**
 *  数字"千"格式化
 *
 *  @param count 数字
 *
 *  @return 字符串
 */
+ (NSString *)formatter:(NSInteger)count;

/**
 *  数字格式化
 *
 *  @param count 数字
 *
 *  @return 字符串
 */
+ (NSString *)byFormatWithNum:(NSInteger)count;

/**
 *  UUID
 *
 *  @return uuid
 */
+(NSString *)uuid;

/**
 *  当前时间（精确到毫秒）
 *
 *  @return 当前时间（精确到毫秒）
 */
+ (NSString *)timeString;

//判断是否包含emoji表情
- (BOOL)stringContainsEmoji;
//判断是否包含非法字符
- (BOOL)stringContainsIllegalCharacter;
//正则表达式替换两个以上的空格为一个空格
- (NSString *)stringDealWithSpace;

- (NSString *)removeSpace;
- (NSString *)remoteLeaderAndTrailSpace;

@end
