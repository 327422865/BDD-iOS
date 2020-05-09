//
//  BDDSearchResultsView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDSearchResultsView.h"
#import "BDDSearchResultsCell.h"

static NSString *cellID = @"BDDSearchResultsCell";
#define kmargin 80 //间距

@interface BDDSearchResultsView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *pickerBackV;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *salesVolumeBtn;
@property (nonatomic, strong) UIButton *priceBtn;

@end

@implementation BDDSearchResultsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = HEX_COLOR(@"#F4F4F4");
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.pickerBackV];
    [self addSubview:self.salesVolumeBtn];
    [self addSubview:self.priceBtn];
    [self addSubview:self.tableView];
    [self.pickerBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.height.equalTo(@40);
    }];
    [self.salesVolumeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pickerBackV.mas_centerY);
        make.left.equalTo(self.pickerBackV.mas_left).offset(80);
        make.width.equalTo(@60);
        make.height.equalTo(@10);
    }];
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(self.pickerBackV.mas_centerY);
          make.right.equalTo(self.pickerBackV.mas_right).offset(-80);
          make.width.equalTo(@60);
          make.height.equalTo(@10);
      }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(self.pickerBackV.mas_bottom).offset(10);
             make.left.right.equalTo(self);
             make.height.equalTo(@(SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - kmargin ));
         }];
}


#pragma mark -----------------UITableViewDelegate & UITableViewDataSource-----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.dataArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDSearchResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"");
}


#pragma mark -- Action
///价格排序
- (void)clickPriceAction {
    
}
///销量排序
- (void)clickSalesVolumeAction{
    
}

#pragma mark ------------ Lazy loading ---------------
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
        _tableView.backgroundColor = HEX_COLOR(@"#F4F4F4");
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 200;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
                //                self.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDSearchResultsCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIView *)pickerBackV {
    if (!_pickerBackV) {
        _pickerBackV = [[UIView alloc] init];
        _pickerBackV.backgroundColor = [UIColor whiteColor];
    }
    return _pickerBackV;
}

- (UIButton *)priceBtn {
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_priceBtn setImage:[UIImage imageNamed:@"dianzan_ing"] forState:UIControlStateNormal];
        [_priceBtn setTitleColor:HEX_COLOR(@"#FC4D13") forState:UIControlStateNormal];
        [_priceBtn addTarget:self action:@selector(clickPriceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceBtn;
}

- (UIButton *)salesVolumeBtn {
    if (!_salesVolumeBtn) {
        _salesVolumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_salesVolumeBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_salesVolumeBtn setImage:[UIImage imageNamed:@"dianzan_ing"] forState:UIControlStateNormal];
        [_salesVolumeBtn setTitleColor:HEX_COLOR(@"#FC4D13") forState:UIControlStateNormal];
        [_salesVolumeBtn addTarget:self action:@selector(clickSalesVolumeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _salesVolumeBtn;
}

@end
