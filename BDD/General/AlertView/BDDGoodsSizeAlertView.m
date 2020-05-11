//
//  BDDGoodsSizeAlertView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/11.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoodsSizeAlertView.h"

@interface BDDGoodsSizeAlertView ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconV;
/**主标题*/
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLab;
/**副标题*/
@property (weak, nonatomic) IBOutlet UILabel *subTiltleLab;
/**价格*/
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
/**会员图标*/
@property (weak, nonatomic) IBOutlet UIImageView *VipIconV;
/**划线价*/
@property (weak, nonatomic) IBOutlet UILabel *lineationPriceLab;
/**选择尺寸背景View*/
@property (weak, nonatomic) IBOutlet UIView *sizeBackView;
/**添加商品view*/
@property (weak, nonatomic) IBOutlet UIView *addNumberView;
/**确认按钮*/
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
/**商品数*/
@property (weak, nonatomic) IBOutlet UILabel *goodsNumberLab;
/**内容背景高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentView_LC_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentView_LC_bottom;
/**尺寸背景高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sizeBackView_LC_height;

/**商品数量*/
@property (nonatomic, assign) NSInteger goodsNumber;

@property (nonatomic, strong) UIButton *selectedBtn;


@end

@implementation BDDGoodsSizeAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [HEX_COLOR(@"#000000") colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    if (SCREEN_HEIGHT < 667.0f) {//iPhone 6以下
        self.contentView_LC_height.constant = 429;
    }else{
        self.contentView_LC_height.constant = 529;
    }
    
    if (iPhone_FaceID) {
           self.contentView_LC_bottom.constant = HOMEINDICATOR_HEIGHT;
       }else{
            self.contentView_LC_bottom.constant = 0;
       }
    
    self.goodsIconV.layer.cornerRadius = 4;
    self.goodsIconV.clipsToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 20;
    self.confirmBtn.clipsToBounds = YES;
    
    NSString *str = @"原价¥ 125";
    // 中划线
    NSDictionary *attribtDic =@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attribtDic];
    self.lineationPriceLab.attributedText = attribtStr;
    
    [self creatSelectSizeBtn];
    self.goodsNumber = 1;
    self.goodsNumberLab.text = [NSString stringWithFormat:@"%ld",(long)self.goodsNumber];
    self.addNumberView.backgroundColor = [UIColor whiteColor];
    self.addNumberView.layer.cornerRadius = 13;
    self.addNumberView.clipsToBounds = YES;
    self.addNumberView.layer.borderColor = HEX_COLOR(@"#979797").CGColor;
    self.addNumberView.layer.borderWidth = 0.5;
    
}

+ (instancetype)view {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)show {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIWindow *keyWindow = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if ([windowScene isKindOfClass:UIWindowScene.class]) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
            }
        }
    }else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    [keyWindow addSubview:self];
}

///创建选择尺寸按钮
- (void)creatSelectSizeBtn {
    NSArray *array =@[@"大码",@"中码",@"小码",@"特小码"];
    CGFloat marginX = 5;
    CGFloat marginY = 10;
    CGFloat height = 26;
    CGFloat margin_screenLeft = 15;//距离屏幕左边间距
    UIButton * markBtn;
    
    CGRect rect = self.frame;
    for (int i = 0; i < array.count; i++) {
        CGFloat width =  [self calculateString:array[i] Width:12] +30;
        UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.tag = i + 1;
        if (!markBtn) {
            tagBtn.frame = CGRectMake(marginX + margin_screenLeft, marginY, width, height);
        }else{
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > SCREEN_WIDTH - margin_screenLeft * 2) {
                tagBtn.frame = CGRectMake(marginX + margin_screenLeft, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
            }
        }
        [tagBtn setTitle:array[i] forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [tagBtn setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
        tagBtn.backgroundColor = HEX_COLOR(@"#F9F9F8");
        [self makeCornerRadius:13 borderColor:HEX_COLOR(@"#F9F9F8") layer:tagBtn.layer borderWidth:0.5];
        markBtn = tagBtn;
        
        [tagBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.sizeBackView addSubview:markBtn];
    }
    rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
    self.frame = rect;
    self.sizeBackView_LC_height.constant = rect.size.height;
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

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}


///确定
- (IBAction)confirmAction:(UIButton *)btn {
    DLog(@"");
}
///加
- (IBAction)addGoodsNumberAction:(UIButton *)btn {
    self.goodsNumber ++;
    self.goodsNumberLab.text = [NSString stringWithFormat:@"%ld",self.goodsNumber];
}
///减
- (IBAction)subtractGoodsNumberAction:(UIButton *)btn {
    if (self.goodsNumber > 1) {
        self.goodsNumber --;
        self.goodsNumberLab.text = [NSString stringWithFormat:@"%ld",self.goodsNumber];
    }
}

-(void)clickTo:(UIButton *)btn
{
    DLog(@"-----%ld",btn.tag);
    //    if (btn != self.selectedBtn) {
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    btn.backgroundColor = HEX_COLOR(@"#FFEEE7");
    [btn setTitleColor:HEX_COLOR(@"#F64F53") forState:UIControlStateNormal];
    [self makeCornerRadius:13 borderColor:HEX_COLOR(@"#FD5F1A") layer:btn.layer borderWidth:0.5];
    
    self.selectedBtn.backgroundColor = HEX_COLOR(@"#F9F9F8");
    [self.selectedBtn setTitleColor:HEX_COLOR(@"#333333") forState:UIControlStateNormal];
    [self makeCornerRadius:13 borderColor:HEX_COLOR(@"#F9F9F8") layer:self.selectedBtn.layer borderWidth:0.5];
    self.selectedBtn = btn;
    
    //    }
    
}


- (void)hideAction{
    [self removeFromSuperview];
}


@end
