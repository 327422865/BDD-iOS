//
//  MyQRCodeAlertView.m
//  Community
//
//  Created by ZX on 2018/10/15.
//  Copyright © 2018 映山红. All rights reserved.
//

#import "MyQRCodeAlertView.h"
#import "QRCodeView.h"
//#import "UIImageView+ZXWebCache.h"

@implementation MyQRCodeAlertView

+ (void)showMyQRCodeAlertView {
    MyQRCodeAlertView *QRView = [[MyQRCodeAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].delegate.window addSubview:QRView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClickAction)];
        [self addGestureRecognizer:tapGR];

        UIView *bgView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 8;
            view.layer.masksToBounds = YES;
            [self addSubview:view];
            view;
        });
        
        UIImageView *headImgV =  ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.layer.cornerRadius = 36;
            imageView.layer.masksToBounds = YES;
//            [imageView zx_setFaceThumbImageWithURL:[UserInfoManager shareInstance].userInfo.faceurl placeholderImage:[UIImage imageNamed:PlaceHolderHeader]];
            [bgView addSubview:imageView];
            imageView;
        });
        
        UILabel *nameLab = ({
            UILabel *label = [[UILabel alloc] init];
//            label.text = [UserInfoManager shareInstance].userInfo.nickname;
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = MAIN_BLACK_COLOR;
            label.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:label];
            label;
        });
        
        QRCodeView *codeView = [[QRCodeView alloc] initWithType:QRCodeViewType_My];
        [bgView addSubview:codeView];
        
        UILabel *tipLab = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"用斑猪一扫，码上变好友。";
            label.font = [UIFont systemFontOfSize:11];
            label.textColor = HEX_COLOR(@"888888");
            label.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:label];
            label;
        });
        
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(28);
            make.right.mas_equalTo(-28);
            make.center.offset(0);
        }];
        [headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(30);
            make.width.height.mas_equalTo(72);
            make.centerX.offset(0);
        }];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImgV.mas_bottom).offset(16);
            make.left.offset(16);
            make.right.offset(-16);
            make.centerX.offset(0);
        }];
        [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLab.mas_bottom).offset(23);
            make.left.mas_equalTo(65);
            make.right.mas_equalTo(-65);
            make.height.mas_equalTo(codeView.mas_width);
        }];
        [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.right.offset(-16);
            make.top.equalTo(codeView.mas_bottom).offset(37);
            make.bottom.offset(-22);
        }];
        
    }
    return self;
}

- (void)bgViewClickAction {
    [self removeFromSuperview];
}

@end
