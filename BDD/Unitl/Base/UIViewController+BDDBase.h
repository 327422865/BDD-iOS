//
//  UIViewController+BDDBase.h
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BDDBase)

/****************************************************************************/
#pragma mark - ---------------- 返回按钮  -----------------------

///  设置返回按钮，需要在第一个vc里设置
- (void)setupBackButton;
///  设置返回按钮-白色,临时只在当前页面改变为白色，下个页面还是原来的返回按钮
- (void)setupBackButton_White_Tmp;

- (void)BDD_popAction;


/****************************************************************************/
#pragma mark - ---------------- 导航栏右上角按钮  -----------------------

/**
 设置右上角按钮-图片按钮
 
 @param imageName 图片名字
 @param action 方法名，@selector(actionName)
 */
- (void)setupRightButtonWithImageName:(NSString *)imageName action:(SEL)action;

/**
 设置右上角按钮-button
 
 @param title 右上角button的title
 @param action 点击button调用的action
 */
- (void)setupRightButtonWithTitle:(NSString *)title action:(SEL)action;

/**
 设置右上角按钮(多个按钮）-button

 @param imageNames 按钮图片名字数组
 @param actionNames 按钮调用的方法名字符串数组
 */
- (void)setupRightButtonsWithImageNames:(NSArray *)imageNames actionNames:(NSArray *)actionNames;

/**
 设置右上角按钮-自定义View
 
 @param customView 自定义View，可以是button或其他View
 */
- (void)setupRightButtonWithCustomView:(UIView *)customView;

/****************************************************************************/
#pragma mark - ---------------- 导航栏左上角按钮  -----------------------

/**
 设置左上角按钮-button
 
 @param title 右上角button的title
 @param action 点击button调用的action
 */
- (void)setupLeftButtonWithTitle:(NSString *)title action:(SEL)action;

/**
 设置左上角按钮(多按钮）-图片按钮
 
 @param imageNames 按钮图片名字数组
 @param actionNames 按钮调用的方法名字符串数组
 */
- (void)setupLeftButtonsWithImageNames:(NSArray *)imageNames actionNames:(NSArray *)actionNames;

/**
 设置左上角按钮-自定义View
 
 @param customView 自定义View，可以是button或其他View
 */
- (void)setupLeftButtonWithCustomView:(UIView *)customView;

/// 设置左上角选择小区按钮
//- (void)setupLeftChangeCommunityButton:(NSString *)comName;


/****************************************************************************/
#pragma mark - ---------------- 设置导航栏  -----------------------

/** 主题色色的导航栏，首页样式 */
- (void)setNavigationBarBackgroundYellowImage;
/** 主题色背景导航栏，没有黑色阴影线 */
- (void)setNavigationBarBackgroundYellowImageNoShadow;
/** 透明背景的导航栏，白色返回按钮 */
- (void)setNavigationBarNOBackgroundColor;
/** 默认导航栏 */
- (void)setNavigationBarDefault;

/// 导航栏黄色背景渐变层
- (CALayer *)gradientLayer;

- (UIImage *)imageWithView:(UIView *)view;

/****************************************************************************/
#pragma mark - ---------------- 二维码扫描 -----------------------

/// 二维码扫描
- (void)QRScan;

@end

NS_ASSUME_NONNULL_END
