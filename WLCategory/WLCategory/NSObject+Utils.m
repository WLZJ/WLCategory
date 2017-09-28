//
//  NSObject+Utils.m
//  huoxiu
//
//  Created by ikuaishou on 16/2/24.
//  Copyright © 2016年 51TV_王雷. All rights reserved.
//

#import "NSObject+Utils.h"

@implementation NSObject (Utils)


#pragma 正则匹配手机号

+ (BOOL)checkTelNumber:(NSString*) telNumber

{
    
    NSString *pattern =@"^1+[3578]+\\d{9}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    
    return isMatch;
    
}

#pragma 正则匹配用户密码6-16位数字和字母组合

+ (BOOL)checkPassword:(NSString*) password

{
    
    //NSString *pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    
    NSString *pattern = @"^[a-zA-Z0-9]{6,16}+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserName : (NSString*) userName

{
    
    NSString *pattern =@"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:userName];
    
    return isMatch;
    
}

#pragma 正则匹配用户身份证号15或18位

+ (BOOL)checkUserIdCard: (NSString*) idCard

{
    
    NSString *pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:idCard];
    
    return isMatch;
    
}

#pragma 正则验证码,6位的数字

+ (BOOL)checkVerificationCode:(NSString*) number

{
    
    NSString *pattern =@"^[0-9]{6}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:number];
    
    return isMatch;
    
}

#pragma 正则匹配URL

+ (BOOL)checkURL : (NSString*) url

{
    NSString *pattern =@"^[0-9A-Za-z]{1,50}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:url];
    
    return isMatch;
    
}

#pragma 正则匹配车牌号

+ (BOOL)checkLicensePlateNumber: (NSString *)numString {
    BOOL isMatch;
    if (numString.length == 7) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5]{1}[A-HJ-NP-Z]{1}[A-HJ-NP-Z_0-9]{5}$"];
        isMatch = [pred evaluateWithObject:numString];
        return isMatch;
    }else {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5]{1}[A-HJ-NP-Z]{1}[A-HJ-NP-Z_0-9]{6}$"];
        isMatch = [pred evaluateWithObject:numString];
        return isMatch;
        }
    
    return YES;
}



@end
