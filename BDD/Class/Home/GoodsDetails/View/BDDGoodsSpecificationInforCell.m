//
//  BDDGoodsSpecificationInforCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoodsSpecificationInforCell.h"
#import "BDDGoodsSizeAlertView.h"
#import "BDDGoodsServiceAlertView.h"


@interface BDDGoodsSpecificationInforCell ()
/**服务View*/
@property (weak, nonatomic) IBOutlet UIView *serviceView;
/**规格View*/
@property (weak, nonatomic) IBOutlet UIView *specificationView;

@end


@implementation BDDGoodsSpecificationInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tapService = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceAction)];
    UITapGestureRecognizer *tapSpecification = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(specificationAction)];
    [self.serviceView addGestureRecognizer:tapService];
    [self.specificationView addGestureRecognizer:tapSpecification];
}

- (void)serviceAction {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsspecificationInforCellDidClickService)]) {
//        [self.delegate goodsspecificationInforCellDidClickService];
//    }
    
    
    [BDDGoodsServiceAlertView show];
    
    
}

- (void)specificationAction {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsspecificationInforCellDidClickChoosePackage)]) {
//        [self.delegate goodsspecificationInforCellDidClickChoosePackage];
//    }
    
    BDDGoodsSizeAlertView *view= [BDDGoodsSizeAlertView view];
    [view show];
}


@end
