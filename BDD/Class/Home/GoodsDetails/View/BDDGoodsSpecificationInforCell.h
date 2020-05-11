//
//  BDDGoodsSpecificationInforCell.h
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BDDGoodsSpecificationInforCell;
@protocol BDDGoodsSpecificationInforCellDelegate <NSObject>

@optional
/** 点击服务*/
- (void)goodsspecificationInforCellDidClickService;
/** 点击选择套餐*/
- (void)goodsspecificationInforCellDidClickChoosePackage;

@end

@interface BDDGoodsSpecificationInforCell : UICollectionViewCell

@property (nonatomic, weak) id <BDDGoodsSpecificationInforCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
