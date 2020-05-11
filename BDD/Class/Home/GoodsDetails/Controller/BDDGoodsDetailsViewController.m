//
//  BDDGoodsDetailsViewController.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoodsDetailsViewController.h"

#import "BDDGoodsDetailsHeadView.h"
#import "BDDRelatedProjecHeadView.h"
#import "BDDPictureInfoHeadView.h"
#import "BDDGoodsSpecificationInforCell.h"
#import "BDDGoodsPriceInforCell.h"
#import "BDDMerchantsInforCell.h"
#import "BDDRelatedProjectCell.h"
#import "BDDGoddsPictureInforCell.h"
#import "BDDGoodsCommentCell.h"

#import "BDDGoodsSizeAlertView.h"

static NSString * const cellID = @"CELL";
static NSString * const PriceInforCellID = @"BDDGoodsPriceInforCell";//价格信息cell
static NSString * const SpecificationInforCellID = @"BDDGoodsSpecificationInforCell";//规格信息cell
static NSString * const MerchantsInforCellCellID = @"BDDMerchantsInforCell";//商家信息cell
static NSString * const RelatedProjectCellID = @"BDDRelatedProjectCell";//相关专题cell
static NSString * const PictureInforCellID = @"BDDGoddsPictureInforCell";//图文详情cell
static NSString * const CommentCellID = @"BDDGoodsCommentCell";//评论cell


static NSString * const HEADID = @"HEADID";
static NSString * const relatedProjecHeadVID = @"relatedProjecHeadVID";
static NSString * const PictureInfoHeadVID = @"BDDPictureInfoHeadView";

@interface BDDGoodsDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BDDGoodsDetailsHeadView *headView;
@property (nonatomic, strong) BDDRelatedProjecHeadView *relatedProjecHeadV;
@property (nonatomic, strong) BDDPictureInfoHeadView *pictureInfoHeadV;
@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger currentIndexPath;
@property (nonatomic, strong)  UILabel *labe;

@end

@implementation BDDGoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    [self setupNavigationView];
    [self setupUI];
}

- (void)setupNavigationView{
    self.navigationItem.title = @"商品详情";
    [self setupRightButtonWithImageName:@"fenxiang" action:@selector(shareAction)];
}

- (void)setupUI {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.buyBtn];
    
    if (iPhone_FaceID) {
        [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-HOMEINDICATOR_HEIGHT);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(45));
        }];
    }else{
        [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(45));
        }];
    }
    
    
}

#pragma mark ----------------- UICollectionViewDataSource & UICollectionViewDelegate-----------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 5) {
        return 10;
    }else if (section == 4){
        return 2;
    }
    else{
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {//价格信息cell
        BDDGoodsPriceInforCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PriceInforCellID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){//规格信息cell
        BDDGoodsSpecificationInforCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SpecificationInforCellID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 2){//商家信息cell
        BDDMerchantsInforCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MerchantsInforCellCellID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 3){//商品评论cell
        BDDGoodsCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CommentCellID forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 4){//图文详情cell
        BDDGoddsPictureInforCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PictureInforCellID forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 5){//相关专题cell
        BDDRelatedProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RelatedProjectCellID forIndexPath:indexPath];
        return cell;
    }else{
        return nil;
    }
    
}

///头部 size
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 2/3);
    }else if (section == 4){
        return  CGSizeMake(SCREEN_WIDTH, 50);
    }
    else if (section == 5){
        return  CGSizeMake(SCREEN_WIDTH, 50);
    }else{
        return  CGSizeMake(SCREEN_WIDTH, 0);
    }
}

///cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return  CGSizeMake(SCREEN_WIDTH, 128);
    }else if (indexPath.section == 1){
        return  CGSizeMake(SCREEN_WIDTH, 150);
    }else if (indexPath.section == 2){
        return  CGSizeMake(SCREEN_WIDTH, 117);
    }else if (indexPath.section == 3){
        return  CGSizeMake(SCREEN_WIDTH, 366);
    }else if (indexPath.section == 4){
        return  CGSizeMake(SCREEN_WIDTH, 300);
    }else if (indexPath.section == 5){
        return  CGSizeMake((SCREEN_WIDTH - 27) / 2.0, 265);
    }
    return  CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            self.headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADID forIndexPath:indexPath];
            self.headView.imageArray = @[@"three_6",@"three_6",@"three_6",@"three_6",@"three_6",@"three_6"];
            return self.headView;
        }else if (indexPath.section == 4){
            self.pictureInfoHeadV =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:PictureInfoHeadVID forIndexPath:indexPath];
            return  self.pictureInfoHeadV;
        }else if (indexPath.section == 5){
            self.relatedProjecHeadV =[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:RelatedProjectCellID forIndexPath:indexPath];
            return  self.relatedProjecHeadV;
        }
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    DLog(@"第%ld组---第%ld行",(long)indexPath.section,(long)indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取当前显示的cell的下标
    NSIndexPath *firstIndexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    // 赋值给记录当前坐标的变量
    //    self.currentIndexPath = indexPathNow;
    //    // 更新底部的数据
    DLog(@"-----%ld",(long)firstIndexPath.section);
}

#pragma mark -- Action
- (void)shareAction {
    DLog(@"");
}

- (void)buyAction {
    DLog(@"");
    BDDGoodsSizeAlertView *sizeAlerV = [BDDGoodsSizeAlertView view];
    [sizeAlerV show];
}

#pragma mark ------------ Lazy loading ---------------
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 7.0;
        layout.minimumInteritemSpacing = 7.0;
        layout.sectionInset = UIEdgeInsetsMake(0, 10.0, 10.0, 10.0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - 45 - HOMEINDICATOR_HEIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor =  HEX_COLOR(@"#F4F4F4");
        // 取消滚动条
        _collectionView.showsVerticalScrollIndicator = NO;
        // 不允许下拉
        _collectionView.bounces = NO;
        //        _collectionView.ly_emptyView = [ZXEmptyView diyEmptyViewWithImageType:EmptyImageTypeNoFriend titleStr:nil detailStr:@"没有推荐内容~"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //商品价格信息cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDGoodsPriceInforCell class]) bundle:nil] forCellWithReuseIdentifier:PriceInforCellID];
        //商品规格信息cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDGoodsSpecificationInforCell class]) bundle:nil] forCellWithReuseIdentifier:SpecificationInforCellID];
        //商家规格信息cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDMerchantsInforCell class]) bundle:nil] forCellWithReuseIdentifier:MerchantsInforCellCellID];
        //相关专题cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDRelatedProjectCell class]) bundle:nil] forCellWithReuseIdentifier:RelatedProjectCellID];
        //图文详情cell
        [_collectionView registerClass:[BDDGoddsPictureInforCell class] forCellWithReuseIdentifier:PictureInforCellID];
        //评论cell
        [_collectionView registerClass:[BDDGoodsCommentCell class] forCellWithReuseIdentifier:CommentCellID];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        
        //注册头部
        [_collectionView registerClass:[BDDGoodsDetailsHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADID];
        //注册图文详情头部
        [_collectionView registerClass:[BDDPictureInfoHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PictureInfoHeadVID];
        //注册相关专题头部
        [_collectionView registerClass:[BDDRelatedProjecHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:RelatedProjectCellID];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UILabel *)labe{
    if (!_labe) {
        _labe = [[UILabel alloc] init];;
    }
    return _labe;
}

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC" size:16];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyBtn.backgroundColor = HEX_COLOR(@"#FD7020");
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyBtn;
}


@end
