//
//  BDDEmptyView.h
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "LYEmptyView.h"
#import <LYEmptyViewHeader.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EmptyImageType) {
    EmptyImageTypeNone,         ///< 不显示图片
    EmptyImageTypeNoSearchCom,  ///< 没有搜索到小区
    EmptyImageTypeNoPublish,    ///< 没有发布内容
    EmptyImageTypeNoCoterie,    ///< 没有关联圈子
    EmptyImageTypeNoMessage,    ///< 没有消息/评论
    EmptyImageTypeNoNeighbor,   ///< 没有邻居
    EmptyImageTypeNoFriend,     ///< 没有好友、没有搜索到用户
    EmptyImageTypeNoNetwork,    ///< 没有网络
    EmptyImageTypeNoImpression, ///< 没有印象
};

@interface BDDEmptyView : LYEmptyView

/// 无网络，会自动显示
/// @warning 注意循环引用
+ (instancetype)diyNoNetworkEmptyWithBtnClickBlock:(LYActionTapBlock)btnClickBlock;

/**
 构造方法2 - 创建emptyView,不会自动显示
 
 @warning 注意循环引用
 @param imageType      占位图片类型
 @param titleStr       占位描述
 @param detailStr      详细描述
 @param btnTitleStr    按钮的名称
 @param btnClickBlock  按钮点击事件回调
 @return 返回一个emptyView
 */
+ (instancetype)diyEmptyActionViewWithImageType:(EmptyImageType)imageType
                                   titleStr:(NSString *)titleStr
                                  detailStr:(NSString *)detailStr
                                btnTitleStr:(NSString *)btnTitleStr
                              btnClickBlock:(LYActionTapBlock)btnClickBlock;


/**
 构造方法3 - 创建emptyView,不会自动显示
 
 @warning 注意循环引用
 @param imageType     占位图片类型
 @param titleStr      占位描述
 @param detailStr     详细描述
 @return 返回一个没有点击事件的emptyView
 */
+ (instancetype)diyEmptyViewWithImageType:(EmptyImageType)imageType
                             titleStr:(NSString *)titleStr
                            detailStr:(NSString *)detailStr;


@end

NS_ASSUME_NONNULL_END
