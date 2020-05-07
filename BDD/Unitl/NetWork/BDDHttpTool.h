//
//  BDDHttpTool.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDDServerPort.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDHttpTool : NSObject

/**
 post网络请求(成功、失败都没有提示框)
 已封装code=-401被踢下线提示
 
 @param URLString URL地址
 @param parameters 参数
 @param successBlock 成功回调Block
 @param failureBlock 失败回调Block, 已封装失败提示框
 */
+ (void)POST:(NSString * _Nonnull)URLString
  parameters:(id _Nullable)parameters
     success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
     failure:(void (^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;

+ (void)GET:(NSString * _Nonnull)URLString
 parameters:(id _Nullable)parameters
    success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
    failure:(void (^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;



#pragma mark - 判断是否有网络
+ (BOOL)isHasNetwork;

+ (BOOL)isWiFi;

/// 设备UUID
+ (NSString *)getUUID;

@end

NS_ASSUME_NONNULL_END
