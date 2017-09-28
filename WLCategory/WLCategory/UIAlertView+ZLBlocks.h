//
//  UIAlertView+ZLBlocks.h
//  ZLBlockUIAlertView
//
//  Created by lzheng on 14-6-13.
//  Copyright (c) 2014年 lzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ZLAlertViewBlock)(UIAlertView *alertView);
typedef void(^ZLAlertViewCompleteBlock)(UIAlertView *alertView, NSUInteger index);
typedef BOOL (^ZLAlertViewBoolBlock)(UIAlertView *alertView);

@interface UIAlertView (ZLBlocks)

@property (nonatomic, copy) ZLAlertViewCompleteBlock alertViewClickedButtonAtIndexBlock;
@property (nonatomic, copy) ZLAlertViewBlock alertViewCancelBlock;
@property (nonatomic, copy) ZLAlertViewBlock willPresentAlertViewBlock;
@property (nonatomic, copy) ZLAlertViewBlock didPresentAlertViewBlock;
@property (nonatomic, copy) ZLAlertViewCompleteBlock alertViewWillDismissWithButtonIndexBlock;
@property (nonatomic, copy) ZLAlertViewCompleteBlock alerViewDidDismissWithButtonIndexBlock;
@property (nonatomic, copy) ZLAlertViewBoolBlock alertViewShouldEnableFirstOtherButtonBlock;
@end
