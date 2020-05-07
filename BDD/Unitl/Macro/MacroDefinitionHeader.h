//
//  MacroDefinitionHeader.h
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#ifndef MacroDefinitionHeader_h
#define MacroDefinitionHeader_h

//  开关NSLog
#ifdef DEBUG // 处于开发阶段
#define DLog(FORMAT,...) NSLog((@"%s:%d ->" FORMAT), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)//输出方法名、行数
#else // 处于发布阶段
#define DLog(...)
#endif

// 设置rootVC
#define SET_ROOT_VC(vc) [UIApplication sharedApplication].delegate.window.rootViewController = vc

/// 替换id属性为ID
#define REPLACE_id_TO_ID + (NSDictionary *)mj_replacedKeyFromPropertyName {\
return @{@"ID": @"id"};\
}\

// 打电话
#define CALLPHONE(phonenum)\
NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", phonenum]];\
if ([[UIApplication sharedApplication] canOpenURL:url]) {\
    [[UIApplication sharedApplication] openURL:url];\
}\

// 关闭dispatch定时器
#define DISPATCH_SOURCE_CANCEL_SAFE(time) if(time)\
{\
dispatch_source_cancel(time);\
time = nil;\
}

//  设置颜色
#define RGBA_COLOR(R, G, B, A)  [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B)      [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

//  空值判断
#define IS_EMPTY_STR(str)        ((str == nil) || (str == NULL) || ([str isEqual:[NSNull null]]) || ([str isKindOfClass:[NSNull class]]) || ([str isEqualToString:@""]) || ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0))
#define ISEMPTYSTR(str)     IS_EMPTY_STR(str)

// 获取Document路径
#define Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/****************************************************************************/
#pragma mark - ---------------- 手机系统/尺寸相关 -----------------------

//  适配字体，标准为iPhone6的尺寸
#define FOUNT_SIZE(size)  (iPhone6_Size ? size : (iPhone6p ? size + floor(size / 10) : size - floor(size / 10)))

//  需要横屏或者竖屏，获取屏幕宽度与高度
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define SCREEN_WIDTH    ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE     ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE     [UIScreen mainScreen].bounds.size
#endif

//  状态栏、导航栏、TabBar的尺寸
#define STATUSBAR_HEIGHT        (iPhone_FaceID ? 44.0 : 20.0)
#define NAVIGATIONBAR_HEIGHT    (iPhone_FaceID ? 88.0 : 64.0)
#define TABBAR_HEHGHT           (iPhone_FaceID ? 83.0 : 49.0)
#define HOMEINDICATOR_HEIGHT    (iPhone_FaceID ? 34.0 : 0.0)

//  获取系统版本
#define IOS_SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
//  判断系统 8,9,10,11(整数)
#define IS_IOS(version)     ([[[UIDevice currentDevice] systemVersion] intValue] == version)

//  判断iPhone设备、型号
//判断是否为iPhone
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD     ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为iPhone 4/4s
#define iPhone4_Size        ([[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 480.0f)
// 判断是否为 iPhone 5/5s/SE
#define iPhone5_Size        ([[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f)
// 判断是否为iPhone 6/6s/7/8
#define iPhone6_Size        ([[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f)
// 判断是否为iPhone 6Plus/6sPlus/7P/8P
#define iPhone6Plus_Size    ([[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f)
// 判断是否为iPhone X/XS
#define iPhoneX_Size        ([[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 812.0f)
// 判断是否为iPhone XR/XS Max
#define iPhoneXR_XSMax_Size ([[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 896.0f)
// 是否是刘海儿全面屏
#define iPhone_FaceID       (iPhoneX_Size || iPhoneXR_XSMax_Size)

/****************************************************************************/
#pragma mark - ---------------- 解决循环引用 -----------------------

// 解决循环引用  用法：weakify(self) strongify(self)
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##_##object;
#else
#define strongify(object) __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##_##object;
#else
#define strongify(object) __typeof__(object) object = block##_##object;
#endif
#endif
#endif




#endif /* MacroDefinitionHeader_h */
