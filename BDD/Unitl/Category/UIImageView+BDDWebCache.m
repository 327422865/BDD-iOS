//
//  UIImageView+BDDWebCache.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/25.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "UIImageView+BDDWebCache.h"



@implementation UIImageView (BDDWebCache)

#pragma mark - 传入URL中带域名

- (void)zx_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder {
    if (ISEMPTYSTR(urlStr)) {
        self.image = placeholder;
        return;
    }
    [self zx_setImageWithURL:urlStr placeholderImage:placeholder options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)zx_setThumbImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder {
    if (ISEMPTYSTR(urlStr)) {
        self.image = placeholder;
        return;
    }
//    NSURL *url = urlStr.mj_url;
//    if ([url.host isEqualToString:@"image.comapp.fun"]) {
//        // 七牛上的图片资源
//        urlStr = GetThumbImageUrlStr(urlStr);
//    }
    [self zx_setImageWithURL:urlStr placeholderImage:placeholder options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)zx_setFaceThumbImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder {
    if (ISEMPTYSTR(urlStr)) {
        self.image = placeholder;
        return;
    }
    NSURL *url = urlStr.mj_url;
    if ([url.host isEqualToString:@"image.comapp.fun"]) {
        // 七牛上的图片资源
//        urlStr = GetFaceThumbImageUrlStr(urlStr);
    }
    [self zx_setImageWithURL:urlStr placeholderImage:placeholder options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)zx_setImageWithURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options {
    if (ISEMPTYSTR(urlStr)) {
        self.image = placeholder;
        return;
    }
    [self yy_setImageWithURL:[NSURL URLWithString:urlStr] placeholder:placeholder options:options completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (error) {
            DLog(@"加载图片失败：%@", error);
        }
    }];
}

#pragma mark - 传入URL中不带域名，内部拼接域名

- (void)zx_setImageWithNoDomainURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder {
    if (ISEMPTYSTR(urlStr)) {
        self.image = placeholder;
        return;
    }
    [self zx_setImageWithNoDomainURL:urlStr placeholderImage:placeholder options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)zx_setImageWithNoDomainURL:(NSString *)urlStr placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options {
    if (ISEMPTYSTR(urlStr)) {
        self.image = placeholder;
        return;
    }
    if (!ISEMPTYSTR(urlStr)) {
        urlStr = [BASE_SERVER_URL stringByAppendingPathComponent:urlStr];
    }
    [self yy_setImageWithURL:[NSURL URLWithString:urlStr] placeholder:placeholder options:options completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (error) {
            DLog(@"加载图片失败：%@", error);
        }
    }];}

@end

