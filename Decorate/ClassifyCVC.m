//
//  ClassifyCVC.m
//  Decorate
//
//  Created by king on 16/1/27.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ClassifyCVC.h"

@implementation ClassifyCVC

- (void)awakeFromNib {
    self.filename.layer.masksToBounds = YES;
    self.filename.layer.cornerRadius = 20;
}

- (void)setModels:(wocaModels *)models{
    _models = models;
    self.title.text = models.title;                          
}
@end
