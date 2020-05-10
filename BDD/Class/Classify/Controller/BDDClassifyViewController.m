//
//  BDDClassifyViewController.m
//  BDD
//
//  Created by 彭英科 on 2020/5/6.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDClassifyViewController.h"
#import "BDDClassifyMenuViewController.h"
#import "BDDClassifyDetailViewController.h"
#import "BDDGoodsDetailsViewController.h"
#import "BDDClassifyModel.h"
#import "UIView+MJExtension.h"

// 分类主菜单宽度
#define ClassifyMenuWidth 110

@interface BDDClassifyViewController ()

/**分类主菜单 */
@property (nonatomic, strong) BDDClassifyMenuViewController *classifyMenuVC;
/**详细分类列表 */
@property (nonatomic, strong) BDDClassifyDetailViewController *classifyDetailVC;
/**所有数据 */
@property (nonatomic, strong) NSMutableArray *oneCategoryMArr;
/**右边数据 */
@property (nonatomic, strong) NSMutableArray *twoCategoryMArr;

@end

@implementation BDDClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类";
    self.view.backgroundColor = HEX_COLOR(@"#F4F4F4");
    //添加分类主菜单
    [self addClassifyMenuView];
    //添加详细分类列表
    [self addClassifyDetailView];
    //加载数据
    [self createData];
}

- (void)createData {
    
    //    // 创建信号量
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //    // 创建全局并行
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_group_t group = dispatch_group_create();
    //
    //    dispatch_group_async(group, queue, ^{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *array = dict[@"data"][@"categories"];
    for (NSDictionary *dict in array) {
        BDDClassifyModel *model = [[BDDClassifyModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.oneCategoryMArr addObject:model];
        NSArray *array = dict[@"subcategories"];
        NSMutableArray *collectionArr = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            BDDClassifyNextModel *courseModel = [[BDDClassifyNextModel alloc] init];
            [courseModel setValuesForKeysWithDictionary:dic];
            [collectionArr addObject:courseModel];
        }
        [self.twoCategoryMArr addObject:collectionArr];
    }
    
    self.classifyMenuVC.titleArray = self.oneCategoryMArr;
    self.classifyDetailVC.secondMArr = self.twoCategoryMArr;
    self.classifyDetailVC.oneMArr = self.oneCategoryMArr;
    
    //        dispatch_semaphore_signal(semaphore);
    //
    //    });
    //
    //    dispatch_group_notify(group, queue, ^{
    //        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        });
    //    });
    
    
    
}

#pragma mark - 添加一级分类菜单
- (void)addClassifyMenuView {
    
    [self.view addSubview:self.classifyMenuVC.tableView];
    [self.classifyMenuVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(@(ClassifyMenuWidth));
        make.height.equalTo(@(SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEHGHT));
    }];
}

#pragma mark - 添加详细分类列表
- (void)addClassifyDetailView {
    [self.view addSubview:self.classifyDetailVC.collectionView];
    [self.classifyDetailVC.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.classifyMenuVC.tableView.mas_right).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - ClassifyMenuWidth - 10));
        make.height.equalTo(@(SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEHGHT));
    }];
}

#pragma mark - 懒加载

- (BDDClassifyMenuViewController *)classifyMenuVC {
    if (_classifyMenuVC == nil) {
        _classifyMenuVC = [[BDDClassifyMenuViewController alloc] init];
    }
    return _classifyMenuVC;
}

- (BDDClassifyDetailViewController *)classifyDetailVC {
    weakify(self);
    if (_classifyDetailVC == nil) {
        _classifyDetailVC = [[BDDClassifyDetailViewController alloc] init];
        _classifyDetailVC.clickItemBlock = ^{
            strongify(self);
            BDDGoodsDetailsViewController *VC = [BDDGoodsDetailsViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        };
    }
    return _classifyDetailVC;
}

-(NSMutableArray *)oneCategoryMArr {
    if (_oneCategoryMArr == nil) {
        _oneCategoryMArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _oneCategoryMArr;
}

-(NSMutableArray *)twoCategoryMArr {
    if (_twoCategoryMArr == nil) {
        _twoCategoryMArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _twoCategoryMArr;
}


@end
