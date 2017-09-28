//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  DowCarMaster
//
//  Created by WangLei(王雷) on 2017/8/30.
//  Copyright © 2017年 Shanghai Daou Baixite Auto Parts Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)

/** * 改变行间距 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/** * 改变字间距 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/** * 改变行间距和字间距 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
