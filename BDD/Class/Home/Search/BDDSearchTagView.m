//
//  BDDSearchTagView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDSearchTagView.h"

@interface BDDSearchTagView ()

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation BDDSearchTagView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
}

+ (instancetype)view {
    
 return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)setContentStr:(NSString *)contentStr{
    self.contentLab.text = contentStr;
}

@end
