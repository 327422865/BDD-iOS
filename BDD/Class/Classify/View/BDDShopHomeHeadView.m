//
//  BDDShopHomeHeadView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/12.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDShopHomeHeadView.h"

@interface BDDShopHomeHeadView ()
//* 顶部图片 */
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
//* 店铺图片 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImageV;
//* 店铺名 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
//* 店铺龄 */
@property (weak, nonatomic) IBOutlet UILabel *shopAgeLab;
//* 商品数 */
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberLab;
//* 简介 */
@property (weak, nonatomic) IBOutlet UILabel *IntroductionLab;
//* 显示全部简介 */
@property (weak, nonatomic) IBOutlet UIButton *showAllBtn;
//* 全部商品数 */
@property (weak, nonatomic) IBOutlet UILabel *allGoodsNumberLab;

@property (weak, nonatomic) IBOutlet UILabel *topMarkLab;

//* 顶部图片高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageBackV_LC_height;
@end

@implementation BDDShopHomeHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = HEX_COLOR(@"");
    
    self.shopImageV.layer.cornerRadius = 25;
    self.shopImageV.clipsToBounds = YES;
    
    self.topImageBackV_LC_height.constant = SCREEN_WIDTH * 2/3;
    self.topMarkLab.backgroundColor = [HEX_COLOR(@"#000000") colorWithAlphaComponent:0.5];
    self.topMarkLab.layer.cornerRadius = 25 / 2;
    self.topMarkLab.clipsToBounds = YES;
}


- (IBAction)showAllAction:(UIButton *)sender {
    
}

@end
