//
//  wocaModels.h
//  Decorate
//
//  Created by king on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface wocaModels : NSObject

@property (nonatomic,strong) NSString *filename;
@property (nonatomic,strong) NSString *title;

- (instancetype)initWithwocaModels:(NSDictionary *)dict;

@end
