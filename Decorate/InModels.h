//
//  InModels.h
//  Decorate
//
//  Created by king on 16/1/15.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InModels : NSObject

@property (nonatomic,strong) NSString *filename;
@property (nonatomic,strong) NSString *likenum;
@property (nonatomic,strong) NSString *viewsnum;
@property (nonatomic,strong) NSString *webUrl;

- (instancetype)initWithInModels:(NSDictionary *)dict;

@end
