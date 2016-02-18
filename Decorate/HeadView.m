//
//  HeadView.m
//  Decorate
//
//  Created by king on 16/1/23.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "HeadView.h"
#import "Masonry.h"

@interface HeadView ()

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIImageView *backgroundImg;

@end
@implementation HeadView

- (instancetype)initWithHeadView:(NSString *)title backgroundImg:(UIImage *)img{
    HeadView *headView = [[HeadView alloc] init];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
   
    [headView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).with.offset(0);
        make.left.equalTo(headView).with.offset(0);
        make.right.equalTo(headView).with.offset(0);
        make.bottom.equalTo(headView).with.offset(0);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).with.offset(20);
        make.left.equalTo(headView).with.offset(0);
        make.right.equalTo(headView).with.offset(0);
        make.bottom.equalTo(headView).with.offset(0);

    }];
    
    return headView;
}


@end
