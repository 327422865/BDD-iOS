//
//  BDDHUD.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDHUD : NSObject
/**
 *  set Style
 */
#pragma mark - set theme style

+ (void)setHUDDefaultStyle;

#pragma mark - toast

+ (void)showToastMessage:(NSString *)toastMessage;

+ (void)dismissToast;

#pragma mark - progress
// DEPRECATED_MSG_ATTRIBUTE("请使用UIView+MBPHUD或UIViewController+MBPHUD中的showHUDProgressWithMessage:方法")
+ (void)showProgressWithMessage:(NSString *)message;

+ (void)showProgressWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable;

#pragma mark - info

+ (void)showInfoWithMessage:(NSString *)message;

+ (void)showInfoWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable;

#pragma mark - success

+ (void)showSuccessWithMessage:(NSString *)message;

+ (void)showSuccessWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable;

#pragma mark - error

+ (void)showErrorWithMessage:(NSString *)message;

+ (void)showErrorWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable;


#pragma mark - dismiss

+ (void)dismissProgress;

+ (void)dismissAll;

+ (void)dismissWithCompletion:(void(^)(void))completion;

#pragma mark - 无网络提示

/**
 提示：网络无法连接,带图片
 */
+ (void)showNoNetwork;

+ (void)showNoNetworkWithMessage:(NSString *)message;


@end

NS_ASSUME_NONNULL_END
