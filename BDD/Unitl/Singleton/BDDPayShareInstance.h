//
//  BDDPayShareInstance.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/30.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AliPayResultType){
    AliPayResultTypeSuccess  = 0,       ///支付成功
    AliPayResultTypeCheck,              ///需要后台查询支付结果
    AliPayResultTypeError               ///支付失败
};

typedef void (^WxPayResult)(int errCode, NSString *errStr);
typedef void (^AliPayResult)(AliPayResultType resultType, NSString *tipStr, NSString *resultJsonStr);

@interface BDDPayShareInstance : NSObject<WXApiDelegate>

+ (instancetype)sharedInstance;

/// 第三方支付APP支付完成后回到本APP的回调，处理支付结果
/// @param url 第三方支付APP打开本app的回调url
- (BOOL)handleOpeURL:(NSURL *)url;

#pragma mark -- 支付宝支付
@property (nonatomic, copy) AliPayResult  AliPayResult;
- (void)payWithAliPay:(NSString *)orderString AliPayResult:(AliPayResult)AliPayResult;

#pragma mark -- 微信支付
@property (nonatomic, copy) WxPayResult  WxPayResult;

/// 微信支付必须在入口类里注册
- (void)RegisterWXPay;
- (void)payWithWxPay:(NSDictionary *)orderDic WxPayResult:(WxPayResult)WxPayResult;


@end

NS_ASSUME_NONNULL_END
