//
//  BDDGoddsPictureInforCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoddsPictureInforCell.h"

@interface BDDGoddsPictureInforCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BDDGoddsPictureInforCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
//    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.text = @"图文详情";
//    titleLab.font = [UIFont fontWithName:@"PingFangSC" size: 16];
//    titleLab.textColor = HEX_COLOR(@"#343434");
//    [self addSubview:titleLab];
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(20);
//        make.left.equalTo(self.mas_left).offset(15);
//        make.height.equalTo(@22);
//    }];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"one_p"];
    self.inputView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
         make.left.equalTo(self).offset(10);
         make.bottom.equalTo(self).offset(-10);
         make.right.equalTo(self).offset(-10);
        
    }];
}


@end
