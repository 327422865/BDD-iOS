//
//  BDDClassifyModel.m
//  BDD
//
//  Created by 彭英科 on 2020/5/9.
//  Copyright © 2020 宝多多. All rights reserved.
//

#import "BDDClassifyModel.h"

@implementation BDDClassifyModel
REPLACE_id_TO_ID

+ (NSDictionary *)mj_objectClassInArray {

    return @{
         @"courseArray": [BDDClassifyNextModel class]
    };
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.categoryid = value;
}

@end


@implementation BDDClassifyNextModel

REPLACE_id_TO_ID

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"categoryid":@"id"};
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"])
        self.categoryid = value;
}

@end
