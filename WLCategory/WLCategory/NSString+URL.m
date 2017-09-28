//
//  NSString+URL.m
//  kuaishoukanpian
//
//  Created by AllenTse on 2017/5/18.
//  Copyright © 2017年 kuaishou. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)encodeURL
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
            (__bridge CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}
- (NSString *)decodeURL
{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
- (NSString *)decodeURLWithGBK
{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
            (__bridge CFStringRef)self,
            CFSTR(""),
            CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000));
    return decodedString;
}
@end
