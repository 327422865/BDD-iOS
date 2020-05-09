//
//  BDDSearchViewController.m
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDSearchViewController.h"
#import "BDDSearchResultsView.h"
#import "BDDSearchHistoryView.h"
#import "BDDSearchTagView.h"
#import "UIButton+HQCustomIcon.h"

@interface BDDSearchViewController ()<UITextFieldDelegate,SearchHistoryViewDelegate>

@property (nonatomic, strong) UIView *searchBackV;
@property (nonatomic, strong) UITextField *textFT;
@property (nonatomic, strong) NSMutableArray *tagArray;

/** 搜索结果view*/
@property (nonatomic, strong) BDDSearchResultsView *resultsView;
/** 搜索历史view*/
@property (nonatomic, strong) BDDSearchHistoryView *historyView;

@property (nonatomic, strong) BDDSearchTagView *tagView;


@end

@implementation BDDSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.searchBackV.hidden = NO;
    [self.textFT becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchBackV.hidden = YES;
    [self.textFT resignFirstResponder];
}


- (void)setupNavigation {
    //导航栏右边按钮
    [self setupRightButtonWithTitle:@"取消" action:@selector(cancelAction)];
    //搜索框背景
    UIView *searchBackV = [[UIView alloc] init];
    searchBackV.backgroundColor = HEX_COLOR(@"#F0F0F0");
    searchBackV.frame = CGRectMake(30, 5, SCREEN_WIDTH - 50 - 100, 30);
    searchBackV.layer.cornerRadius = 15;
    searchBackV.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchBackV)];
    [searchBackV addGestureRecognizer:tap];
    self.searchBackV = searchBackV;
    [self.navigationController.navigationBar addSubview:searchBackV];
    [searchBackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.navigationController.navigationBar);
        make.left.equalTo(self.navigationController.navigationBar.mas_left).offset(40);
        make.right.equalTo(self.navigationController.navigationBar.mas_right).offset(-70);
        make.height.equalTo(@30);
    }];
    //搜索图标
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_home"]];
    [self.searchBackV addSubview:searchIcon];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBackV.mas_centerY);
        make.left.equalTo(self.searchBackV.mas_left).offset(15);
        make.width.equalTo(@16);
        make.height.equalTo(@15);
    }];
    
    //搜索框中的标签
    self.tagView = [BDDSearchTagView view];
    self.tagView.hidden = YES;
    [self.searchBackV addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBackV.mas_centerY);
        make.left.equalTo(searchIcon.mas_right).offset(5);
        make.width.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    //输入框
    [self.searchBackV addSubview:self.textFT];
    [self.self.textFT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchBackV.mas_centerY);
        make.left.equalTo(searchIcon.mas_right).offset(10);
        make.right.equalTo(self.searchBackV.mas_right).offset(-15);
        make.height.equalTo(@30);
    }];
}

- (void)setupUI {
    //搜索结果View
    self.resultsView = [[BDDSearchResultsView alloc] init];
    self.resultsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.resultsView];
    self.resultsView.hidden = YES;
    //搜索历史View
    self.historyView = [[BDDSearchHistoryView alloc] init];
    self.historyView.delegate = self;
    self.historyView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultKeySearchHistory];
//    self.tagArray = [NSMutableArray arrayWithArray:@[@"锤子",@"见过",@"膜拜单车",@"微信支付",@"Q",@"王者荣耀",@"蓝淋网"]];
    self.historyView.arr = arr;
    [self.view addSubview:self.historyView];
}

- (void)textFieldDidChanged:(UITextField *)textField {
    NSString *text = textField.text;
    if (!ISEMPTYSTR(text)) {
        [self.tagArray addObject:text];
        self.historyView.arr = self.tagArray;
        [[NSUserDefaults standardUserDefaults] setObject:self.tagArray forKey:UserDefaultKeySearchHistory];
    }
}


- (void)textFieldDidEnd:(UITextField *)textField {
    self.textFT.hidden = YES;
}


- (void)clickAction {
    self.tagView.hidden = YES;
    self.textFT.hidden = NO;
    [self.textFT becomeFirstResponder];
}

- (void)clickSearchBackV {
    if (self.tagView.hidden == NO) {
        self.tagView.hidden = YES;
    }
    self.textFT.hidden = NO;
    [self.textFT becomeFirstResponder];
}

- (void)cancelAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --SearchHistoryViewDelegate
//处理点击标签
- (void)searchHistoryViewhandleSelectTag:(NSString *)keyWord{
     self.historyView.noNetWorkHintV.hidden = YES;
    self.textFT.hidden = YES;
    [self.textFT resignFirstResponder];
    self.tagView.contentStr = keyWord;
    self.tagView.hidden = NO;
    CGFloat tagView_W = [BDDTool sizeOfstring:keyWord font:[UIFont systemFontOfSize:12] maxW:800].width + 40;
    [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tagView_W));
    }];
    
    [self showHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.resultsView.hidden = NO;
        self.historyView.hidden = YES;
        [self hideHUD];
    });
    
    DLog(@"%@",keyWord);
}
//删除历史标签
- (void)searchHistoryViewDeleteHistoryTag {
    [self.tagArray removeAllObjects];
    self.historyView.arr = self.tagArray;
}


#pragma mark ------------ Lazy loading ---------------
- (UITextField *)textFT {
    if (!_textFT) {
        _textFT = [[UITextField alloc] init];
        _textFT.layer.cornerRadius = 2;
        _textFT.layer.masksToBounds = YES;
        _textFT.font = [UIFont systemFontOfSize:14];
        _textFT.textColor = MAIN_BLACK_COLOR;
        _textFT.placeholder = @"输入关键字进行搜索";
        _textFT.clearButtonMode = UITextFieldViewModeAlways;
        _textFT.leftViewMode = UITextFieldViewModeAlways;
        //        _textFT.returnKeyType = UIReturnKeySearch;
        _textFT.delegate = self;
        [_textFT becomeFirstResponder];
        [_textFT addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [_textFT addTarget:self action:@selector(textFieldDidEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return _textFT;
}

- (NSMutableArray *)tagArray {
    if (!_tagArray) {
        _tagArray = [NSMutableArray new];
    }
    return _tagArray;
}



@end
