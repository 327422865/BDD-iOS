//
//  BDDRelatedProjecHeadView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/10.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDRelatedProjecHeadView.h"

@implementation BDDRelatedProjecHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *tilteLab = [[UILabel alloc] init];
        tilteLab.text = @"相关专题";
        tilteLab.font = [UIFont fontWithName:@"PingFangSC" size: 16];
        tilteLab.textColor = HEX_COLOR(@"#343434");
        [self addSubview:tilteLab];
        [tilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(@22);
        }];
    }
    
    return self;
}

@end
