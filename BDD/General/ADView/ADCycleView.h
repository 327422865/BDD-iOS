//
//  ADCycleView.h
//  Community
//
//  Created by ZX on 2018/10/23.
//  Copyright © 2018 映山红. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ADViewDirection) {
    ADViewDirection_AddGoods,   ///< 添加商品页面
    ADViewDirection_Community,  ///< 社区列表首页（新版）
    ADViewDirection_My,         ///< 我的页面
    ADViewDirection_Home,       ///< 首页推荐页面
};

/**
 通用广告位view
 */
@interface ADCycleView : UIView

/// 广告数据数组
@property (nonatomic, strong) NSArray *ADDataArray;

@property (nonatomic, assign) CGFloat adViewHeight;


/// 广告位边距，默认{15,16,0,16}
- (instancetype)initWithADViewDirection:(ADViewDirection)direction;
- (instancetype)initWithEdgeInsets:(UIEdgeInsets)edgeInsets ADViewDirection:(ADViewDirection)direction;

/** 解决viewWillAppear时出现时轮播图卡在一半的问题，在控制器viewWillAppear时调用此方法 */
- (void)adjustWhenControllerViewWillAppera;

@end

NS_ASSUME_NONNULL_END
