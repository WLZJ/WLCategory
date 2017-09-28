//
//  NSString+URL.h
//  kuaishoukanpian
//
//  Created by AllenTse on 2017/5/18.
//  Copyright © 2017年 kuaishou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSString *)encodeURL;
- (NSString *)decodeURL;
- (NSString *)decodeURLWithGBK;
@end
