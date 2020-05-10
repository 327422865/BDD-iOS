//
//  BDDClassifyModel.h
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BDDClassifyNextModel;

@interface BDDClassifyModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *categoryid;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) NSArray <BDDClassifyNextModel *> *courseArray;

@end

@interface BDDClassifyNextModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *categoryid;

@end

NS_ASSUME_NONNULL_END
