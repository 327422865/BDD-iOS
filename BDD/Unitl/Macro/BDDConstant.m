//
//  BDDConstant.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDConstant.h"

@implementation BDDConstant

NSString * const My_AppScheme       = @"yshbz";                             // 本APP的 APP Scheme

#pragma mark - 第三方Key/Secret/AppID
NSString * const BUGLY_APPID        = @"028fa2f0ed";                        // bugly
int        const TIM_APPID          = 1400076035;                           // 腾讯云通信 TIM APP ID
NSString * const Wechat_APPID       = @"wxdc9f013f32195f13";                // 微信 AppID(APP KEY)

#pragma mark - 通知key
NSString * const DidChangeCommunityNotification                 = @"DidChangeCommunityNotification";

#pragma mark - NSUserDefault Key
NSString * const UserDefaultKeyDeviceToken              = @"UserDefaultKeyDeviceToken";                 ///< 推送的deviceToken


@end
