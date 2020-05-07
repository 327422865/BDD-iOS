//
//  BDDHUD.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDHUD.h"
#import <SVProgressHUD.h>

#define InfoImage       [UIImage imageNamed:@""]
#define ErrorImage      [UIImage imageNamed:@"caozuoshibai"]
#define SuccessImage    [UIImage imageNamed:@"caozuochenggong"]
#define NoNetImage      [UIImage imageNamed:@"wangluoyichang"]

static NSInteger const maxTipCount = 50;

@implementation BDDHUD


#pragma mark - set theme style

+ (void)setHUDDefaultStyle {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setSuccessImage:SuccessImage];
    [SVProgressHUD setErrorImage:ErrorImage];
    [SVProgressHUD setInfoImage:InfoImage];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
    [SVProgressHUD setMinimumSize:CGSizeMake(90, 36)];
    [SVProgressHUD setCornerRadius:3];
}

/****************************************************************************/
#pragma mark - ---------------- Toast -----------------------

+ (void)showToastMessage:(NSString *)toastMessage {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[self cutMessage:toastMessage]];
}
+ (void)dismissToast {
    [SVProgressHUD dismiss];
}


/****************************************************************************/
#pragma mark - ---------------- progress -----------------------

+ (void)showProgressWithMessage:(NSString *)message {
    [BDDHUD showProgressWithMessage:message userInteractionEnable:NO];
}
+ (void)showProgressWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable {
    if (userInteractionEnable) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    [SVProgressHUD showWithStatus:[self cutMessage:message]];
}

/****************************************************************************/
#pragma mark - ---------------- info -----------------------

+ (void)showInfoWithMessage:(NSString *)message {
    [BDDHUD showInfoWithMessage:message userInteractionEnable:YES];
}
+ (void)showInfoWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable {
    if (userInteractionEnable) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    [SVProgressHUD showInfoWithStatus:[self cutMessage:message]];
}

/****************************************************************************/
#pragma mark - ---------------- success -----------------------

+ (void)showSuccessWithMessage:(NSString *)message {
    [BDDHUD showSuccessWithMessage:message userInteractionEnable:YES];
}
+ (void)showSuccessWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable {
    if (userInteractionEnable) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    [SVProgressHUD showSuccessWithStatus:[self cutMessage:message]];
}


/****************************************************************************/
#pragma mark - ---------------- error -----------------------

+ (void)showErrorWithMessage:(NSString *)message {
    [BDDHUD showErrorWithMessage:message userInteractionEnable:YES];
}
+ (void)showErrorWithMessage:(NSString *)message userInteractionEnable:(BOOL)userInteractionEnable {
    if (userInteractionEnable) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    [SVProgressHUD showErrorWithStatus:[self cutMessage:message]];
}


/****************************************************************************/
#pragma mark - ---------------- dismiss -----------------------

+ (void)dismissProgress {
    [SVProgressHUD dismiss];
}

+ (void)dismissAll {
    [SVProgressHUD popActivity];
}

+ (void)dismissWithCompletion:(void(^)(void))completion {
    [SVProgressHUD dismissWithCompletion:completion];
}

#pragma mark - 无网络提示

+ (void)showNoNetwork {
    [SVProgressHUD showImage:NoNetImage status:@"你的手机网络异常，请稍后再试"];
}
+ (void)showNoNetworkWithMessage:(NSString *)message {
    [SVProgressHUD showImage:NoNetImage status:[self cutMessage:message]];
}


#pragma mark - 私有方法

+ (NSString *)cutMessage:(NSString *)message {
    if (message.length <= maxTipCount) {
        return message;
    }
    return [message substringToIndex:maxTipCount];
}


@end
