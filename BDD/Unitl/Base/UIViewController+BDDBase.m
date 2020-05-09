//
//  UIViewController+BDDBase.m
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "UIViewController+BDDBase.h"
#import "DIYScanViewController.h"
#import "LBXPermission.h"


@implementation UIViewController (BDDBase)

/****************************************************************************/
#pragma mark - ---------------- 返回按钮 -----------------------

//  设置返回按钮，需要在第一个vc里设置
- (void)setupBackButton {
    // 目前最好的自定义返回按钮方案，支持iOS8及以上,支持pop侧滑手势
    [self.navigationController.navigationBar setBackIndicatorImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"    " style:UIBarButtonItemStylePlain target:nil action:nil];
    backItem.tintColor = HEX_COLOR(@"343434");
    self.navigationItem.backBarButtonItem = backItem;
    
    
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage new]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage new]];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(zx_popAction)];
//    self.navigationItem.backBarButtonItem = leftItem;
}

//  临时设置返回按钮-白色
- (void)setupBackButton_White_Tmp {
    // 目前最好的自定义返回按钮方案，支持iOS8及以上,支持pop侧滑手势
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"fanhui-baise"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"fanhui-baise"]];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"    " style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backItem;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui-baise"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(BDD_popAction)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self setupBackButton];// push到其他页面还使用系统的返回按钮
}

- (void)BDD_popAction {
    [self.navigationController popViewControllerAnimated:YES];
}


/****************************************************************************/
#pragma mark - ---------------- 导航栏右上角按钮 -----------------------

/// 设置右上角按钮-图片按钮
- (void)setupRightButtonWithImageName:(NSString *)imageName action:(SEL)action {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    [self.navigationItem setRightBarButtonItem:rightItem];
}
/// 设置右上角按钮(多按钮）-图片按钮
- (void)setupRightButtonsWithImageNames:(NSArray *)imageNames actionNames:(NSArray *)actionNames {
    NSAssert(imageNames.count == actionNames.count, @"按钮个数和action个数不同");
    NSMutableArray *rightItems = [NSMutableArray arrayWithCapacity:imageNames.count];
    for (int i = 0; i < imageNames.count; i++) {
        NSString *imageName = imageNames[i];
        NSString *actionName = actionNames[i];
         UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(actionName)];
        if (i != 0 && imageNames.count == 2) {
            [rightItem setImageInsets:UIEdgeInsetsMake(0, 15, 0, -15)];// 调整item之间的间距
        }
        [rightItems addObject:rightItem];
    }
    [self.navigationItem setRightBarButtonItems:rightItems];
}
/// 设置右上角按钮-button
- (void)setupRightButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [BDDTool widthOfString:title font:[UIFont systemFontOfSize:16] height:44];
    rightBtn.frame = CGRectMake(0, 0, MAX(width, 44), 44);
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:HEX_COLOR(@"343434") forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self setupRightButtonWithCustomView:rightBtn];
}

/// 设置右上角按钮-自定义View
- (void)setupRightButtonWithCustomView:(UIView *)customView {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

/****************************************************************************/
#pragma mark - ---------------- 导航栏左上角按钮  -----------------------

/// 设置左上角按钮-button
- (void)setupLeftButtonWithTitle:(NSString *)title action:(SEL)action {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [BDDTool widthOfString:title font:[UIFont systemFontOfSize:16] height:44];
    leftBtn.frame = CGRectMake(0, 0, MAX(width, 44), 44);
    [leftBtn setTitle:title forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithRed:253/255.0 green:202/255.0 blue:27/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self setupLeftButtonWithCustomView:leftBtn];
}

/// 设置左上角按钮(多按钮）-图片按钮
- (void)setupLeftButtonsWithImageNames:(NSArray *)imageNames actionNames:(NSArray *)actionNames {
    NSAssert(imageNames.count == actionNames.count, @"按钮个数和action个数不同");
    NSMutableArray *leftItems = [NSMutableArray arrayWithCapacity:imageNames.count];
    for (int i = 0; i < imageNames.count; i++) {
        NSString *imageName = imageNames[i];
        NSString *actionName = actionNames[i];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(actionName)];
        [leftItems addObject:leftItem];
    }
    [self.navigationItem setLeftBarButtonItems:leftItems];
}

/// 设置左上角按钮-自定义View
- (void)setupLeftButtonWithCustomView:(UIView *)customView {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

///// 设置左上角选择小区按钮
//- (void)setupLeftChangeCommunityButton:(NSString *)comName {
//    UIView *customView = [[UIView alloc] init];
//    UIImageView *leftImageV = [[UIImageView alloc] init];
//    leftImageV.image = [UIImage imageNamed:@"diweixiaoqu"];
//    [customView addSubview:leftImageV];
//    UILabel *nameLab = [[UILabel alloc] init];
//    nameLab.text = comName;
//    if (@available(iOS 8.2, *)) {
//        nameLab.font = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
//    } else {
//        nameLab.font = [UIFont systemFontOfSize:19];
//    }
//    [customView addSubview:nameLab];
//    UIImageView *rightImageV = [[UIImageView alloc] init];
//    rightImageV.image = [UIImage imageNamed:@"qiehuanxiaoqu"];
//    rightImageV.contentMode = UIViewContentModeCenter;
//    rightImageV.tintColor = HEX_COLOR(@"7f7f7f");
//    [customView addSubview:rightImageV];
//
//    if (@available(iOS 11, *)) {
//        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@22.5);
//            make.width.lessThanOrEqualTo(@(SCREEN_WIDTH/2));
//        }];
//    } else {
//        customView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
//    }
//
//    [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.centerY.equalTo(customView);
//        make.size.mas_equalTo(CGSizeMake(15, 18));
//    }];
//    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(leftImageV.mas_right).offset(5);
//        make.height.equalTo(@26.5);
//        make.centerY.equalTo(customView);
//    }];
//    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(nameLab.mas_right).offset(8);
//        make.right.lessThanOrEqualTo(customView);
//        make.size.mas_equalTo(CGSizeMake(9, 9));
//        make.centerY.equalTo(customView.mas_centerY);
//    }];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftButtonTapGestureAction)];
//    [customView addGestureRecognizer:tap];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
//    [self.navigationItem setLeftBarButtonItem:leftItem];
//}
//
//- (void)leftButtonTapGestureAction {
//    SelectCommunityViewController *selectComVC = [[SelectCommunityViewController alloc] init];
//    selectComVC.comeFromVC = SelectCommunityComeFromHomeVC;
//    selectComVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:selectComVC animated:YES];
//}

/****************************************************************************/
#pragma mark - ---------------- 设置导航栏背景图片 -----------------------

/// 主题色背景导航栏
- (void)setNavigationBarBackgroundYellowImage {
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    [gradientView.layer addSublayer:[self gradientLayer]];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithView:gradientView] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;// 关闭导航栏的半透明效果
}
/// 主题色背景导航栏，没有黑色阴影线
- (void)setNavigationBarBackgroundYellowImageNoShadow {
    [self setNavigationBarBackgroundYellowImage];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/// 导航栏黄色背景渐变层
- (CALayer *)gradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)HEX_COLOR(@"FFE135").CGColor, (__bridge id)HEX_COLOR(@"FFCE03").CGColor, (__bridge id)HEX_COLOR(@"FFC900").CGColor];
    gradientLayer.locations = @[@0.0, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
    return gradientLayer;
}

- (UIImage *)imageWithView:(UIView *)view {
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/** 透明背景的导航栏，白色返回按钮，白色状态栏 */
- (void)setNavigationBarNOBackgroundColor {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;// 关闭导航栏的半透明效果
    [self setupBackButton_White_Tmp];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

/// 默认导航栏，黑色返回按钮，黑色状态栏
- (void)setNavigationBarDefault {
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:ColorF1]];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    self.navigationController.navigationBar.translucent = NO;// 关闭导航栏的半透明效果
    if (@available(iOS 13.0, *)) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/****************************************************************************/
#pragma mark - ---------------- 二维码扫描 -----------------------

- (void)QRScan {
    [LBXPermission authorizeWithType:LBXPermissionType_Camera completion:^(BOOL granted, BOOL firstTime) {
        if (granted) {
            DIYScanViewController *vc = [DIYScanViewController new];
            vc.style = [self weixinScanStyle];
            vc.isOpenInterestRect = YES;
            vc.libraryType = SLT_Native;
            vc.scanCodeType = SCT_QRCode;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if(!firstTime)
        {
            [LBXPermissionSetting showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有相机权限，请打开相机" cancel:@"取消" setting:@"打开" ];
        }
    }];
}

- (LBXScanViewStyle*)weixinScanStyle {
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    style.colorRetangleLine = HEX_COLOR(@"F5F4F0");
    style.colorAngle = THEME_COLOR;
    style.animationImage = [UIImage imageNamed:@"sacnline"];
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    return style;
}

@end
