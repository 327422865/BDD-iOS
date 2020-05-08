//
//  BDDLinkTool.m
//  BDDerchant
//
//  Created by 彭英科 on 2020/4/29.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDLinkTool.h"
#import "BDDWebViewController.h"
#import "BDDHUD.h"

@implementation BDDLinkTool

// 根据广告链接或图片链接获取链接中的参数
+ (NSDictionary *)paramFromUrl:(NSString *)url {
    NSArray *array = [url componentsSeparatedByString:@"?"];
    if (array.count == 2) {// 有参数,有且只有一个’？‘
        //参数数组,key=value
        NSArray *keyValueStrArr = [array[1] componentsSeparatedByString:@"&"];
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:keyValueStrArr.count];
        for (NSString *keyValue in keyValueStrArr) {
            NSArray *arr = [keyValue componentsSeparatedByString:@"="];
            if (arr.count == 2) {
                [param setObject:arr.lastObject forKey:arr.firstObject];
            }
        }
        return param;
    } else {
//        BLYLogError(@"站内跳转超链接格式错误：%@", url);
        return nil;
    }
}


@end
