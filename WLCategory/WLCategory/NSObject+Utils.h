//
//  NSObject+Utils.h
//  huoxiu
//
//  Created by ikuaishou on 16/2/24.
//  Copyright © 2016年 51TV_王雷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Utils)

#pragma 正则匹配手机号

+ (BOOL)checkTelNumber:(NSString*) telNumber;

#pragma 正则匹配用户密码6-16位数字和字母组合

+ (BOOL)checkPassword:(NSString*) password;

#pragma 正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserName : (NSString*) userName;

#pragma 正则匹配用户身份证号

+ (BOOL)checkUserIdCard: (NSString*) idCard;

#pragma 正则验证码,6位的数字

+ (BOOL)checkVerificationCode: (NSString*) number;

#pragma 正则匹配URL

+ (BOOL)checkURL : (NSString*) url;

#pragma 正则匹配车牌号

+ (BOOL)checkLicensePlateNumber: (NSString *)numString;

@end
