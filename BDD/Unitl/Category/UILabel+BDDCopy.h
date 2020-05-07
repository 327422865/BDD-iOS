//
//  UILabel+BDDCopy.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/25.
//  Copyright © 2020 宝多多. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <YYLabel.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (BDDCopy)

@property (nonatomic,assign) BOOL isCopyable;

@end

@interface YYLabel (BDDCopy)

@property (nonatomic,assign) BOOL isCopyable;

@end

NS_ASSUME_NONNULL_END
