//
//  BDDGoodsCommentCell.m
//  BDD
//
//  Created by 彭英科 on 2020/5/11.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoodsCommentCell.h"
#import "UIImageView+BDDWebCache.h"
#import "UIButton+HQCustomIcon.h"

@interface BDDGoodsCommentCell ()
/** 标题评论数 */
@property (nonatomic, strong) UILabel *titleLab;
/** 头像 */
@property (nonatomic, strong) UIImageView *headImageV;
/** 昵称 */
@property (nonatomic, strong) UILabel *nicknameLab;
/** 位置 */
@property (nonatomic, strong) UILabel *locationLab;
/** 内容文字 */
@property (nonatomic, strong) UILabel *contentLabe;
/** 内容图片背景 */
@property (nonatomic, strong) UIView *iamgeBackV;

@property (nonatomic, strong) UIButton *selectedBtn;


@end

@implementation BDDGoodsCommentCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    
    //标题评论数
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.text = @"商品评价（2302）";
    self.titleLab.font = [UIFont fontWithName:@"PingFangSC" size:16];
    self.titleLab.textColor = HEX_COLOR(@"#343434");
    [self addSubview:self.titleLab];
    //查看全部(右上角)
    UIButton *checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    checkAllBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [checkAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [checkAllBtn setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
    checkAllBtn.backgroundColor = [UIColor whiteColor];
    [checkAllBtn setTitleColor:HEX_COLOR(@"#FC4F14") forState:UIControlStateNormal];
    [checkAllBtn addTarget:self action:@selector(showAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:checkAllBtn];
    //筛选按钮
    [self createScreeningBtn];
    //头像
    self.headImageV = [[UIImageView alloc] init];
    self.headImageV.image = [UIImage imageNamed:@"Logo"];
    self.headImageV.layer.cornerRadius = 14;
    self.headImageV.clipsToBounds = YES;
    [self addSubview:self.headImageV];
    //昵称
    self.nicknameLab = [[UILabel alloc] init];
    self.nicknameLab.text = @"小鲁班打野";
    self.nicknameLab.font = [UIFont fontWithName:@"PingFangSC" size:12];
    self.nicknameLab.textColor = HEX_COLOR(@"#343434");
    [self addSubview:self.nicknameLab];
    //位置
    self.locationLab = [[UILabel alloc] init];
    self.locationLab.text = @"白领/广州";
    self.locationLab.font = [UIFont systemFontOfSize:11];
    self.locationLab.textColor = HEX_COLOR(@"#999999");
    [self addSubview:self.locationLab];
    //评论文字
    self.contentLabe = [[UILabel alloc] init];
    self.contentLabe.text = @"朋友介绍买的，很不错，一次性买了它家好多水果回来，没有失望，菠萝也不酸，吃起来也不会有丝，奥利给，很棒，下次还会再买";
    self.contentLabe.font = [UIFont fontWithName:@"PingFangSC" size:12];
    self.contentLabe.textColor = HEX_COLOR(@"#333333");
    self.contentLabe.numberOfLines = 0;
    [self addSubview:self.contentLabe];
    //评论图片背景view
    self.iamgeBackV = [[UIView alloc] init];
    [self addSubview:self.iamgeBackV];
    //查看全部
    UIButton *showAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showAllBtn.layer.cornerRadius = 12.5;
    showAllBtn.clipsToBounds = YES;
    showAllBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [showAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    showAllBtn.backgroundColor = [UIColor whiteColor];
    [showAllBtn setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
    showAllBtn.layer.borderColor = HEX_COLOR(@"#979797").CGColor;
    showAllBtn.layer.borderWidth = 0.5;
    [showAllBtn addTarget:self action:@selector(showAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:showAllBtn];
    
    //标题评论数
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(15);
        make.height.equalTo(@22);
    }];
     //查看全部(右上角)
    [checkAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLab.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(@70);
        make.height.equalTo(@16);
    }];
    [checkAllBtn setIconInRightWithSpacing:5];
   //头像
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(57);
        make.left.equalTo(self).offset(15);
        make.width.height.equalTo(@28);
    }];
    //昵称
    [self.nicknameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageV.mas_top);
        make.left.equalTo(self.headImageV.mas_right).offset(4);
        make.right.equalTo(self.mas_right).offset(50);
        make.height.equalTo(@17);
    }];
    //位置
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nicknameLab.mas_bottom);
        make.left.equalTo(self.nicknameLab);
        make.height.equalTo(@16);
    }];
    //评论文字
    [self.contentLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageV.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    //图片背景
    [self.iamgeBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabe.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(@93);
    }];
    //查看全部
    [showAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.iamgeBackV.mas_bottom).offset(21);
        make.width.equalTo(@133);
        make.height.equalTo(@30);
    }];
     NSArray *arry = @[@"three_6",@"three_6",@"three_6"];
     [self createContentImageViewWith:arry];
}

///筛选按钮
- (void)createScreeningBtn {
    NSArray *arry = @[@"好评",@"中评",@"差评",@"有图"];
    CGFloat btn_W = 63;
    CGFloat btn_H = 26;
    CGFloat Kmargin = 5;
    CGFloat kmargin_Y = 57;//距离顶部的Y值
    CGFloat kmargin_SCREENLeft = 15;//距离屏幕左边间距
    for (int i = 0; i < arry.count; i++) {
        UIButton *screeningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        screeningBtn.tag = 1000 + i;
        screeningBtn.layer.cornerRadius = 12.5;
        screeningBtn.clipsToBounds = YES;
        screeningBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [screeningBtn setTitle:arry[i] forState:UIControlStateNormal];
        screeningBtn.backgroundColor = HEX_COLOR(@"#F7F7F7");
        [screeningBtn setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
        screeningBtn.layer.borderColor = HEX_COLOR(@"#F7F7F7").CGColor;
        screeningBtn.layer.borderWidth = 0.5;
        [screeningBtn addTarget:self action:@selector(screeningAction:) forControlEvents:UIControlEventTouchUpInside];
        screeningBtn.frame = CGRectMake(kmargin_SCREENLeft + (btn_W + Kmargin) * i, kmargin_Y, btn_W, btn_H);
        [self addSubview:screeningBtn];
    }
}

- (void)createContentImageViewWith:(NSArray *)imageArray{
    CGFloat imageV_H = 93;
    CGFloat Kmargin = 3;
    CGFloat kmargin_Y = 0;
    CGFloat kmargin_SCREENLeft = 15;//距离屏幕左边间距
    CGFloat imageV_W = (SCREEN_WIDTH - kmargin_SCREENLeft * 2 - Kmargin * 2) / 3.0;
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *contentImageV = [[UIImageView alloc] init];
        contentImageV.userInteractionEnabled = YES;
        contentImageV.image = [UIImage imageNamed:imageArray[i]];
        contentImageV.contentMode = UIViewContentModeScaleAspectFill;
        contentImageV.clipsToBounds = YES;
        contentImageV.tag = 2000 + i;
        contentImageV.layer.cornerRadius = 4;
        contentImageV.frame = CGRectMake(kmargin_SCREENLeft + (imageV_W + Kmargin) * i, kmargin_Y, imageV_W, imageV_H);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction:)];
        [contentImageV addGestureRecognizer:tap];
        [self.iamgeBackV addSubview:contentImageV];
    }
}


#pragma mark --- Action
///评论筛选
- (void)screeningAction:(UIButton *)btn {
    if (btn!= self.selectedBtn) {
        self.selectedBtn.selected = NO;
        btn.selected = YES;
        self.selectedBtn.backgroundColor = HEX_COLOR(@"#F7F7F7");
        [self.selectedBtn setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
        self.selectedBtn.layer.borderColor = HEX_COLOR(@"#F7F7F7").CGColor;
        btn.backgroundColor = HEX_COLOR(@"#FFEEE7");
        [btn setTitleColor:HEX_COLOR(@"#F64F53") forState:UIControlStateNormal];
        btn.layer.borderColor = HEX_COLOR(@"#FD5F1A").CGColor;
        self.selectedBtn = btn;
    }
    DLog(@"---%ld",self.selectedBtn.tag);
}

///查看全部评论
- (void)showAllAction {
    DLog(@"");
    
}

///点击评论图片
- (void)clickImageAction:(UITapGestureRecognizer *)tap {
    UIImageView *imagev = (UIImageView *)[self viewWithTag:tap.view.tag];
    DLog(@"---%ld",imagev.tag);
}


@end
