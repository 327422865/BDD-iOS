//
//  BDDTopBtbView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDTopBtbView.h"

@implementation BDDTopBtbView

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)view
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)setImageStr:(NSString *)imageStr{
    self.iconView.image = [UIImage imageNamed:imageStr];
}

- (void)setTitleStr:(NSString *)titleStr {
    self.titleLab.text = titleStr;
}

@end
