//
//  BDDConstant.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDConstant : NSObject

extern NSString * const My_AppScheme;        ///< 本APP的 APP Scheme

#pragma mark - 第三方Key/Secret/AppID
extern NSString * const BUGLY_APPID;        ///< bugly APP ID
extern int        const TIM_APPID;          ///< 腾讯云通信 TIM APP ID
extern NSString * const Wechat_APPID;       ///< 微信 APP KEY

#pragma mark - 通知key
extern NSString * const DidChangeCommunityNotification;                     ///< 改变浏览小区或改绑小区

#pragma mark - NSUserDefault Key
extern NSString * const UserDefaultKeyDeviceToken;                      ///< 推送的deviceToken

@end

NS_ASSUME_NONNULL_END
