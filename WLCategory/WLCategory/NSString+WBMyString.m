//
//  NSString+WBMyString.m
//  DowStoreSystem
//
//  Created by dow_dev_zhangwenbing on 2017/5/8.
//  Copyright © 2017年 dow_dev_zhangwenbing. All rights reserved.
//

#import "NSString+WBMyString.h"

@implementation NSString (WBMyString)


- (NSString *)urlEncoded
{
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}

- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding
{
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd])
    {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 1 || kvPair.count == 2)
        {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSMutableArray* values = [pairs objectForKey:key];
            if (nil == values)
            {
                values = [NSMutableArray array];
                [pairs setObject:values forKey:key];
            }
            if (kvPair.count == 1)
            {
                [values addObject:[NSNull null]];
                
            }
            else if (kvPair.count == 2)
            {
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:encoding];
                [values addObject:value];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query
{
    if (!query.count) {
        return self;
    }
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator])
    {
        NSString* value = [query objectForKey:key];
//        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
//        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound)
    {
        return [self stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}

- (NSString*)stringByAddingURLEncodedQueryDictionary:(NSDictionary*)query
{
    NSMutableDictionary* encodedQuery = [NSMutableDictionary dictionaryWithCapacity:[query count]];
    
    for (NSString* key in [query keyEnumerator]) {
        NSParameterAssert([key respondsToSelector:@selector(urlEncoded)]);
        NSString* value = [query objectForKey:key];
        NSParameterAssert([value respondsToSelector:@selector(urlEncoded)]);
        value = [value urlEncoded];
        NSString *urlEncodedKey = [key urlEncoded];
        [encodedQuery setValue:value forKey:urlEncodedKey];
    }
    
    return [self stringByAddingQueryDictionary:encodedQuery];
}

- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str color:(UIColor *)color
{
    NSRange range = [self rangeOfString:str];
    NSMutableAttributedString *outStr = [[NSMutableAttributedString alloc] initWithString:self];
    [outStr addAttributes:@{NSForegroundColorAttributeName : color} range:range];
    return outStr;
}
//关于字体大小
- (NSAttributedString *)attributStrWithTargetStr:(NSString *)str font:(UIFont *)font
{
    NSRange range = [self rangeOfString:str];
    NSMutableAttributedString *outStr = [[NSMutableAttributedString alloc] initWithString:self];
    [outStr addAttributes:@{NSFontAttributeName : font} range:range];
    return outStr;
}


#pragma Font

- (CGSize) size_With_Font:(UIFont *)font
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self sizeWithAttributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]];
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version < 7.0)
    {
        return [self sizeWithFont: font];
    }
    else
    {
        return [self sizeWithAttributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]];
    }
#endif
}

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self boundingRectWithSize: size
                              options: NSStringDrawingUsesLineFragmentOrigin
                           attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                              context: nil].size;
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0)
    {
        return [self sizeWithFont: font constrainedToSize: size lineBreakMode: lineBreakMode];
    }
    else
    {
        return [self boundingRectWithSize: size
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                                  context: nil].size;
    }
#endif
}

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self boundingRectWithSize: size
                              options: NSStringDrawingUsesLineFragmentOrigin
                           attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                              context: nil].size;
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0)
    {
        return [self sizeWithFont: font constrainedToSize: size];
    }
    else
    {
        return [self boundingRectWithSize: size
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                                  context: nil].size;
    }
#endif
    
}

- (NSString *)stringByRemovingHTMLTags
{
    NSString *html = [self mutableCopy];
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

+ (NSString *)checkNilStrWithStr:(NSString *)sourceStr
{
    if ([self stringIsEmpty:sourceStr])
    {
        return @"";
    }
    return sourceStr;
}

+ (BOOL)stringIsEmpty:(NSString *)sourceStr
{
    if ([sourceStr isKindOfClass:[NSString class]] && sourceStr.length > 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (NSString *)checkNilStr
{
    if ([NSString stringIsEmpty:self])
    {
        return @"";
    }
    return self;
}
//时间转换
+ (NSString*)getMessageDateString:(NSDate*)messageDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:messageDate];
    NSDate *msgDate = [cal dateFromComponents:components];
    
    components = [cal components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    if([today isEqualToDate:msgDate])
        [formatter setDateFormat:@"HH:mm"];
    
    components.day -= 1;
    NSDate *yestoday = [cal dateFromComponents:components];
    
    if([yestoday isEqualToDate:msgDate])
        [formatter setDateFormat:@"昨天 HH:mm"];
    
    return [formatter stringFromDate:messageDate];
}


@end
