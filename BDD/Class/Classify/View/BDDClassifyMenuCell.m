//
//  BDDClassifyMenuCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDClassifyMenuCell.h"

@interface BDDClassifyMenuCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *statView;

@end

@implementation BDDClassifyMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = HEX_COLOR(@"#333333");
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.height.equalTo(@22);
        }];
        
        self.statView = [[UIView alloc] init];
        [self.contentView addSubview:self.statView];
        [self.statView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView.mas_left);
            make.width.equalTo(@4);
            make.height.equalTo(@20);
        }];
    }
    return self;
}

- (void)setModel:(BDDClassifyModel *)model {
    self.titleLabel.text = model.name;
    if (model.isSelect) {
         self.titleLabel.textColor = HEX_COLOR(@"#FD5D19");
         self.backgroundColor = [UIColor whiteColor];
         self.statView.backgroundColor = HEX_COLOR(@"#FD5D19");
         self.titleLabel.font = [UIFont systemFontOfSize:18];
     }else{
         self.titleLabel.textColor = HEX_COLOR(@"#333333");
         self.backgroundColor = HEX_COLOR(@"#EBEBEB");
         self.statView.backgroundColor = HEX_COLOR(@"#EBEBEB");
          self.titleLabel.font = [UIFont systemFontOfSize:16];
     }
}



@end
