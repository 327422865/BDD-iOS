//
//  LBXPermissionMedia.h
//  Community
//
//  Created by ZX on 2018/11/8.
//  Copyright © 2018 映山红. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 资源媒体库
 */
@interface LBXPermissionMedia : NSObject


+ (BOOL)authorized;

+ (void)authorizeWithCompletion:(void(^)(BOOL granted,BOOL firstTime))completion;

@end

NS_ASSUME_NONNULL_END
