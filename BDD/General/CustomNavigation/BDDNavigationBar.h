//
//  BDDNavigationBar.h
//  BDD
//
//  Created by 彭英科 on 2020/5/12.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BDDNavigationBarType) {
    BDDNavigationBarType_Normal,         ///< 默认样式，导航栏状态栏白色
    BDDNavigationBarType_Corner,         ///< 状态栏背景黑色，导航栏白色
    BDDNavigationBarType_ClearBackgroud, ///< 导航栏状态栏透明背景色
};

@interface BDDNavigationBar : UIView

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BDDNavigationBarType navigationType;

/**

 @param leftBtns 默认Lbtn1是返回按钮，需在自己实现action方法，Lbtn2默认隐藏
 @param rightBtns 实现rightBtns默认Rbtn1显示，Rbtn2隐藏
 @brief 所有按钮默认font=13，按钮调用方法需要自己实现
 */
- (instancetype)initWithFrame:(CGRect)frame leftBtns:(void( ^ _Nullable )(UIButton *Lbtn1, UIButton *Lbtn2))leftBtns rightBtns:(void( ^ _Nullable )(UIButton *Rbtn1, UIButton *Rbtn2))rightBtns;

@end

NS_ASSUME_NONNULL_END
