//
//  BDDTodaySelectionView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/7.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDTodaySelectionView.h"
#import "BDDTodaySelectionCell.h"


static NSString *cellID = @"BDDTodaySelectionCell";

@interface BDDTodaySelectionView ()<UITableViewDelegate,UITableViewDataSource>

/**标题*/
@property (nonatomic, strong) UILabel *tilteLab;
/**更多btn*/
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation BDDTodaySelectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel * titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont fontWithName:@"PingFangSC" size: 20];
    titleLab.textColor = HEX_COLOR(@"#343434");
    titleLab.text = @"今日优选";
    self.tilteLab = titleLab;
    [self addSubview:self.tilteLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    [btn setTitleColor:HEX_COLOR(@"#999999") forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    self.moreBtn = btn;
    [self addSubview: self.moreBtn];
    
    [self addSubview:self.tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.tilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.equalTo(@28);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tilteLab.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-11);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tilteLab.mas_bottom).offset(-5);
        make.right.left.equalTo(self);
        make.height.equalTo(@228);
    }];
    
    
}

#pragma mark -----------------UITableViewDelegate & UITableViewDataSource-----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
     return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDDTodaySelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineView.hidden = indexPath.row == 1 ? YES : NO;
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      DLog(@"");
}

#pragma mark ------------ Action ---------------
- (void)moreAction {
    DLog(@"");
}


#pragma mark ------------ Lazy loading ---------------
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
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
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDDTodaySelectionCell class]) bundle:nil] forCellReuseIdentifier:cellID];
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


@end
