//
//  UIAlertView+ZLBlocks.m
//  ZLBlockUIAlertView
//
//  Created by lzheng on 14-6-13.
//  Copyright (c) 2014年 lzheng. All rights reserved.
//

#import "UIAlertView+ZLBlocks.h"
#import <objc/runtime.h>
static char ZLOriginalUIAlertViewDelegateKey;

static char ZLAlertViewClickedButtonAtIndexBlockKey;
static char ZLAlertViewCancelBlockKey;
static char ZLWillPresentAlertViewBlockKey;
static char ZLDidPresentAlertViewBlockKey;
static char ZLAlertViewWillDismissWithButtonIndexBlockKey;
static char ZLAlerViewDidDismissWithButtonIndexBlockKey;
static char ZLAlertViewShouldEnableFirstOtherButtonBlockKey;

@implementation UIAlertView (ZLBlocks)

- (void)_useBlock {
    if (self.delegate && self.delegate != (id<UIAlertViewDelegate>)self) {
        objc_setAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
    }
    self.delegate = (id<UIAlertViewDelegate>)self;
}

- (ZLAlertViewCompleteBlock)alertViewClickedButtonAtIndexBlock {
    return objc_getAssociatedObject(self, &ZLAlertViewClickedButtonAtIndexBlockKey);
}

- (void)setAlertViewClickedButtonAtIndexBlock:(ZLAlertViewCompleteBlock)alertViewClickedButtonAtIndexBlock {
    if (alertViewClickedButtonAtIndexBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &ZLAlertViewClickedButtonAtIndexBlockKey, alertViewClickedButtonAtIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }

}

- (ZLAlertViewBlock)alertViewCancelBlock{
    return objc_getAssociatedObject(self, &ZLAlertViewCancelBlockKey);
}

- (void)setAlertViewCancelBlock:(ZLAlertViewBlock)alertViewCancelBlock {
    if (alertViewCancelBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &ZLAlertViewCancelBlockKey, alertViewCancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (ZLAlertViewBlock)willPresentAlertViewBlock {
    return objc_getAssociatedObject(self, &ZLWillPresentAlertViewBlockKey);
}

- (void)setWillPresentAlertViewBlock:(ZLAlertViewBlock)willPresentAlertViewBlock {
    if (willPresentAlertViewBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &ZLWillPresentAlertViewBlockKey, willPresentAlertViewBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (ZLAlertViewBlock)didPresentAlertViewBlock {
    return objc_getAssociatedObject(self, &ZLDidPresentAlertViewBlockKey);
}

- (void)setDidPresentAlertViewBlock:(ZLAlertViewBlock)didPresentAlertViewBlock {
    if (didPresentAlertViewBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &ZLDidPresentAlertViewBlockKey, didPresentAlertViewBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (ZLAlertViewCompleteBlock)alertViewWillDismissWithButtonIndexBlock {
    return objc_getAssociatedObject(self, &ZLAlertViewWillDismissWithButtonIndexBlockKey);
}

- (void)setAlertViewWillDismissWithButtonIndexBlock:(ZLAlertViewCompleteBlock)alertViewWillDismissWithButtonIndexBlock {
    if (alertViewWillDismissWithButtonIndexBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &ZLAlertViewWillDismissWithButtonIndexBlockKey, alertViewWillDismissWithButtonIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

-(ZLAlertViewCompleteBlock)alerViewDidDismissWithButtonIndexBlock {
    return objc_getAssociatedObject(self, &ZLAlerViewDidDismissWithButtonIndexBlockKey);
}

- (void)setAlerViewDidDismissWithButtonIndexBlock:(ZLAlertViewCompleteBlock)alerViewDidDismissWithButtonIndexBlock {
    if (alerViewDidDismissWithButtonIndexBlock) {
        [self _useBlock];
    }
}

-(ZLAlertViewBoolBlock)alertViewShouldEnableFirstOtherButtonBlock {
    return objc_getAssociatedObject(self, &ZLAlertViewShouldEnableFirstOtherButtonBlockKey);
}

- (void)setAlertViewShouldEnableFirstOtherButtonBlock:(ZLAlertViewBoolBlock)alertViewShouldEnableFirstOtherButtonBlock {
    if (alertViewShouldEnableFirstOtherButtonBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &ZLAlertViewShouldEnableFirstOtherButtonBlockKey, alertViewShouldEnableFirstOtherButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ZLAlertViewCompleteBlock block = self.alertViewClickedButtonAtIndexBlock;
    if (block) block(alertView, buttonIndex);
    
    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [original alertView:alertView clickedButtonAtIndex:buttonIndex];
    }
}
- (void)alertViewCancel:(UIAlertView *)alertView {
    ZLAlertViewBlock block = self.alertViewCancelBlock;
    if (block) block(alertView);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertViewCancel:)]) {
        [original alertViewCancel:alertView];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    ZLAlertViewBlock block = self.willPresentAlertViewBlock;
    if (block) block(alertView);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(willPresentAlertView:)]) {
        [original willPresentAlertView:alertView];
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    ZLAlertViewBlock block = self.didPresentAlertViewBlock;
    if (block) block(alertView);
    
    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(didPresentAlertView:)]) {
        [original didPresentAlertView:alertView];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    ZLAlertViewCompleteBlock block = self.alertViewWillDismissWithButtonIndexBlock;
    if (block) block(alertView, buttonIndex);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [original alertView:alertView willDismissWithButtonIndex:buttonIndex];
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    ZLAlertViewCompleteBlock block = self.alerViewDidDismissWithButtonIndexBlock;
    if (block) block(alertView, buttonIndex);
    
    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
        [original alertView:alertView didDismissWithButtonIndex:buttonIndex];
    }
}

// Called after edits in any of the default fields added by the style
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    
    ZLAlertViewBoolBlock block = self.alertViewShouldEnableFirstOtherButtonBlock;
    if (block) {
        return block(alertView);
    } else {
        id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &ZLOriginalUIAlertViewDelegateKey);
        if (original && [original respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)]) {
            return [original alertViewShouldEnableFirstOtherButton:alertView];
        }
    }
    return YES;
}

@end