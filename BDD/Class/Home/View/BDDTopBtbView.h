//
//  BDDTopBtbView.h
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDTopBtbView : UIView
//** 图标*/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
//** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@property (nonatomic, copy) NSString *imageStr;

@property (nonatomic, copy) NSString *titleStr;

+ (instancetype)view;

@end

NS_ASSUME_NONNULL_END
