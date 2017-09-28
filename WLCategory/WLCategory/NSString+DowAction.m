//
//  NSString+DowAction.m
//  DowCarMaster
//
//  Created by WangLei(王雷) on 2017/9/1.
//  Copyright © 2017年 Shanghai Daou Baixite Auto Parts Co.,Ltd. All rights reserved.
//

#import "NSString+DowAction.h"

@implementation NSString (DowAction)

+ (NSString *)byFormat:(NSInteger)count{
    if (count < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)count];
    }
    return [NSString stringWithFormat:@"%.2lf万",count/10000.0];
}

+(NSString *)formatter:(NSInteger)count{
    if (count < 1000) {
        return [NSString stringWithFormat:@"%ld",count];
    }
    
    static NSNumberFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return [formatter stringFromNumber:[NSNumber numberWithInteger:count]];
}


+ (NSString *)byFormatWithNum:(NSInteger)count{
    if (count < 1000) {
        return [NSString stringWithFormat:@"%ld",(long)count];
    }else if (count < 10000){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        return [formatter stringFromNumber:[NSNumber numberWithInteger:count]];
    }else{
        double score = count/10000.0;
        score = floor(score * 100);
        score = score/100;
        return [NSString stringWithFormat:@"%.2lf万",score];
    }
}
+(NSString*)uuid{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+ (NSString *)timeString{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
    return [NSString stringWithFormat:@"%0.0f", floor(a)]; //转为字符型
}

- (BOOL)stringContainsEmoji{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              // surrogate pair
                              if (0xd800 <= hs && hs <= 0xdbff)
                              {
                                  if (substring.length > 1)
                                  {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f918)
                                      {
                                          returnValue = YES;
                                      }
                                  }
                              }
                              else if (substring.length > 1)
                              {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3 || ls == 0xFE0F || ls == 0xd83c)
                                  {
                                      returnValue = YES;
                                  }
                              }
                              else
                              {
                                  // non surrogate
                                  if (0x2100 <= hs && hs <= 0x27ff)
                                  {
                                      if (0x278b <= hs && 0x2792 >= hs)
                                      {
                                          returnValue = NO;
                                      }
                                      else
                                      {
                                          returnValue = YES;
                                      }
                                  }
                                  else if (0x2B05 <= hs && hs <= 0x2b07)
                                  {
                                      returnValue = YES;
                                  }
                                  else if (0x2934 <= hs && hs <= 0x2935)
                                  {
                                      returnValue = YES;
                                  }
                                  else if (0x3297 <= hs && hs <= 0x3299)
                                  {
                                      returnValue = YES;
                                  }
                                  else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e)
                                  {
                                      returnValue = YES;
                                  }
                              }
                          }];
    return returnValue;
}
//判断是否包含非法字符
- (BOOL)stringContainsIllegalCharacter{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\".?~!。"];
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:characterSet];
    
    return ![self isEqualToString:trimmedString];
}
//正则表达式替换两个以上的空格为一个空格
-(NSString *)stringDealWithSpace{
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s{2,}" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *arr = [regex matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0,self.length)];
    
    arr = [[arr reverseObjectEnumerator] allObjects];
    if (arr.count<1) {//没有空格
        return self;
    }
    NSString *newStr = @"";
    for (NSTextCheckingResult *str in arr) {
        newStr = [self stringByReplacingCharactersInRange:[str range] withString:@" "];
    }
    return newStr;
}

- (NSString *)removeSpace
{
    NSMutableString * temp = [[NSMutableString alloc]initWithString:self];
    NSRange range = [self rangeOfString:@" "];
    while (range.length != NSNotFound) {
        [temp deleteCharactersInRange:range];
        range = [temp rangeOfString:@" "];
    }
    return [NSString stringWithString:temp];
}

- (NSString *)remoteLeaderAndTrailSpace
{
    
    NSMutableString * temp = [[NSMutableString alloc]initWithString:self];
    while ([temp hasPrefix:@" "]) {
        [temp deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    while ([temp hasSuffix:@" "]) {
        [temp deleteCharactersInRange:NSMakeRange(temp.length - 1, 1)];
    }
    
    return [NSString stringWithString:temp];
}
@end
