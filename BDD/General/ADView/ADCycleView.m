//
//  ADCycleView.m
//  Community
//
//  Created by ZX on 2018/10/23.
//  Copyright © 2018 映山红. All rights reserved.
//

#import "ADCycleView.h"
#import <SDCycleScrollView.h>
#import "BDDLinkTool.h"
#import "BDDADModel.h"

@interface ADCycleView ()

/// 广告位
@property (nonatomic, strong) SDCycleScrollView *ADCycleScrollView;

@property (nonatomic, copy) NSArray <BDDADModel *> *ADModelArray;


@property (nonatomic, assign) ADViewDirection direction;
/// 广告位高宽比例（高/宽）
@property (nonatomic, assign) CGFloat h_w_scale;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation ADCycleView

- (instancetype)initWithADViewDirection:(ADViewDirection)direction {
    self.edgeInsets = UIEdgeInsetsMake(15, 16, 0, 16);
    return [self initWithEdgeInsets:self.edgeInsets ADViewDirection:direction];
}

- (instancetype)initWithEdgeInsets:(UIEdgeInsets)edgeInsets ADViewDirection:(ADViewDirection)direction {
    switch (direction) {
        case ADViewDirection_AddGoods:
            self.h_w_scale = 78.0/343.0;
            break;
        case ADViewDirection_Community:
            self.h_w_scale = 132.0/343.0;
            break;
        case ADViewDirection_My:
            self.h_w_scale = 190.0/750.0;
            break;
        case ADViewDirection_Home:
            self.h_w_scale = 120.0/375.0;
            break;
            
        default:
            self.h_w_scale = ADCycle_Scale;
            break;
    }
    self.adViewHeight = (SCREEN_WIDTH - edgeInsets.left - edgeInsets.right)*self.h_w_scale + edgeInsets.top + edgeInsets.bottom;
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, self.adViewHeight);
    DLog(@"ADHeight:%lf", self.adViewHeight);

    self = [super initWithFrame:frame];
    if (self) {
        self.direction = direction;
        self.edgeInsets = edgeInsets;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)adjustWhenControllerViewWillAppera {
    [_ADCycleScrollView adjustWhenControllerViewWillAppera];
}

- (void)setADDataArray:(NSArray *)ADDataArray {
    _ADDataArray = ADDataArray;
    
    self.ADModelArray = [BDDADModel mj_objectArrayWithKeyValuesArray:ADDataArray];
    NSMutableArray *imageUrlArray = [NSMutableArray arrayWithCapacity:self.ADModelArray.count];
    for (BDDADModel *model in self.ADModelArray) {
        [imageUrlArray addObject:model.image];
    }
    
    if (imageUrlArray.count) {
        self.ADCycleScrollView.imageURLStringsGroup = imageUrlArray;
    } else {
        [self.ADCycleScrollView removeFromSuperview];
        self->_ADCycleScrollView = nil;
    }
}

- (SDCycleScrollView *)ADCycleScrollView {
    if (!_ADCycleScrollView) {
        // 网络加载 --- 创建带标题的图片轮播器
        _ADCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 200, 180) delegate:nil placeholderImage:[UIImage imageNamed:PlaceHolderHomeAD]];
        _ADCycleScrollView.backgroundColor = HEX_COLOR(@"F4F4F4");
        _ADCycleScrollView.autoScrollTimeInterval = 5;
        _ADCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _ADCycleScrollView.currentPageDotColor = THEME_COLOR; // 自定义分页控件小圆标颜色
        _ADCycleScrollView.pageDotColor = [UIColor whiteColor];
//        _ADCycleScrollView.layer.cornerRadius = self.direction == ADViewDirection_My ? 0 : 2;
        if (self.direction == ADViewDirection_My || self.direction == ADViewDirection_Home) {
             _ADCycleScrollView.layer.cornerRadius = 0;
        }else{
            _ADCycleScrollView.layer.cornerRadius = 2;
        }
        _ADCycleScrollView.layer.masksToBounds = YES;
        _ADCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_ADCycleScrollView];
        
        // block监听点击方式
        weakify(self);
        _ADCycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
            strongify(self);
            BDDADModel *model = self.ADModelArray[index];
            if (model.url) {
                [BDDLinkTool handleHyperlink:model.url openNewWebView:YES];
            }
        };
        
        [_ADCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(self.edgeInsets.left);
            make.right.offset(-self.edgeInsets.right);
            make.top.offset(self.edgeInsets.top);
            make.bottom.offset(-self.edgeInsets.bottom);
            make.height.equalTo(self->_ADCycleScrollView.mas_width).multipliedBy(self.h_w_scale);
        }];
    }
    return _ADCycleScrollView;
}


@end
