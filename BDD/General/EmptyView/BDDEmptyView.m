//
//  BDDEmptyView.m
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDEmptyView.h"

@implementation BDDEmptyView

+ (instancetype)diyNoNetworkEmptyWithBtnClickBlock:(LYActionTapBlock)btnClickBlock {
   BDDEmptyView *emptyView = [BDDEmptyView emptyActionViewWithImageStr:@"NoNetwork" titleStr:nil detailStr:@"您的手机网络异常，点击重新加载" btnTitleStr:@"重新加载" btnClickBlock:btnClickBlock];
    emptyView.autoShowEmptyView = YES;
    return [BDDEmptyView configureEmptyView:emptyView];
}

+ (instancetype)diyEmptyActionViewWithImageType:(EmptyImageType)imageType titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr btnClickBlock:(LYActionTapBlock)btnClickBlock {
   BDDEmptyView *emptyView = [BDDEmptyView emptyActionViewWithImageStr:[self imageStrWithImageType:imageType] titleStr:titleStr detailStr:detailStr btnTitleStr:btnTitleStr btnClickBlock:^{
        btnClickBlock ? btnClickBlock() : nil ;
    }];
    emptyView.autoShowEmptyView = NO;
    return [BDDEmptyView configureEmptyView:emptyView];
}

+(instancetype)diyEmptyViewWithImageType:(EmptyImageType)imageType titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr {
   BDDEmptyView *emptyView = [BDDEmptyView emptyViewWithImageStr:[self imageStrWithImageType:imageType] titleStr:titleStr detailStr:detailStr];
    emptyView.autoShowEmptyView = NO;
    return [BDDEmptyView configureEmptyView:emptyView];
}

+ (instancetype)configureEmptyView:(BDDEmptyView *)emptyView {
    emptyView.detailLabTextColor = Color999999;
    emptyView.detailLabTextColor = Color999999;
    emptyView.actionBtnFont = [UIFont systemFontOfSize:16];
    emptyView.actionBtnTitleColor = [UIColor whiteColor];
    emptyView.actionBtnBackGroundColor = THEME_COLOR;
    return emptyView;
}

+ (NSString *)imageStrWithImageType:(EmptyImageType)imageType {
    NSString *imageStr = nil;
    switch (imageType) {
        case EmptyImageTypeNone:
            imageStr = nil;
            break;
        case EmptyImageTypeNoSearchCom:
            imageStr = @"NoSearchCommunity";
            break;
        case EmptyImageTypeNoPublish:
            imageStr = @"NoData";
            break;
        case EmptyImageTypeNoCoterie:
            imageStr = @"NoCoterie";
            break;
        case EmptyImageTypeNoMessage:
            imageStr = @"NoMessage";
            break;
        case EmptyImageTypeNoNeighbor:
            imageStr = @"NoNeighbor";
            break;
        case EmptyImageTypeNoFriend:
            imageStr = @"NoFriend";
            break;
        case EmptyImageTypeNoNetwork:
            imageStr = @"NoNetwork";
            break;
        case EmptyImageTypeNoImpression:
            imageStr = @"NoImpression";
            break;
        default:
            break;
    }
    return imageStr;
}

@end
