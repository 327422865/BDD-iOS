//
//  BDDClassifyDetailViewController.m
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDClassifyDetailViewController.h"
#import "BDDGoodsDetailsViewController.h"
#import "BDDClassifyDetailCell.h"
#import "BDDClassifyModel.h"

#import "BDDSearchViewController.h"
//分类主菜单宽度
#define SCCategoryMenuWidth 110
// 通知:加载详细分类信息
#define  TeacherCloumnCategoryDataWillLoadNotification  @"TeacherCloumnCategoryDataWillLoad"

static NSString *cellID = @"BDDClassifyDetailCell";
static CGFloat KMagin = 5.f;

@interface BDDClassifyDetailViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;
/**通过通知获取到一级分类index*/
@property(nonatomic,copy) NSString *index;
/**一级分类id*/
@property(nonatomic,copy) NSString *oneCategoryid;

@end

@implementation BDDClassifyDetailViewController

- (instancetype)init {
    return [super initWithCollectionViewLayout:[self flowLayout]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.layer.cornerRadius = 4;
    self.collectionView.clipsToBounds = YES;
     [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDClassifyDetailCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    //接收以及标题id
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadHeaderCategoryData:)
                                                 name:TeacherCloumnCategoryDataWillLoadNotification
                                               object:nil];
}

- (void)setSecondMArr:(NSMutableArray *)secondMArr {
    _secondMArr = secondMArr;
    self.dataArray = [self.secondMArr[0] mutableCopy];
    //一级的id
    [self.collectionView reloadData];
}

- (void)setOneMArr:(NSMutableArray *)oneMArr {
    _oneMArr = oneMArr;
    BDDClassifyModel *model = oneMArr[0];
    self.oneCategoryid = model.categoryid;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell的尺寸
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - SCCategoryMenuWidth - 10 - 30 - 32) / 3, 108);
    
    flowLayout.minimumLineSpacing = 8;
    flowLayout.minimumInteritemSpacing = 8;
    flowLayout.sectionInset = UIEdgeInsetsMake(11, 15, 8, 15);
    return flowLayout;
}

#pragma mark 2. 请求二级分类数据
//通知方法
- (void)loadHeaderCategoryData:(NSNotification *)notification {
    self.index = notification.object;
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:self.secondMArr[[self.index integerValue]]];
    [self.collectionView reloadData];
}


#pragma mark  ---- UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDDClassifyDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    BDDClassifyNextModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"");
    if (self.clickItemBlock) {
        self.clickItemBlock();
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    //分类数组
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (void)dealloc {
    DLog(@"");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
