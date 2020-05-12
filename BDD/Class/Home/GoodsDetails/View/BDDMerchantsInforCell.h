//
//  BDDMerchantsInforCell.h
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDMerchantsInforCell : UICollectionViewCell

@property (nonatomic, strong) void (^didClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
