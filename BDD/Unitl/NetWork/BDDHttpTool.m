//
//  BDDHttpTool.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDHttpTool.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "BDDHUD.h"
#import <FCUUID.h>


@interface BDDHttpTool ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BDDHttpTool

+ (AFHTTPSessionManager *)manager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", @"application/x-www-form-urlencoded", nil];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    // 设置请求头
    //    [manager.requestSerializer setValue:[self headerFieldValueStr] forHTTPHeaderField:@"Authorization"];
    //    [manager.requestSerializer setValue:[UserInfoManager shareInstance].httpHeaderVersionStr forHTTPHeaderField:@"version"];
    //    [manager.requestSerializer setValue:[self bzUUID] forHTTPHeaderField:@"device_id"];// 设备识别码，iOS是UUID，安卓是IMEI
#ifdef DEBUG
    // 只有打debug包才能用预发布环境，只有release包才能用正式环境
    //    if ([BASE_SERVER_URL isEqualToString:PRE_PRODUCTION_SERVER_URL]) {
    //        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"X_COMAPP_PRODUCTION"];// 测试环境不传，预发布环境传0，正式环境传1
    //    }
#else
    //    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X_COMAPP_PRODUCTION"];// 测试环境不传，预发布环境传0，正式环境传1
#endif
    
    return manager;
}


+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))successBlock failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failureBlock{
    [[self manager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (ISEMPTYSTR(URLString)) {
            [BDDHUD dismissProgress];
            return;
        }
        if (successBlock) {
            successBlock(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"！！！POST请求接口出错了！！！--:%@--error:%@", URLString, error);
        if (failureBlock) {
            failureBlock(task, error);
        }
        
    }];
}


+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))successBlock failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failureBlock{
    [[self manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (ISEMPTYSTR(URLString)) {
            [BDDHUD dismissProgress];
            return;
        }
        
        if (successBlock) {
            successBlock(task, responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"！！！GET请求接口出错了！！！--:%@--error:%@", URLString, error);
        if (failureBlock) {
            failureBlock(task, error);
        }

    }];
}

/// 设备UUID
+ (NSString *)getUUID {
    static NSString * bzUUID;
    if (!bzUUID) {
        bzUUID = [FCUUID uuidForDevice];
        DLog(@"UUID:%@", bzUUID);
    }
    return bzUUID;
}


/// 判断是否有网络
+ (BOOL)isHasNetwork {
    AFNetworkReachabilityStatus statue = [self currentNetworkStatus];
    //无连接或未知错误返回NO
    if (statue == AFNetworkReachabilityStatusUnknown || statue == AFNetworkReachabilityStatusNotReachable) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)isWiFi {
    AFNetworkReachabilityStatus statue = [self currentNetworkStatus];
    return statue == AFNetworkReachabilityStatusReachableViaWiFi;
}

+ (AFNetworkReachabilityStatus)currentNetworkStatus{
    static AFNetworkReachabilityStatus currentNetworkStatus = AFNetworkReachabilityStatusUnknown;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        /*
         AFNetworkReachabilityStatusUnknown          = -1,  // 未知
         AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
         AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 移动网络
         AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
         */
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            currentNetworkStatus = status;
        }];
    });
    return currentNetworkStatus;
}


@end
