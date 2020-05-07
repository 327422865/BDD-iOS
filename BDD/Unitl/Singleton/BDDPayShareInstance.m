//
//  BDDPayShareInstance.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/30.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDPayShareInstance.h"

@implementation BDDPayShareInstance

+ (instancetype)sharedInstance {
    static BDDPayShareInstance *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [BDDPayShareInstance new];
    });
    
    return instance;
}



- (BOOL)handleOpeURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {//支付宝客户端支付
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            DLog(@"支付宝客户端支付 result = %@",resultDic);
            [self handleAliPayResulr:resultDic];
        }];
        return YES;
    }
    
    //    if ([url.host isEqualToString:@"platformapi"]) { //支付宝钱包快登授权返回 authCode   ???
    //        //跳转支付宝钱包进行支付，处理支付结果
    //        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    //            DLog(@"支付宝钱包快登授权返回 authCode result = %@",resultDic);
    //            [self handleAliPayResulr:resultDic];
    //        }];
    //        return YES;
    //    }
    
    if ([url.host isEqualToString:@"pay"]) {//微信支付
        return [WXApi handleOpenURL:url delegate:[BDDPayShareInstance sharedInstance]];
    }
    return NO;
}

#pragma mark - 支付宝支付
- (void)payWithAliPay:(NSString *)orderString AliPayResult:(AliPayResult)AliPayResult {
    [BDDPayShareInstance sharedInstance].AliPayResult = AliPayResult;
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:My_AppScheme callback:^(NSDictionary *resultDic) {
        DLog(@"ALiPay reslut = %@",resultDic);
        [self handleAliPayResulr:resultDic];
    }];
}

- (void)handleAliPayResulr:(NSDictionary *)resultDic {
    NSString * resultJsonStr = resultDic[@"result"];
    NSString * memo = resultDic[@"memo"];
    NSInteger resultValue = [resultDic[@"resultStatus"] integerValue];
    AliPayResultType resultType;
    switch (resultValue)
    {
        case 9000:
            memo = @"支付成功";
            resultType = AliPayResultTypeSuccess;
            break;
            
        case 8000:// 正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            memo = @"正在处理中，等待商家确认";
            resultType = AliPayResultTypeCheck;
            break;
            
        case 4000:
            memo = @"订单支付失败";
            resultType = AliPayResultTypeError;
            break;
            
        case 6001:
            memo = @"取消支付";
            resultType = AliPayResultTypeError;
            break;
            
        case 6002:
            memo = @"网络连接出错";
            resultType = AliPayResultTypeError;
            break;
            
        case 6004:// 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
            memo = @"正在处理中，等待商家确认";
            resultType = AliPayResultTypeCheck;
            break;
            
        default:
            memo = @"支付失败";
            resultType = AliPayResultTypeError;
            break;
    }
    if (self.AliPayResult) {
        self.AliPayResult(resultType,memo,resultJsonStr);
    }
}

#pragma mark - 微信支付
- (void)RegisterWXPay {
    [WXApi registerApp:Wechat_APPID universalLink:@""];
}

- (void)payWithWxPay:(NSDictionary *)orderDic WxPayResult:(WxPayResult)WxPayResult {
    [BDDPayShareInstance sharedInstance].WxPayResult = WxPayResult;
    PayReq *request = [[PayReq alloc] init];
    request.partnerId       = orderDic[@"partnerid"];
    request.prepayId        = orderDic[@"prepayid"];
    request.package         = orderDic[@"package"];
    request.nonceStr        = orderDic[@"noncestr"];
    NSString *timeStampStr  = orderDic[@"timestamp"];
    request.timeStamp       = (UInt32)timeStampStr.longLongValue;
    request.sign            = orderDic[@"sign"];
    [WXApi sendReq:request completion:^(BOOL success) {
        
    }];
}

@end
