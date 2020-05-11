//
//  BDDMerchantsInforCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDMerchantsInforCell.h"


@interface BDDMerchantsInforCell ()
/**图标*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
/**主标题*/
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLab;
/**子标题*/
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
/**商品数量*/
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberLab;

@end

@implementation BDDMerchantsInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
    
    self.iconImageV.layer.cornerRadius = 20;
    self.iconImageV.clipsToBounds = YES;
}

@end
