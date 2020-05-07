//
//  BDDInviteCodeAlertView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/7.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDInviteCodeAlertView.h"

@interface BDDInviteCodeAlertView ()
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation BDDInviteCodeAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [HEX_COLOR(@"000000") colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    [self addGestureRecognizer:tap];
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

#pragma mark -- Action
///提交
- (IBAction)submitAction:(UIButton *)btn {
    
    [self removeFromSuperview];
}
///隐藏
- (void)hideAction {
     [self removeFromSuperview];
}

- (void)dealloc{
    DLog(@"");
}

@end
