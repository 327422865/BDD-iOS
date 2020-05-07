//
//  UIButton+BDDTouchArea.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/25.
//  Copyright © 2020 宝多多. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BDDTouchArea)
/**
 *  @brief  设置按钮额外热区
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

@end

NS_ASSUME_NONNULL_END
