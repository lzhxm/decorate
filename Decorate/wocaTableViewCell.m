//
//  wocaTableViewCell.m
//  Decorate
//
//  Created by king on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "wocaTableViewCell.h"

@implementation wocaTableViewCell

- (void)setModels:(wocaModels *)models{
    
    _models = models;
    self.title.text = models.title;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
