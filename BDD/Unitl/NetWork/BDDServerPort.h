//
//  BDDServerPort.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//  接口

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDServerPort : NSObject

#ifdef DEBUG
extern NSString *BASE_SERVER_URL;                   ///< 域名
#else
extern NSString * const BASE_SERVER_URL;            ///< 域名
#endif


extern NSString * const PRODUCTION_SERVER_URL;      ///< 发布环境域名
extern NSString * const DEVELOPMENT_SERVER_URL;     ///< 开发环境域名
extern NSString * const PRE_PRODUCTION_SERVER_URL;  ///< 预发布环境域名

#pragma mark - ---------------- 登录,注册 -----------------------
/// 登录
#define login_Url [BASE_SERVER_URL stringByAppendingString:@"/comapp/webapi/usercontrol/login"]

#pragma mark - ---------------- 首页 -----------------------
/// 获取首页列表
#define getHomeList_Url [BASE_SERVER_URL stringByAppendingString:@"/comapp/webapi/index/list"]



@end

NS_ASSUME_NONNULL_END
