//
//  BDDLinkTool.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/29.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define App_Scheme          @"banzhu"       // h5中的操作特殊URL，和斑猪的scheme不同
#define App_Host_Pop        @"back"         // pop回上一页
#define App_Host_Usercard   @"usercard"     // 用户名片
#define App_Host_Coterie    @"coterie"      // 圈子二维码，进圈子主页



@interface BDDLinkTool : NSObject


// 根据广告链接或图片链接获取链接中的参数
+ (NSDictionary *)paramFromUrl:(NSString *)url;

/**
 根据带站内跳转链接的图片的URL跳转VC

 @param url 图片的URL
 @return NO：普通的图片链接或特殊链接格式错误，不跳转；YES：是自定义的URL，自动进行跳转到响应的vc页面
 */
+ (BOOL)handleImageUrl:(NSString *)url;


/**
 处理超链接
 * 如果是自定义的链接，跳转的到相应的页面
 * 如果是普通的URL链接，push到新的页面打开webView
 * 如果是电话或邮箱，则拨打电话或打开邮箱
 * 如果是跳转App Store的链接，除了自己的APP，其他的都被屏蔽（return NO)
 
 @param url 超链接
 @return YES：继续处理决定是否需要跳转；NO：拦截URL跳转
 */
+ (BOOL)handleHyperlink:(NSString *)url;

/**
 判断是否继续处理超链接
 * 如果是自定义的链接，跳转的到相应的页面
 * 如果是普通的URL链接，打开webView
 * 如果是电话或邮箱，则拨打电话或打开邮箱
 * 如果是跳转App Store的链接，除了自己的APP，其他的都被屏蔽（return NO)
 
 @param url 超链接
 @param isOpenNewWebView 如果是普通URL的话是否push到新的webView页面
 @return YES：继续处理决定是否需要跳转；NO：拦截URL跳转
 */
+ (BOOL)handleHyperlink:(NSString *)url openNewWebView:(BOOL)isOpenNewWebView;

/**
 处理扫描二维码的结果

 @param result 二维码中的字符串
 */
+ (void)handleQRCodeResult:(NSString *)result;

/**
 处理APP推送数据
 
 @param userInfo 推送带的自定义字段
 */
+ (void)handleRemoteNotificationWithUserInfo:(NSDictionary *)userInfo;



@end

NS_ASSUME_NONNULL_END
