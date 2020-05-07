//
//  BDDLoginRegisterViewController.m
//  BDD
//
//  Created by 彭英科 on 2020/5/6.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDLoginRegisterViewController.h"
#import "BDDInviteCodeAlertView.h"
#import "BDDUserAgreementAlertView.h"

@interface BDDLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation BDDLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (IBAction)loginAction:(UIButton *)sender {
    
//    BDDInviteCodeAlertView *inviteCodeAlertV = [BDDInviteCodeAlertView view];
//
//    [inviteCodeAlertV show];
    
    [BDDUserAgreementAlertView showWithContentStr:@"亲爱的用户，为保障您的权益，在注册流程中请阅读并理解“用户服务协议”的内容，以了解您的权利和义务（特别是加粗或下划线标注的内容）点击同意即表示您已充分阅读并接受以上协议的内容，阅读过程中，若对相关协议或其中条款有任何疑问，可咨询我们的平台客服，我们将严格按照协议内容执行，尽力为您提供更好的服务"];
    
}


@end
