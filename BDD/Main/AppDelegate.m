//
//  AppDelegate.m
//  BDD
//
//  Created by 彭英科 on 2020/5/6.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+BDDADLaunch.h"
#import "BDDBaseTabBarController.h"
#import "BDDLoginRegisterViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setupWindow];
       [self ADlaunchScreen];
       [self setupWithApplication:application withOptions:launchOptions];
    
    return YES;
}


- (void)setupWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    [self setupRootVC];
}

- (void)setupWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
}

- (void)setupRootVC {
    BDDBaseTabBarController *navi = [[BDDBaseTabBarController alloc] init];
    BDDLoginRegisterViewController *loginVC = [[BDDLoginRegisterViewController alloc] init];
    self.window.rootViewController = navi;
}



@end
