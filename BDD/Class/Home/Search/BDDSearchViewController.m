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
#import "UIButton+HQCustomIcon.h"
#import "BDDSearchTagView.h"



@interface BDDSearchViewController ()<UITextFieldDelegate,SearchHistoryViewDelegate>

@property (nonatomic, strong) UIView *searchBackV;
@property (nonatomic, strong) UITextField *textFT;
@property (nonatomic, strong) NSMutableArray *tagArray;

/** 搜索结果view*/
@property (nonatomic, strong) BDDSearchResultsView *resultsView;
/** 搜索历史view*/
@property (nonatomic, strong) BDDSearchHistoryView *historyView;

//@property (nonatomic, strong) UIButton *tagBtn;

@property (nonatomic, strong) BDDSearchTagView *tagBtn;


@end

@implementation BDDSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation {
    //搜索框背景
    UIView *searchBackV = [[UIView alloc] init];
    searchBackV.backgroundColor =HEX_COLOR(@"#F0F0F0");
    searchBackV.frame = CGRectMake(37, 5, SCREEN_WIDTH - 37 - 53, 30);
    searchBackV.layer.cornerRadius = 15;
    searchBackV.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchBackV)];
    [searchBackV addGestureRecognizer:tap];
    self.searchBackV = searchBackV;
    self.navigationItem.titleView = self.searchBackV;
    
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_home"]];
    searchIcon.frame = CGRectMake(11, 8, 16, 15);
    [self.searchBackV  addSubview:searchIcon];
    
    self.textFT.frame = CGRectMake(35, 0, SCREEN_WIDTH - 37 - 53 - 40, 30);
    [self.searchBackV  addSubview:self.textFT];
    
//    self.tagBtn.frame = CGRectMake(35, 5, 100, 20);
//     [self.tagBtn setIconInRightWithSpacing:5];
//    [self.searchBackV addSubview:self.tagBtn];
    self.tagBtn = [BDDSearchTagView view];
    self.tagBtn.frame = CGRectMake(35, 5, 100, 20);
    [self.searchBackV addSubview:self.tagBtn];
    
    
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
    self.tagArray = [NSMutableArray arrayWithArray:@[@"锤子",@"见过",@"膜拜单车",@"微信支付",@"Q",@"王者荣耀",@"蓝淋网"]];
    self.historyView.arr = self.tagArray;
    [self.view addSubview:self.historyView];
    
    
}

- (void)textFieldDidChanged:(UITextField *)textField {
    NSString *text = textField.text;
    if (!ISEMPTYSTR(text)) {
        [self.tagArray addObject:text];
        self.historyView.arr = self.tagArray;
    }
}


- (void)textFieldDidEnd:(UITextField *)textField {
    self.textFT.hidden = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.textFT.hidden = YES;
}

- (void)clickAction {
    self.tagBtn.hidden = YES;
    self.textFT.hidden = NO;
    [self.textFT becomeFirstResponder];
}

- (void)clickSearchBackV {
    if (self.tagBtn.hidden == NO) {
        self.tagBtn.hidden = YES;
    }
    self.textFT.hidden = NO;
    [self.textFT becomeFirstResponder];
}


#pragma mark --SearchHistoryViewDelegate
//处理点击标签
- (void)searchHistoryViewhandleSelectTag:(NSString *)keyWord{
    self.textFT.hidden = YES;
    [self.textFT resignFirstResponder];
//    [self.tagBtn setTitle:keyWord forState:UIControlStateNormal];
    self.tagBtn.contentStr = keyWord;
    self.tagBtn.hidden = NO;
    CGFloat bt_w = [BDDTool sizeOfstring:keyWord font:[UIFont systemFontOfSize:12] maxW:800].width + 40;
    self.tagBtn.frame = CGRectMake(35, 5, bt_w, 20);
//    [self showHUD];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.resultsView.hidden = NO;
//            self.historyView.hidden = YES;
//        [self hideHUD];
//    });
    
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
        _textFT.returnKeyType = UIReturnKeySearch;
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

//- (UIButton *)tagBtn {
//    if (!_tagBtn) {
//        _tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _tagBtn.backgroundColor = HEX_COLOR(@"#939393");
//        _tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        _tagBtn.layer.cornerRadius = 10;
//        _tagBtn.clipsToBounds = YES;
//        _tagBtn.hidden = YES;
//        [_tagBtn setTitleColor:HEX_COLOR(@"#FFFFFF") forState:UIControlStateNormal];
//        [_tagBtn setTitle:@"阿斯d的" forState:UIControlStateNormal];
//        [_tagBtn setImage:[UIImage imageNamed:@"fanhui-baise"] forState:UIControlStateNormal];
//        [_tagBtn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _tagBtn;
//}


//- (BDDSearchResultsView *)resultsView {
//    if (_resultsView) {
//        _resultsView = [[BDDSearchResultsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////        _SearchResultsV = [[BDDSearchResultsView alloc] init];
//
//    }
//    return _resultsView;
//}



@end
