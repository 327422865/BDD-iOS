//
//  UIColor+BDDCategory.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "UIColor+BDDCategory.h"


@implementation UIColor (BDDCategory)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

/**
 获取一个随机色（从固定色库中）
 */
+ (UIColor *)zx_randomColor {
    NSArray *array = @[[UIColor colorWithRed:255/255.0 green:140/255.0 blue:196/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:249/255.0 green:143/255.0 blue:117/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:187/255.0 green:159/255.0 blue:243/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:104/255.0 green:212/255.0 blue:164/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:151/255.0 green:220/255.0 blue:92/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:90/255.0 green:204/255.0 blue:248/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:130/255.0 green:179/255.0 blue:253/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:94/255.0 green:220/255.0 blue:192/255.0 alpha:1/1.0],
                       [UIColor colorWithRed:255/255.0 green:165/255.0 blue:189/255.0 alpha:1/1.0]
                       ];
    NSInteger count = array.count;
    return array[random()%count];
}

@end
