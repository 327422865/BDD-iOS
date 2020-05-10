//
//  BDDClassifyMenuViewController.m
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDClassifyMenuViewController.h"
#import "BDDClassifyMenuCell.h"
#import "BDDClassifyModel.h"

static NSString *cellID = @"BDDClassifyMenuCell";
// 通知:加载详细分类信息
#define  TeacherCloumnCategoryDataWillLoadNotification  @"TeacherCloumnCategoryDataWillLoad"

@interface BDDClassifyMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation BDDClassifyMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor redColor];
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 取消滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    // 不允许下拉
    self.tableView.bounces = NO;
    
    [self.tableView registerClass:[BDDClassifyMenuCell class] forCellReuseIdentifier:cellID];
}

- (void)setTitleArray:(NSMutableArray *)titleArray {
    self.dataArray = titleArray;
    [self.tableView reloadData];
    // 选中第一个
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}


#pragma mark ----- UITableViewDelegae & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDClassifyMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    BDDClassifyModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDClassifyModel *lastSelectModel = self.dataArray[_selectedIndexPath.row];
    lastSelectModel.isSelect = NO;
    _selectedIndexPath = indexPath;
    BDDClassifyModel *model = self.dataArray[indexPath.row];
    model.isSelect = YES;
    [tableView reloadData];
    // 滚到顶端
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:TeacherCloumnCategoryDataWillLoadNotification object:[NSString stringWithFormat:@"%ld",indexPath.row]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc {
    DLog(@"");
}


@end
