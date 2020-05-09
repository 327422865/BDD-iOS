//
//  BDDBaseViewController.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDBaseViewController.h"

@interface BDDBaseViewController ()

@end

@implementation BDDBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorF6;
    [self setupBackButton];
//     [self.navigationController.navigationBar setClipsToBounds:YES];
}


@end
