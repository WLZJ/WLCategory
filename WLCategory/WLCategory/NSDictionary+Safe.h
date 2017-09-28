//
//  NSDictionary+Safe.h
//  DowStoreSystem
//
//  Created by WangLei(王雷) on 2017/7/7.
//  Copyright © 2017年 dow_dev_zhangwenbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

- (id)safeObjectForKey:(id)key;
- (int)intValueForKey:(id)key;
- (double)doubleValueForKey:(id)key;
- (NSString*)stringValueForKey:(id)key;

@end

@interface NSMutableDictionary(Safe)

- (void)safeSetObject:(id)anObject forKey:(id)aKey;
- (void)setIntValue:(int)value forKey:(id)aKey;
- (void)setDoubleValue:(double)value forKey:(id)aKey;
- (void)setStringValueForKey:(NSString*)string forKey:(id)aKey;

@end


@interface NSArray (Exception)

- (id)objectForKey:(id)key;

@end
