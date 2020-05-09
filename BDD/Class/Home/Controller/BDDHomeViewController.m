//
//  BDDHomeViewController.m
//  BDDMerchant
//
//  Created by 彭英科 on 2020/4/24.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDHomeViewController.h"
#import "BDDHomeHeadView.h"
#import "BDDHomeCollectionCell.h"
#import "BDDSearchViewController.h"

static NSString *const CellID = @"cell";
static NSString *const headID = @"headID";

@interface BDDHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BDDHomeHeadView *headView;
/** 搜索按钮 */
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BDDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation{
    self.searchBtn.frame = CGRectMake(3, 15, SCREEN_WIDTH - 30, 30);
    self.navigationItem.titleView = self.searchBtn;
}

- (void)setupUI {
    [self.view addSubview:self.collectionView];
}


#pragma mark ----------------- UICollectionViewDataSource & UICollectionViewDelegate-----------------------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.dataArray.count;
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BDDHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
   return cell;
}

///头部size
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 720);
    return size;
}

///cellsize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake((SCREEN_WIDTH - 27) / 2.0, 265);
       return size;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headID forIndexPath:indexPath];
        return self.headView;
    }
    return nil;
}



#pragma mark --- Action
//搜索
- (void)searchClick{
    BDDSearchViewController *searchVC = [[BDDSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark ------------ Lazy loading ---------------
- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.backgroundColor = HEX_COLOR(@"#F2F2F2");
        _searchBtn.layer.cornerRadius = 15;
        _searchBtn.layer.masksToBounds = YES;
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setImage:[UIImage imageNamed:@"search_home"] forState:UIControlStateNormal];
        _searchBtn.adjustsImageWhenHighlighted = NO;// 取消图片的高亮状态
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;// 水平左对齐
        _searchBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;// 垂直居中对齐
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);//
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, _searchBtn.imageView.frame.size.width + 10, 0, 0);
    }
    return _searchBtn;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 7.0;
        layout.minimumInteritemSpacing = 7.0;
        layout.sectionInset = UIEdgeInsetsMake(7.0, 10.0, 7.0, 10.0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEHGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor =  HEX_COLOR(@"#F4F4F4");
//        _collectionView.ly_emptyView = [ZXEmptyView diyEmptyViewWithImageType:EmptyImageTypeNoFriend titleStr:nil detailStr:@"没有推荐内容~"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDHomeCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:CellID];
        //注册头部
        [_collectionView registerClass:[BDDHomeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}





@end
