//
//  OutModels.m
//  Decorate
//
//  Created by king on 16/1/15.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "OutModels.h"
#import "InModels.h"

@implementation OutModels

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (instancetype)initWithOutModels:(NSDictionary *)dict{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        NSArray *array = dict[@"info"];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *dictionary in array) {
            InModels *inModels = [[InModels alloc] initWithInModels:dictionary];
            [mutableArray addObject:inModels];
        }
        self.inModelsArray = mutableArray;
    }
    return self;
}
@end
