//
//  BDDUserAgreementAlertView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/7.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDUserAgreementAlertView.h"

@interface BDDUserAgreementAlertView ()

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation BDDUserAgreementAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [HEX_COLOR(@"000000") colorWithAlphaComponent:0.5];
//      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
//      [self addGestureRecognizer:tap];
}

+ (void)showWithContentStr:(NSString *)string {
    BDDUserAgreementAlertView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    [view setupAgreementAlertViewWithContentStr:string];
}

- (instancetype)setupAgreementAlertViewWithContentStr:(NSString *)string {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.contentLab.attributedText = [self setAgreementAttreWithStr:string];
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
    return self;
}

- (NSMutableAttributedString *)setAgreementAttreWithStr:(NSString *)str
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(@"666666") range:NSMakeRange(0,str.length)];
    [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,str.length)];
    [attri addAttribute:NSLinkAttributeName value:@"userAgreement://" range:[[attri string] rangeOfString:@"用户服务协议"]];
    [attri addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(@"FD651C") range:[[attri string] rangeOfString:@"用户服务协议"]];
    return attri;
}

- (IBAction)agreeAction:(UIButton *)sender {
     [self removeFromSuperview];
}

/////隐藏
//- (void)hideAction {
////     [self removeFromSuperview];
//}


@end
