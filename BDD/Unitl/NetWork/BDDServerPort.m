//
//  BDDServerPort.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDServerPort.h"

@implementation BDDServerPort

/**
 只有打debug包才能用预发布环境，只有release包才能用正式环境
*/
/// 发布环境的域名
NSString * const PRODUCTION_SERVER_URL = @"https://app.comapp.fun";
/// 预发布环境
NSString * const PRE_PRODUCTION_SERVER_URL = @"https://app.comapp.fun";
/// 开发环境
NSString * const DEVELOPMENT_SERVER_URL = @"https://api.comapp.fun";

#ifdef DEBUG
//NSString * BASE_SERVER_URL = @"http://192.168.3.109:8080";// 阳朋袀电脑
NSString *BASE_SERVER_URL = DEVELOPMENT_SERVER_URL; // 测试服务器
//NSString *BASE_SERVER_URL = PRE_PRODUCTION_SERVER_URL; // 预发布服务器
#else
NSString * const BASE_SERVER_URL = PRODUCTION_SERVER_URL;
#endif


@end
