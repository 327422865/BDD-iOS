//
//  BDDClassifyDetailCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDClassifyDetailCell.h"

@interface BDDClassifyDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation BDDClassifyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor whiteColor];
}

- (void)setModel:(BDDClassifyNextModel *)model {
//    self.imageView.
    self.titleLab.text = model.name;
}

@end
