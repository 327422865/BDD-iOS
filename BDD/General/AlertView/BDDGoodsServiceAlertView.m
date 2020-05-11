//
//  BDDGoodsServiceAlertView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/11.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDGoodsServiceAlertView.h"


@interface BDDGoodsServiceAlertView ()<UIGestureRecognizerDelegate>


@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentV_LC_botton;

@end

@implementation BDDGoodsServiceAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    if (iPhone_FaceID) {
        self.contentV_LC_botton.constant = HOMEINDICATOR_HEIGHT;
    }else{
         self.contentV_LC_botton.constant = 0;
    }
    self.backgroundColor = [HEX_COLOR(@"#000000") colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

+ (instancetype)show {
    BDDGoodsServiceAlertView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
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
    [keyWindow addSubview:view];
    return view;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}
- (IBAction)confirmAction:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)hideAction{
    [self removeFromSuperview];
}

@end
