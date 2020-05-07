//
//  BDDMGetDevInfoUtil.h
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/29.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDMGetDevInfoUtil : NSObject

/// <MEID/> 移动终端设备标识码UUID
+ (NSString *)getUUIDCode;

/// <CORPORATION/> 生产厂商/品牌商（即供应商）
+ (NSString *)getCorporation;

/// <MOBILE_TYPE/> 设备类型 eg.iPhone, iPad
+ (NSString *)getDeviceName;

/// <MODEL/> 移动终端型号 eg.iPhone 7, iPhone X
+ (NSString *)getDeviceType;

/// <OS/> 操作系统
+ (NSString *)getSystemVersion;

/// APP版本号
+ (NSString *)getAppVersion;

/// <MAC/> 获取MAC码
+ (NSString *)getMacCode;

/// 获取设备当前网络IP地址(外网ip）
+ (NSString *)getNetworkIPAddress;

/// 获取设备当前本地IP地址（内网ip）
+ (NSString *)getLocalIPAddress:(BOOL)preferIPv4;

/// <IMSI/> IMSI码  私有api appstore申请上线会被拒
/// ！！不要放开注释！！
//+(NSString *)getIMSICode;


@end

NS_ASSUME_NONNULL_END
