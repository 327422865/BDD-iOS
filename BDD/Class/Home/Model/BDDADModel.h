//
//  BDDADModel.h
//  BDD
//
//  Created by 彭英科 on 2020/5/7.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDDADModel : NSObject

@property (nonatomic, copy) NSString *direction;
@property (nonatomic, copy) NSNumber *ID;
@property (nonatomic, copy) NSNumber *createtime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;    ///< 中等图片
@property (nonatomic, copy) NSString *smallUrl; ///< 小图片
@property (nonatomic, copy) NSString *largeUrl; ///< 大图片
@property (nonatomic, copy) NSString *url;      ///< 点击跳转的URL

@end

NS_ASSUME_NONNULL_END
