//
//  BDDTopCycleView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/7.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDTopCycleView.h"
#import "UIButton+HQCustomIcon.h"
#import "BDDTopBtbView.h"

// 宽度(自定义)
#define PIC_WIDTH 47
// 高度(自定义)
#define PIC_HEIGHT 74
// 列数(自定义)
#define COL_COUNT 4

@interface BDDTopCycleView ()


@end

@implementation BDDTopCycleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.adView = [[ADCycleView alloc] initWithEdgeInsets:edgeInsets ADViewDirection:ADViewDirection_Home];
    self.adView.backgroundColor = [UIColor redColor];
    self.adView.ADDataArray = @[@"one_4",@"one_4",@"one_4",@"one_4",];
    [self addSubview:self.adView];
    
    NSArray *btnTitleArray = @[@"话题",@"话题",@"话题",@"话题"];
    NSArray *btnImageArray = @[@"sp_dz_cker",@"sp_dz_cker",@"sp_dz_cker",@"sp_dz_cker"];
    
    for (int i = 0; i < btnTitleArray.count; i++) {
        BDDTopBtbView *btnView = [BDDTopBtbView view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBtn:)];
        btnView.userInteractionEnabled = YES;
        [btnView addGestureRecognizer:tap];
        btnView.tag = 100 + i;
        btnView.imageStr = btnImageArray[i];
        btnView.titleStr = btnTitleArray[i];
        //所在行
        NSInteger row = i / COL_COUNT;
        //所在列
        NSInteger col = i % COL_COUNT;
        // 间距
        CGFloat margin = (SCREEN_WIDTH - 48 - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT - 1);
        // PointX
        CGFloat picX =  (PIC_WIDTH + margin) * col + 24;
        // PointY
        CGFloat picY =  (PIC_HEIGHT + margin) * row + 170 ;
        
        btnView.frame = CGRectMake(picX, picY, PIC_WIDTH, PIC_HEIGHT);
        [self addSubview:btnView];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@143);
    }];
}

- (void)clickBtn:(UITapGestureRecognizer *)tap{
    NSInteger i = tap.view.tag - 100;
    
    DLog(@"%ld",(long)i);
    //    AppMenuLisetModel *mode = self.serviceArray[i];
    //    NSString *url = mode.postUrl;
    //    NSString *title = mode.title;
    //    if (self.clickServiceButtonBlock) {
    //        self.clickServiceButtonBlock(url, title);
    //    }
}

@end
