//
//  BDDShopHomeViewController.m
//  BDD
//
//  Created by 彭英科 on 2020/5/12.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDShopHomeViewController.h"
#import "BDDGoodsDetailsViewController.h"

#import "BDDShopHomeHeadView.h"
#import "BDDShopHomeCell.h"
#import "BDDNavigationBar.h"


static NSString * const CellID = @"BDDShopHomeCell";
static NSString * const HeadID = @"BDDShopHomeHeadView";

@interface BDDShopHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) BDDNavigationBar *navigationBar;
/** 导航栏右边按钮 */
@property (nonatomic, strong) UIButton *shareBtn;
/** 导航栏返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BDDShopHomeHeadView *headView;

@end

@implementation BDDShopHomeViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
    [self setupNavigationView];
}

- (void)setupNavigationView{
    self.navigationBar = [[BDDNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) leftBtns:^(UIButton * _Nonnull Lbtn1, UIButton * _Nonnull Lbtn2) {
          Lbtn1.bounds = CGRectMake(0, 0, 32, 32);
          [Lbtn1 setImage:[UIImage imageNamed:@"fanhui-baise"] forState:UIControlStateNormal];
          [Lbtn1 addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
          self.backBtn = Lbtn1;
      } rightBtns:^(UIButton * _Nonnull Rbtn1, UIButton * _Nonnull Rbtn2) {
          
          Rbtn1.bounds = CGRectMake(0, 0, 32, 32);
          [Rbtn1 setImage:[UIImage imageNamed:@"fenxiang-baise"] forState:UIControlStateNormal];
          [Rbtn1 addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
          self.shareBtn = Rbtn1;
      }];
     self.navigationBar.backgroundColor = [UIColor clearColor];
       self.navigationBar.navigationType = BDDNavigationBarType_ClearBackgroud;
       [self.view addSubview:self.navigationBar];
}

- (void)setupUI{
    [self.view addSubview:self.collectionView];
}

#pragma mark ----------------- UICollectionViewDataSource & UICollectionViewDelegate-----------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    }else{
//      return 10;
//    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BDDShopHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    return cell;
}

///头部 size
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 2/3 + 168 + 10 + 50);
}

///cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat kmargin = 27;
    return  CGSizeMake((SCREEN_WIDTH - kmargin) / 2.0, 265);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            self.headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeadID forIndexPath:indexPath];
            return self.headView;
        }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BDDGoodsDetailsViewController *VC = [BDDGoodsDetailsViewController new];
    [self.navigationController pushViewController:VC animated:YES];
 
}

#pragma mark - ---------------- actions -----------------------

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction {
    
}


#pragma mark ------------ Lazy loading ---------------
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 7.0;
        layout.sectionInset = UIEdgeInsetsMake(10, 10.0, 10.0, 10.0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor =  HEX_COLOR(@"#F4F4F4");
        // 取消滚动条
        _collectionView.showsVerticalScrollIndicator = NO;
        // 不允许下拉
        _collectionView.bounces = NO;
        //        _collectionView.ly_emptyView = [ZXEmptyView diyEmptyViewWithImageType:EmptyImageTypeNoFriend titleStr:nil detailStr:@"没有推荐内容~"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDShopHomeCell class]) bundle:nil] forCellWithReuseIdentifier:CellID];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDShopHomeHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadID];
    }
    
    
    return _collectionView;
}



@end
