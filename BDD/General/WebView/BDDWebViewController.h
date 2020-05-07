//
//  BDDWebViewController.h
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/28.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDDWebViewController : BDDBaseViewController

@property (nonatomic, copy) NSString *url;
///是否展示进度条,默认YES
@property(nonatomic, assign) BOOL showProgressView;
/// 加载的网页内容
@property (nonatomic, copy) NSString *htmlStr;

@end

NS_ASSUME_NONNULL_END
