//
//  HomeTableViewCell.m
//  Decorate
//
//  Created by king on 16/1/15.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)setOutModels:(OutModels *)outModels{
    _outModels = outModels;
    self.title.text = outModels.title;
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
