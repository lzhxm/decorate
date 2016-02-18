//
//  InModels.m
//  Decorate
//
//  Created by king on 16/1/15.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "InModels.h"

@implementation InModels

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithInModels:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
