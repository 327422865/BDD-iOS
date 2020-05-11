//
//  BDDGoodsSpecificationInforCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoodsSpecificationInforCell.h"


@interface BDDGoodsSpecificationInforCell ()
/**运费View*/
@property (weak, nonatomic) IBOutlet UIView *freightView;
/**规格View*/
@property (weak, nonatomic) IBOutlet UIView *specificationView;

@end


@implementation BDDGoodsSpecificationInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
}



@end
