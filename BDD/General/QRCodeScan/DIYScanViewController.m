//
//  DIYScanViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 2017/6/5.
//  Copyright © 2017年 lbx. All rights reserved.
//

#import "DIYScanViewController.h"
//#import "UIViewController+Base.h"
#import <LEEAlert.h>
#import "LBXPermission.h"
//#import "LinkTool.h"
#import <UIButton+LXMImagePosition.h>

@interface DIYScanViewController ()

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *flashBtn;

@end

@implementation DIYScanViewController

- (void)dealloc {
    DLog(@"");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setNavigationBarNOBackgroundColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_bottomView) {
        [self.view bringSubviewToFront:self.bottomView];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self setNavigationBarDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫码";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }

//    self.cameraInvokeMsg = @"相机启动中";
}

- (UIView *)bottomView {
    if (!_bottomView) { 
        CGFloat leftOffset = self.style.xScanRetangleOffset;
        CGFloat height = (SCREEN_WIDTH - leftOffset*2);
        CGFloat y = (SCREEN_HEIGHT - height)/2 + height - 44;// 扫描框自定义设置了往上偏移44
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT - y)];
        [self.view addSubview:_bottomView];
        [self drawBottomItems];
    }
    return _bottomView;
}

- (void)drawBottomItems {
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.text = @"将二维码放入框内，即可自动扫描";
    tipLab.font = [UIFont systemFontOfSize:13];
    tipLab.textColor = HEX_COLOR(@"AFAFAF");
    tipLab.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:tipLab];
    
    UIButton *photoBtn = [[UIButton alloc]init];
    [photoBtn setImage:[UIImage imageNamed:@"saoma_xiangche"] forState:UIControlStateNormal];
    [photoBtn setTitle:@"打开相册" forState:UIControlStateNormal];
    photoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [photoBtn setImagePosition:LXMImagePositionTop spacing:13];
    [photoBtn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:photoBtn];
    
    self.flashBtn = [[UIButton alloc]init];
    [self.flashBtn setImage:[UIImage imageNamed:@"saoma_xiangjiguanbi"] forState:UIControlStateNormal];
    [self.flashBtn setTitle:@"打开手电筒" forState:UIControlStateNormal];
    self.flashBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.flashBtn setImagePosition:LXMImagePositionTop spacing:13];
    [self.flashBtn addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.flashBtn];
    
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(7);
        make.left.right.offset(0);
    }];
    // 扫描白框距离左右两边距离为60
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset((SCREEN_WIDTH-120)/3);
        make.bottom.offset(-33-HOMEINDICATOR_HEIGHT);
    }];
    [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-(SCREEN_WIDTH-120)/3);
        make.bottom.offset(-33-HOMEINDICATOR_HEIGHT);
    }];
}


#pragma mark -底部功能项
//打开相册
- (void)openPhoto {
    weakify(self);
    [LBXPermission authorizeWithType:LBXPermissionType_Photos completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
            [weak_self openLocalPhoto:NO];
        }
        else if (!firstTime )
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相册权限，无法获取照片，请打开相册权限" cancel:@"取消" setting:@"打开"];
        }
    }];
}

//开关闪光灯
- (void)openOrCloseFlash {
    [super openOrCloseFlash];
    
    if (self.isOpenFlash) {
        [self.flashBtn setImage:[UIImage imageNamed:@"saoma_xiangji打开"] forState:UIControlStateNormal];
        [self.flashBtn setTitle:@"关闭手电筒" forState:UIControlStateNormal];
    } else {
        [self.flashBtn setImage:[UIImage imageNamed:@"saoma_xiangjiguanbi"] forState:UIControlStateNormal];
        [self.flashBtn setTitle:@"打开手电筒" forState:UIControlStateNormal];
    }
}



#pragma mark -实现类继承该方法，作出对应处理

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array {
    if (!array ||  array.count < 1) {
        [self scanFail];
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    LBXScanResult *scanResult = array[0];
    NSString *strResult = scanResult.strScanned;
    self.scanImage = scanResult.imgScanned;
    if (ISEMPTYSTR(strResult)) {
        [self scanFail];
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    // 震动
//    AudioServicesPlaySystemSound(1520);

    [self showNextVCWithScanResult:scanResult];
}

- (void)scanFail {
    [LEEAlert alert].config.LeeTitle(@"扫码失败，未识别到内容").LeeAction(@"知道了", ^{
        [self reStartDevice];
    }).LeeShow();
}

- (void)showNextVCWithScanResult:(LBXScanResult *)strResult {
    DLog(@"二维码扫描原始数据：%@", strResult.strScanned);
    [self showHUDWithMessage:@"正在解析"];
    
//    [BDDMHttpTool POST:QrcodeScan_Url parameters:@{@"url": strResult.strScanned} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [self hideHUD];
//        DLog(@"二维码扫描后台解析数据：%@", responseObject);

//        if ([responseObject[@"code"] integerValue] == 1) {
//            NSDictionary *data = responseObject[@"data"];
//            // 用户名片
//            if ([data[@"type"] isEqualToString:@"USER"]) {
//                [LinkTool handleQRCodeResult:[NSString stringWithFormat:@"banzhu://usercard?id=%@", data[@"userId"]]];
//                DLog(@"USER:%@", data[@"userId"]);
//            }
//            // 圈子
//            else if ([data[@"type"] isEqualToString:@"CIRCLE"]) {
//                [LinkTool handleQRCodeResult:[NSString stringWithFormat:@"banzhu://coterie?id=%@", data[@"circleId"]]];
//            }
//            // 话题
//            else if ([data[@"type"] isEqualToString:@"INFO"]) {
//                [LinkTool handleQRCodeResult:[NSString stringWithFormat:@"https://banzhu.info?id=%@", data[@"id"]]];
//            }
//            // 活动
//            else if ([data[@"type"] isEqualToString:@"ACTIVITY"]) {
//                [LinkTool handleQRCodeResult:[NSString stringWithFormat:@"https://banzhu.activity?id=%@", data[@"id"]]];
//            }
//            // 投票
//            else if ([data[@"type"] isEqualToString:@"VOTE"]) {
//                [LinkTool handleQRCodeResult:[NSString stringWithFormat:@"https://banzhu.vote?id=%@", data[@"id"]]];
//            }
//            // H5
//            else if ([data[@"type"] isEqualToString:@"H5"]) {
//                [LinkTool handleQRCodeResult:data[@"url"]];
//            } else {
//                [HUD showToastMessage:UpdateAppTip];
//            }
//        } else {
//            [LinkTool handleQRCodeResult:strResult.strScanned];
//            DLog(@"未知链接");
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DLog(@"二维码扫描后台解析失败：%@", error);
//    }];
   
}


@end


