//
//  BDDNavigationBar.m
//  BDD
//
//  Created by 彭英科 on 2020/5/12.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDNavigationBar.h"

@interface BDDNavigationBar ()

@property (nonatomic, strong) UIView *statusBarView;

@property (nonatomic, strong) UIView *navigationView;

@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIButton *leftBtn;

@end


@implementation BDDNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame leftBtns:nil rightBtns:nil];
}

- (instancetype)initWithFrame:(CGRect)frame leftBtns:(void( ^ _Nullable )(UIButton *Lbtn1, UIButton *Lbtn2))leftBtns rightBtns:(void( ^ _Nullable )(UIButton *Rbtn1, UIButton *Rbtn2))rightBtns{
    self = [super initWithFrame:frame];
    if (self) {
        self.statusBarView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUSBAR_HEIGHT)];
            view.backgroundColor = [UIColor whiteColor];
            [self addSubview:view];
            view;
        });
        self.navigationView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, frame.size.height - STATUSBAR_HEIGHT)];
            view.backgroundColor = [UIColor whiteColor];
            [self addSubview:view];
            view;
        });
        
        self.titleLab = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont boldSystemFontOfSize:17];
            label.textColor = MAIN_BLACK_COLOR;
            label.textAlignment = NSTextAlignmentCenter;
            [self.navigationView addSubview:label];
            label;
            
        });
        
        UIButton *leftBtn1 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.navigationView addSubview:button];
            button;
        });
        UIButton *leftBtn2 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.hidden = YES;
            [self.navigationView addSubview:button];
            button;
        });
        if (leftBtns) {
            leftBtns(leftBtn1, leftBtn2);
        }
        
        UIButton *rightBtn1 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.navigationView addSubview:button];
            button;
        });
        UIButton *rightBtn2 = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.hidden = YES;
            [self.navigationView addSubview:button];
            button;
        });
        if (rightBtns) {
            rightBtns(rightBtn1, rightBtn2);
        }
        
        [leftBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            if (leftBtn1.bounds.size.width == 0) {
                make.left.offset(0);
                make.size.mas_equalTo(CGSizeMake(44, 44));
            } else {
                make.left.offset(10);
                make.size.mas_equalTo(leftBtn1.bounds.size);
            }
            make.centerY.offset(0);
        }];
        [leftBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBtn1.mas_right).offset(10);
            make.centerY.offset(0);
            make.size.mas_equalTo(leftBtn2.bounds.size);
        }];
        [leftBtn1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [leftBtn2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.navigationView);
            make.left.mas_greaterThanOrEqualTo(leftBtn2.mas_right).offset(10);
        }];
        
        
        [rightBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-16);
            make.size.mas_equalTo(rightBtn1.bounds.size);
            make.centerY.offset(0);
        }];
        [rightBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightBtn1.mas_left).offset(-10);
            make.centerY.offset(0);
            make.size.mas_equalTo(rightBtn2.bounds.size);
            make.left.mas_greaterThanOrEqualTo(self.titleLab.mas_right).offset(10);
        }];
        [rightBtn1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [rightBtn2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLab.text = title;
}

- (void)setNavigationType:(BDDNavigationBarType)navigationType {
    _navigationType = navigationType;
    switch (navigationType) {
        case BDDNavigationBarType_Corner: {
            self.statusBarView.backgroundColor = [UIColor clearColor];
            CGRect rect = self.navigationView.bounds;
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(21, 21)];
            CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
            shapeLayer.path = path.CGPath;
            shapeLayer.frame  = rect;
            self.navigationView.layer.mask = shapeLayer;
        }
            break;
            
        case BDDNavigationBarType_ClearBackgroud:{
            self.statusBarView.backgroundColor = [UIColor clearColor];
            self.navigationView.backgroundColor = [UIColor clearColor];
        }
        default:
            break;
    }
}
@end

