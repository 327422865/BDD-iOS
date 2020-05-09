//
//  BDDBaseNavigationController.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDBaseNavigationController.h"

@interface BDDBaseNavigationController ()

@end

@implementation BDDBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [UIApplication sharedApplication].keyWindow.backgroundColor = [UIColor whiteColor];// 解决隐藏导航栏切换vc时导航栏黑色背景问题
    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    self.navigationBar.translucent = NO;// 关闭导航栏的半透明效果

   
}

/// push时自动隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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


//
//+ (void)initialize
//{
//
//    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
//
//    // [[UINavigationBar appearance] setTranslucent:NO];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    //设置整个项目所有BarButtonItem的主题样式
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//
//    //设置普通状态
//    //key NS*********AttributeName
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    //textAttrs[NSForegroundColorAttributeName] = MCColor(35, 177, 209, 1);
//    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#FB5947"];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//
//    //设置不可用状态
//    NSMutableDictionary *disabletextAttrs = [NSMutableDictionary dictionary];
//    disabletextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"999999"];
//    disabletextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    [item setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
//
//    //设置导航栏标题文字的颜色
//    //  [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    //改变导航条字体为白色
//    //    NSFontAttributeName:[UIFont systemFontOfSize:19]
//    //[[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:MCColor(35, 177, 209, 1)}];
//    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
//
//    //设置默认按钮颜色
//    //[[UINavigationBar appearance] setTintColor:MCColor(184, 184, 184, 1)];
//    //[[UINavigationBar appearance] setTintColor:MCColor(33, 33, 33, 1)];
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self setUpUI];
//}
//
///**
// *  重写这个方法的目的：能够拦截所有push进来的控制器
// *
// *  @param viewController 即将push进来的控制器
// *  @param animated       是否带动画效果
// */
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.rt_viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, 6, 40, 32);
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
//        [btn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    }
//    [super pushViewController:viewController animated:animated];
//
//    [viewController hiddenNavigationBarSeparatorLine];
//}
//
//- (void)onBack
//{
//    [self popViewControllerAnimated:YES];
//}
//
//#pragma mark - SetUpUI
//
//- (void)setUpUI
//{
//    self.view.backgroundColor = SL_MainViewBackColor;
//    self.useSystemBackBarButtonItem = NO;
//    self.navigationBar.shadowImage = [UIImage new];
//   //  self.jz_fullScreenInteractivePopGestureEnabled = YES;
//}
//
//#pragma mark - Public Method
//
//#pragma mark - Event Method
//
//#pragma mark - Delegate
//
//- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 10, 60, 40);
//    [btn setBackgroundColor:[UIColor redColor]];
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    return [[UIBarButtonItem alloc] initWithCustomView:btn];
//}


@end
