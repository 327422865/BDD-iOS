//
//  BDDBaseTabBarController.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDBaseTabBarController.h"
#import "BDDBaseNavigationController.h"

#import "BDDHomeViewController.h"
#import "BDDClassifyViewController.h"
#import "BDDCircleViewController.h"
#import "BDDMeViewController.h"

@interface BDDBaseTabBarController ()

@end

@implementation BDDBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    [self createChildVCs];
    
}

- (void)createChildVCs {
    ///首页
    BDDHomeViewController *homeVC= [[BDDHomeViewController alloc] init];
    [self setupChildViewController:homeVC withTitle:@"首页" imageName:@"wode_shouye" selectedImageName:@"wode_shouye_link"];
    ///分类
    BDDClassifyViewController *classifyVC = [[BDDClassifyViewController alloc] init];
    [self setupChildViewController:classifyVC withTitle:@"分类" imageName:@"wode_shangcheng" selectedImageName:@"wode_shangcheng_link"];
    ///多多圈
    BDDCircleViewController *circleVC = [[BDDCircleViewController alloc] init];
    [self setupChildViewController:circleVC withTitle:@"多多圈" imageName:@"wode_shequ" selectedImageName:@"wode_shequ_link"];
    ///我
    BDDMeViewController *meVC = [[BDDMeViewController alloc] init];
    [self setupChildViewController:meVC withTitle:@"我" imageName:@"wode_wode" selectedImageName:@"wode_wode_link"];
}


- (void)setupChildViewController:(UIViewController *)viewController withTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *selectedDictHome = [NSDictionary dictionaryWithObject:THEME_COLOR forKey:NSForegroundColorAttributeName];
    NSDictionary *normalDictHome = [NSDictionary dictionaryWithObject:MAIN_BLACK_COLOR forKey:NSForegroundColorAttributeName];
    [viewController.tabBarItem setTitleTextAttributes:selectedDictHome forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:normalDictHome forState:UIControlStateNormal];
    
    BDDBaseNavigationController *naviC = [[BDDBaseNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:naviC];
}


@end
