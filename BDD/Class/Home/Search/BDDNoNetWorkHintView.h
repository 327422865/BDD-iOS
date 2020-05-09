//
//  BDDNoNetWorkHintView.h
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
// 无网络提示

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDNoNetWorkHintView : UIView

@property (nonatomic, copy) void(^clickBlock)(void);

@end

NS_ASSUME_NONNULL_END
