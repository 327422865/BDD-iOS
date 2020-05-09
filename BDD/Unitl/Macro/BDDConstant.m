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
NSString * const UserDefaultKeyDeviceToken              = @"UserDefaultKeyDeviceToken";              ///< 推送的deviceToken
NSString * const UserDefaultKeySearchHistory            = @"UserDefaultKeySearchHistory";            ///搜索历史


#pragma mark - 占位图

NSString * const PlaceHolderHomeAD = @"PlaceHolderPoster";                  ///< 首页广告占位图
NSString * const PlaceHolderPoster = @"PlaceHolderPoster";                  ///< 活动海报占位图
NSString * const PlaceHolderPosterNOBackground = @"PlaceHolderPosterNoBackground";///< 活动海报占位图
NSString * const PlaceHolderChatImage = @"PlaceHolderPoster";               ///< 聊天对话中图片占位图
NSString * const PlaceHolderHeader = @"PlaceHolderHeader";                  ///< 用户头像占位图
NSString * const PlaceHolderCoterieHeader = @"PlaceHolderCoterieHeader";    ///< 圈子头像占位图
NSString * const PlaceHolderNews = @"PlaceHolderPoster";                    ///< 话题图片占位图


#pragma mark - 图片比例
double const Poster_Scale = (1.0/2.0);/*160.0/343.0; */     ///< 海报图片高宽比
double const ADCycle_Scale = (141.0/349.0);                 ///< 首页轮播广告位高宽比


@end
