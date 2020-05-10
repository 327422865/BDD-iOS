//
//  BDDClassifyDetailViewController.h
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//  分类详情（二级）

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDClassifyDetailViewController : UICollectionViewController
/**点击item回调 */
@property (nonatomic, strong) void (^clickItemBlock)(void);
/**二级分类所有数据 */
@property (nonatomic, strong) NSMutableArray * secondMArr;
/**一级分类所有数据 */
@property (nonatomic, strong) NSMutableArray * oneMArr;

@end

NS_ASSUME_NONNULL_END
