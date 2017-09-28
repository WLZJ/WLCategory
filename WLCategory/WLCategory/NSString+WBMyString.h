//
//  NSString+WBMyString.h
//  DowStoreSystem
//
//  Created by dow_dev_zhangwenbing on 2017/5/8.
//  Copyright © 2017年 dow_dev_zhangwenbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WBMyString)

- (NSString *)urlEncoded;

- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding;

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

- (NSString*)stringByAddingURLEncodedQueryDictionary:(NSDictionary*)query;

- (NSString*)stringByRemovingHTMLTags;

- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str color:(UIColor *)color;
//关于字体大小
- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str font:(UIFont *)font;

/**
 *  Font
 */

- (CGSize) size_With_Font:(UIFont *)font;

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

+ (BOOL)stringIsEmpty:(NSString *)sourceStr;

- (NSString *)checkNilStr;

+ (NSString *)checkNilStrWithStr:(NSString *)sourceStr;
//时间转换
+ (NSString*)getMessageDateString:(NSDate*)messageDate;

@end
