//
//  BDDHomeCollectionCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/7.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDHomeCollectionCell.h"

@implementation BDDHomeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
    
}

@end
