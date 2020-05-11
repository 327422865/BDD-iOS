//
//  BDDGoodsDetailsHeadView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoodsDetailsHeadView.h"

@interface BDDGoodsDetailsHeadView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *pagenumberBtn;

@end

@implementation BDDGoodsDetailsHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self addSubview:self.scrollView];
    [self addSubview:self.pagenumberBtn];
    [self.pagenumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.equalTo(@50);
        make.height.equalTo(@25);
    }];
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
        for (int i = 0 ; i < imageArray.count ; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_WIDTH * 2/3)];
        imageV.image = [UIImage imageNamed:imageArray[i]];
        imageV.tag = 1000 + i;
        [imageV setContentMode:UIViewContentModeScaleAspectFill];
        imageV.clipsToBounds = YES;
        imageV.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageV];
        // 手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [imageV addGestureRecognizer:tapGesture];
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _imageArray.count, 0);
   NSString *page = [NSString stringWithFormat:@"%d/%ld",1, _imageArray.count];
   [self.pagenumberBtn setTitle:page forState:UIControlStateNormal];
}

#pragma mark -----------------UIScrollViewDelegate-----------------

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
        NSString *page = [NSString stringWithFormat:@"%ld/%ld",index + 1,self.imageArray.count];
        [self.pagenumberBtn setTitle:page forState:UIControlStateNormal];
    }
}


#pragma  mark ---------Action----------
#pragma mark -- 点击图片
- (void)tapClick:(UITapGestureRecognizer *)tap{
    DLog(@"");
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        //设置view的frame
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 2/3)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
    }
    return _scrollView;
}

- (UIButton *)pagenumberBtn{
    if (!_pagenumberBtn) {
        _pagenumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pagenumberBtn.layer.cornerRadius = 25 / 2.0;
        _pagenumberBtn.clipsToBounds = YES;
        _pagenumberBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _pagenumberBtn.backgroundColor = [HEX_COLOR(@"#000000") colorWithAlphaComponent:0.5];
        [_pagenumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _pagenumberBtn;
}
@end
