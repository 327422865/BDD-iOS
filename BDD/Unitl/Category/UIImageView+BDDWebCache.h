//
//  UIImageView+BDDWebCache.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/25.
//  Copyright © 2020 宝多多. All rights reserved.
//  封装UIImageView+WebCache


#import <UIKit/UIKit.h>
#import <YYWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (BDDWebCache)

#pragma mark - 传入URL中带域名

/**
 封装了YYWebImage里UIImageView的方法
 SDWebImageOptions默认为: YYWebImageOptionShowNetworkActivity|YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionSetImageWithFadeAnimation
 
 @param urlStr 传入服务器返回的图片地址
 @param placeholder 占位图
 */
- (void)zx_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;


/**
 加载缩略图，会在url后面拼接“-coverthumb”，尺寸400x1000

 @param urlStr 传入服务器返回的图片地址
 @param placeholder 占位图
 */
- (void)zx_setThumbImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;

/**
 头像缩略图，尺寸120x120，会在url后面拼接“-facethumb120”
 
 @param urlStr 传入服务器返回的图片地址
 @param placeholder 占位图
 */
- (void)zx_setFaceThumbImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;

/**
 封装了YYWebImage里UIImageView的方法
 
 @param urlStr 传入服务器返回的图片地址
 @param placeholder 占位图
 @param options 没有默认值，自己设置
 */
- (void)zx_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options;


#pragma mark - 传入URL中不带域名，内部拼接域名

/**
 封装了YYWebImage里UIImageView的方法,内部自动拼接域名
 SDWebImageOptions默认为: YYWebImageOptionShowNetworkActivity|YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionSetImageWithFadeAnimation
 
 @param urlStr 传入服务器返回的图片地址，内部自动拼接域名
 @param placeholder 占位图
 */
- (void)zx_setImageWithNoDomainURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder;

/**
 封装了YYWebImage里UIImageView的方法,内部自动拼接域名
 
 @param urlStr 传入服务器返回的图片地址，内部自动拼接域名
 @param placeholder 占位图
 @param options 没有默认值，自己设置
 */
- (void)zx_setImageWithNoDomainURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options;



@end

NS_ASSUME_NONNULL_END
