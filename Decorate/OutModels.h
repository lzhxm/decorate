//
//  OutModels.h
//  Decorate
//
//  Created by king on 16/1/15.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OutModels : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *rows;
@property (nonatomic,strong) NSString *webUrl;
@property (nonatomic,strong) NSMutableArray *inModelsArray;

- (instancetype)initWithOutModels:(NSDictionary *)dict;

@end
