//
//  BDDSearchHistoryView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDSearchHistoryView.h"


@interface BDDSearchHistoryView ()
/**删除*/
@property (nonatomic, strong) UIButton *deleteBtn;
/**标题*/
@property (nonatomic, strong) UILabel *titleLab;
/**提示*/
@property (nonatomic, strong) UILabel *hintLab;

@end

@implementation BDDSearchHistoryView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.tag = 0;
    [self.deleteBtn setImage:[UIImage imageNamed:@"quanzishezhi_link"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.hintLab = [[UILabel alloc] init];
    self.hintLab.text = @"无搜索历史";
    self.hintLab.font =  [UIFont systemFontOfSize:14];
    self.hintLab.textColor = HEX_COLOR(@"#999999");
    self.hintLab.hidden = YES;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.hintLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(11);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(@21);
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLab.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(@14);
        make.height.equalTo(@15);
    }];
    [self.hintLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.equalTo(@15);
    }];
}

- (void)setArr:(NSArray *)arr {
    _arr = arr;
    CGFloat kmargin = 47;//标题高度及间距
    CGFloat marginX = 5;
    CGFloat marginY = 10;
    CGFloat height = 26;
    CGFloat margin_screenLeft = 15;//距离屏幕左边间距
    UIButton * markBtn;
    
    CGRect rect = self.frame;
    if (_arr.count) {
        for (int i = 0; i < _arr.count; i++) {
            CGFloat width =  [self calculateString:_arr[i] Width:12] +30;
            UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tagBtn.tag = i + 1;
            if (!markBtn) {
                tagBtn.frame = CGRectMake(marginX + margin_screenLeft, marginY + kmargin, width, height);
            }else{
                if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > SCREEN_WIDTH - margin_screenLeft * 2) {
                    tagBtn.frame = CGRectMake(marginX + margin_screenLeft, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
                }else{
                    tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
                }
            }
            [tagBtn setTitle:_arr[i] forState:UIControlStateNormal];
            tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [tagBtn setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
            tagBtn.backgroundColor = HEX_COLOR(@"#F7F7F7");
            [self makeCornerRadius:13 borderColor:[UIColor clearColor] layer:tagBtn.layer borderWidth:0];
            markBtn = tagBtn;
            
            [tagBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:markBtn];
        }
        self.hintLab.hidden = YES;
        rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
    }else{
        self.hintLab.hidden = NO;
        rect.size.height = 70;
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]] && view.tag > 0 ) {
                [view removeFromSuperview];
            }
        }
    }
    self.frame = rect;
}

-(void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth
{
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = borderWidth;
}

-(CGFloat)calculateString:(NSString *)str Width:(NSInteger)font
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}


-(void)clickTo:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(searchHistoryViewhandleSelectTag:)]) {
        [self.delegate searchHistoryViewhandleSelectTag:sender.titleLabel.text];
    }
}

- (void)deleteAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchHistoryViewDeleteHistoryTag)]) {
        [self.delegate searchHistoryViewDeleteHistoryTag];
    }
}

#pragma mark -- TagViewDelegate
-(void)handleSelectTag:(NSString *)keyWord {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchHistoryViewhandleSelectTag:)]) {
        [self.delegate searchHistoryViewhandleSelectTag:keyWord];
    }
}

#pragma mark ------------ Lazy loading ---------------
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"搜索历史";
        _titleLab.font =  [UIFont fontWithName:@"PingFangSC" size: 15];
        _titleLab.textColor = HEX_COLOR(@"#333333");
    }
    return _titleLab;
}



@end
