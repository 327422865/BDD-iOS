//
//  BDDNoNetWorkHintView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDNoNetWorkHintView.h"

@interface BDDNoNetWorkHintView ()

@property (nonatomic, strong) UIView *contentV;

@end

@implementation BDDNoNetWorkHintView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

- (void)setupView {
     self.contentV = [[UIView alloc] init];
      self.contentV.layer.shadowColor = [UIColor grayColor].CGColor;
      self.contentV.layer.shadowOffset = CGSizeMake(5, 5);
      self.contentV.layer.shadowRadius = 5;
      self.contentV.layer.shadowOpacity = 0.5;
      [self addSubview:self.contentV];
      [self.contentV mas_updateConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.mas_top).offset(2);
          make.left.equalTo(self.mas_left).offset(15);
          make.right.equalTo(self.mas_right).offset(-15);
          make.height.equalTo(@40);
      }];
      UIView *shadowV = [[UIView alloc] init];
      shadowV.layer.cornerRadius = 20;
      shadowV.layer.masksToBounds = YES;
      shadowV.backgroundColor = [UIColor whiteColor];
      [self.contentV addSubview:shadowV];
      [shadowV mas_updateConstraints:^(MASConstraintMaker *make) {
          make.left.right.height.width.equalTo(self.contentV);
      }];
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAciton)];
      [self.contentV addGestureRecognizer:tap];
      
      UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pinglun"]];
      [shadowV addSubview:leftIcon];
      UILabel *tileLab = [[UILabel alloc] init];
      tileLab.text = @"网络请求失败，请检查您的网络设置";
      tileLab.font =  [UIFont systemFontOfSize:13];
      tileLab.textColor = HEX_COLOR(@"#333333");
      [shadowV addSubview:tileLab];
      UIImageView * rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
      [shadowV addSubview:rightIcon];
      [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(shadowV);
          make.left.equalTo(shadowV.mas_left).offset(15);
          make.width.height.equalTo(@20);
      }];
      [tileLab mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(shadowV);
          make.left.equalTo(leftIcon.mas_right).offset(5);
          make.height.equalTo(@18);
      }];
      [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(shadowV);
          make.right.equalTo(shadowV).offset(-15);
          make.width.equalTo(@5);
          make.height.equalTo(@9);
      }];
      
}

///点击无网络提示
- (void)clickAciton {
    DLog(@"");
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
