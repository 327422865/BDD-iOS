//
//  BDDSearchHistoryView.h
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDDNoNetWorkHintView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SearchHistoryViewDelegate <NSObject>

@optional
/** 点击标签处理*/
- (void)searchHistoryViewhandleSelectTag:(NSString *)keyWord;
/** 删除历史标签*/
- (void)searchHistoryViewDeleteHistoryTag;

@end

@interface BDDSearchHistoryView : UIView

/**无网络提示*/
@property (nonatomic, strong) BDDNoNetWorkHintView *noNetWorkHintV;

@property (nonatomic ,strong)NSArray * arr;

@property (nonatomic, weak) id <SearchHistoryViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
