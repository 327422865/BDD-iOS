//
//  BDDHomeHeadView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/7.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDHomeHeadView.h"


@interface BDDHomeHeadView ()
/** 广告模块 */
@property (nonatomic, strong) UIView *ADBackView;
/** 今日优选模块 */
@property (nonatomic, strong) UIView *todayChooseView;

/**  */
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLab;





@end

@implementation BDDHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = HEX_COLOR(@"#F4F4F4");
    
    self.ADBackView = [[UIView alloc] init];
    self.ADBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.ADBackView];
    
    self.todayChooseView = [[UIView alloc] init];
    self.todayChooseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.todayChooseView];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageView];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont fontWithName:@"PingFangSC" size: 20];
    self.titleLab.textColor = HEX_COLOR(@"#343434");
    self.titleLab.text = @"为你优选";
    [self addSubview:self.titleLab];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.ADBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@262);
    }];
    
    [self.todayChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ADBackView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@267);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.todayChooseView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@113);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.imageView.mas_bottom).offset(20);
           make.left.equalTo(self.mas_left).offset(10);
           make.height.equalTo(@28);
       }];
    
}

@end