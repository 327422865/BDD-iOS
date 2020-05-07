//
//  LBXPermissionMedia.m
//  Community
//
//  Created by ZX on 2018/11/8.
//  Copyright © 2018 映山红. All rights reserved.
//

#import "LBXPermissionMedia.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation LBXPermissionMedia


+ (BOOL)authorized {
    if (@available(iOS 9.3, *)) {
        return [self authorizationStatus] == MPMediaLibraryAuthorizationStatusAuthorized;
    }
    return YES;
}

+ (MPMediaLibraryAuthorizationStatus)authorizationStatus API_AVAILABLE(ios(9.3)){
    return  [MPMediaLibrary authorizationStatus];
}

+ (void)authorizeWithCompletion:(void(^)(BOOL granted,BOOL firstTime))completion {
    if (@available(iOS 9.3, *)) {
        MPMediaLibraryAuthorizationStatus status = [self authorizationStatus];
        switch (status) {
            case MPMediaLibraryAuthorizationStatusAuthorized:
            {
                if (completion) {
                    completion(YES,NO);
                }
            }
                break;
            case MPMediaLibraryAuthorizationStatusRestricted:
            case MPMediaLibraryAuthorizationStatusDenied:
            {
                if (completion) {
                    completion(NO,NO);
                }
            }
                break;
            case MPMediaLibraryAuthorizationStatusNotDetermined:
            {
                [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                    if (completion) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(status == MPMediaLibraryAuthorizationStatusAuthorized,YES);
                        });
                    }
                }];
            }
                break;
            default:
            {
                if (completion) {
                    completion(NO,NO);
                }
            }
                break;
        }
    } else {
        completion(YES,NO);
    }
}





@end
