//
//  BDDShopHomeCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/12.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDShopHomeCell.h"

@implementation BDDShopHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
}

@end
