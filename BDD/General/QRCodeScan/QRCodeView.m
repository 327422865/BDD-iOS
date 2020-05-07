//
//  QRCodeView.m
//  Community
//
//  Created by ZX on 2018/10/15.
//  Copyright © 2018 映山红. All rights reserved.
//

#import "QRCodeView.h"
#import "LBXScanNative.h"
//#import "LinkTool.h"
//#import "UIImageView+ZXWebCache.h"
#import "UIImageView+BDDWebCache.h"

@interface QRCodeView ()

@property (nonatomic, strong) UIImageView *qrImgView;
@property (nonatomic, strong) UIImageView *logoImgView;

@end

@implementation QRCodeView

- (void)dealloc {
    DLog(@"");
}

- (instancetype)initWithType:(QRCodeViewType)type {
    return [self initWithType:type withLogoImageUrl:nil param:nil];
}

- (instancetype)initWithType:(QRCodeViewType)type withLogoImageUrl:(nullable NSString *)logoImageUrl param:(nullable NSDictionary *)param {
    if (self = [super init]) {
        self.qrImgView = [[UIImageView alloc]init];
//                self.qrImgView.bounds = CGRectMake(0, 0, CGRectGetWidth(frame)-12, CGRectGetWidth(frame)-12);
//                self.qrImgView.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
        self.qrImgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.qrImgView];
        
        self.logoImgView = [[UIImageView alloc] init];
//                CGFloat logoWidth = CGRectGetWidth(self.qrImgView.frame);
//                logoWidth = MAX(logoWidth/5.0, 30);
//                self.logoImgView.frame = CGRectMake(0, 0, logoWidth, logoWidth);
//                self.logoImgView.center = self.qrImgView.center;
        self.logoImgView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.logoImgView.layer.borderWidth = 2;
        self.logoImgView.layer.cornerRadius = 2;
        self.logoImgView.layer.masksToBounds = YES;
        if (ISEMPTYSTR(logoImageUrl)) {
            self.logoImgView.image = [UIImage imageNamed:@"Logo"];
        } else {
            [self.logoImgView zx_setImageWithURL:logoImageUrl placeholderImage:[UIImage imageNamed:@"Logo"]];
        }
        self.logoImgView.hidden = YES;
        [self.qrImgView addSubview:self.logoImgView];
        
        switch (type) {
            case QRCodeViewType_My:
                [self getMyQRCodeUrl];
                break;
            case QRCodeViewType_Coterie:
                [self getCoterieQRCodeUrlWithParam:param];
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.qrImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.logoImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.height.width.mas_equalTo(self.qrImgView.mas_width).multipliedBy(0.2).priority(750);
        make.height.width.mas_greaterThanOrEqualTo(30).priority(1000);
    }];
}

- (void)getMyQRCodeUrl {
    [BDDHUD showProgressWithMessage:@"正在加载"];
//    [BDDMHttpTool GET_ZX:getMyQrcode_Url parameters:nil success:^(id  _Nullable dataObject, NSString * _Nullable msg) {
//        [HUD dismissProgress];
//        self.qrImgView.image = [LBXScanNative createQRWithString:dataObject[@"qrcode"] QRSize:CGSizeMake(200, 200)];
//        self.logoImgView.hidden = NO;
//    } otherSuccess:^(id  _Nullable dataObject, NSString * _Nullable msg) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
}

- (void)getCoterieQRCodeUrlWithParam:(NSDictionary *)param {
//    [BDDMHUD showProgressWithMessage:@"正在加载"];
//    [BDDMHttpTool POST_ZX:getCircleQrcode_Url parameters:param success:^(id  _Nullable dataObject, NSString * _Nullable msg) {
//        [HUD dismissProgress];
//        self.qrImgView.image = [LBXScanNative createQRWithString:dataObject[@"qrcode"] QRSize:CGSizeMake(200, 200)];
//        self.logoImgView.hidden = NO;
//    } otherSuccess:^(id  _Nullable dataObject, NSString * _Nullable msg) {
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
}

@end
