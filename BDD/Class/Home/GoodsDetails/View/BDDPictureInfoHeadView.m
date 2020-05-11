//
//  BDDPictureInfoHeadView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDPictureInfoHeadView.h"

@implementation BDDPictureInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *tilteLab = [[UILabel alloc] init];
        tilteLab.text = @"图文详情";
        tilteLab.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        tilteLab.textColor = HEX_COLOR(@"#343434");
        [self addSubview:tilteLab];
        [tilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(15);
            make.height.equalTo(@22);
        }];
    }
    return self;
}

@end
