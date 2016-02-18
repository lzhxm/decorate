//
//  wocaTableViewCell.h
//  Decorate
//
//  Created by king on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wocaModels.h"

@interface wocaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *filename;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,strong) wocaModels *models;
@end
