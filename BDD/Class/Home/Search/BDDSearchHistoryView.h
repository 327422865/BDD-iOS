//
//  BDDSearchHistoryView.h
//  BDD
//
//  Created by 彭英科 on 2020/5/8.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchHistoryViewDelegate <NSObject>

@optional
- (void)searchHistoryViewhandleSelectTag:(NSString *)keyWord;
- (void)searchHistoryViewDeleteHistoryTag;

@end

@interface BDDSearchHistoryView : UIView

@property (nonatomic ,strong)NSArray * arr;

@property (nonatomic, weak) id <SearchHistoryViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
