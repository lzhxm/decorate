//
//  wocaModels.m
//  Decorate
//
//  Created by king on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "wocaModels.h"

@implementation wocaModels

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithwocaModels:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
