//
//  UIView+MBPHUD.h
//  HBGovSwift
//
//  Created by 余汪送 on 2017/12/11.
//  Copyright © 2017年 capsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger, MBPHUDProgressStyle) {
    MBPHUDProgressStyleNormal,
    MBPHUDProgressStyleBar,
    MBPHUDProgressStyleAnnular
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MBPHUD)

@property (weak, nonatomic) MBProgressHUD *HUD;

/// 菊花HUD（需要手动隐藏）
- (void)showHUD;
/// 菊花HUD+文字
- (void)showHUDWithMessage:(nullable NSString *)message;
/// toast提示
- (void)showHUDToast:(NSString *)message;
/// 成功提示
- (void)showHUDSuccess;
- (void)showHUDSuccessWithMessage:(nullable NSString *)message;
/// 失败提示
- (void)showHUDErrorWithMessage:(nullable NSString *)message;
/// 无网络提示
- (void)showHUDNoNetwork;
- (void)showHUDNoNetworkWithMessage:(nullable NSString *)message;

/// 带图片的提示，会自动隐藏
- (void)showHUDWithImage:(UIImage *)image;
- (void)showHUDWithImage:(UIImage *)image message:(nullable NSString *)message;

/// 圆圈形进度条
- (void)showHUDProgressHUD;
- (void)showHUDProgressWithMessage:(nullable NSString *)message;
- (void)showHUDProgressWithMessage:(nullable NSString *)message style:(MBPHUDProgressStyle)style;
- (void)updateHUDProgress:(CGFloat)progress;

- (void)hideHUD;
- (void)hideHUDCompletion:(nullable void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END

