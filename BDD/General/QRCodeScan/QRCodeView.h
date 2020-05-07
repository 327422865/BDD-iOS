//
//  QRCodeView.h
//  Community
//
//  Created by ZX on 2018/10/15.
//  Copyright © 2018 映山红. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QRCodeViewType) {
    QRCodeViewType_My,
    QRCodeViewType_Coterie,
};
NS_ASSUME_NONNULL_BEGIN

@interface QRCodeView : UIView

- (instancetype)initWithType:(QRCodeViewType)type;

- (instancetype)initWithType:(QRCodeViewType)type withLogoImageUrl:(nullable NSString *)logoImageUrl param:(nullable NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
