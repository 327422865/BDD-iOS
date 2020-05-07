//
//  UIColor+BDDCategory.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define Color666666 HEX_COLOR(@"666666")
#define Color999999 HEX_COLOR(@"999999")
#define ColorF6 HEX_COLOR(@"F6F6F6")    // 页面背景色
#define ColorF1 HEX_COLOR(@"F1F1F1")    // 灰色线条颜色
#define ColorDE HEX_COLOR(@"DEDEDE")    // 灰色线条颜色


///  从十六进制字符串获取颜色
#define HEX_COLOR(hexString) [UIColor colorWithHexString:hexString]
#define HEXA_COLOR(hexString, alphaValue) [UIColor colorWithHexString:hexString alpha:alphaValue]

/*
For example, `UIColorFromRGB(0xFF0000)` creates a `UIColor` object representing the color red.
*/
#ifndef ColorFromHex
#define ColorFromHex(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#endif

/**
 Create a UIColor with an alpha value from a hex value.
 For example, `UIColorFromRGBA(0xFF0000, .5)` creates a `UIColor` object representing a half-transparent red.
 */
#define ColorFromHexA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]


/// 黑色字体主色 #1F242E
#define MAIN_BLACK_COLOR        [UIColor colorWithRed:31/255.0 green:36/255.0 blue:46/255.0 alpha:1/1.0]
/// 主题色
#define THEME_COLOR             HEX_COLOR(@"FF9C00")


@interface UIColor (BDDCategory)

+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 从十六进制字符串获取颜色

 @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param alpha 透明度
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 获取一个随机色（从固定色库中）
 */
+ (UIColor *)zx_randomColor;


@end

NS_ASSUME_NONNULL_END
