//
//  scrollView.m
//  相册
//
//  Created by qingyun on 15/11/29.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "YScrollView.h"


@implementation YScrollView 

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.maximumZoomScale = 2.0;
        self.minimumZoomScale = 0.1;
        
        self.delegate = self;
        
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:self.bounds];
        
        [self addSubview:image];
        _imageView = image;
        

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubeClick:)];
        tap.numberOfTapsRequired = 2;
        
        [self addGestureRecognizer:tap];

    }
    
    return self;
}



-(void)doubeClick:(UIGestureRecognizer *)tapg
{
    if (self.zoomScale != 1.0) {
        [self setZoomScale:1.0 animated:YES];
        return;
    }
    
    
    CGPoint point = [tapg locationInView:self];
    
    CGRect rect = CGRectMake(point.x-100, point.y-100, 100, 100);
    
    [self zoomToRect:rect animated:YES];
    
}

#pragma mark -UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return _imageView;
}

@end
