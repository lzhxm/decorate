//
//  WatchViewController.m
//  Decorate
//
//  Created by king on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "WatchViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "YScrollView.h"

@interface WatchViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIScrollView *subScrollView;

@property (nonatomic) NSInteger preTag;
@property (nonatomic) NSInteger i;
@end

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@implementation WatchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, ScreenW/20, ScreenW/10, ScreenW/10);
    //backButton.backgroundColor = [UIColor redColor];
    [backButton setImage:[UIImage imageNamed:@"icon_back_white@2x"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScreenH/4, ScreenW, ScreenH/2)];
    
    
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _preTag = 100;
  
}

- (void)viewWillAppear:(BOOL)animated{
    _i=0;
    _scrollView.contentOffset = CGPointMake(ScreenW*_num, 0);
    [self addScroll];
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addScroll{
    
    for (NSURL *imgURL in _imgArray) {
        
        YScrollView *suberScrollView = [[YScrollView alloc] initWithFrame:CGRectMake(ScreenW*_i, 0, ScreenW, 300)];
        [suberScrollView.imageView sd_setImageWithURL:imgURL placeholderImage:nil];
        suberScrollView.tag =100+ _i;
        [_scrollView addSubview:suberScrollView];
        _i++;
    }
        _scrollView.contentSize = CGSizeMake(ScreenW*_imgArray.count, 0                   );    [self.view addSubview:_scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentTag = 100+ scrollView.contentOffset.x/ScreenW;
    
    if (currentTag != _preTag) {
        //缩放复位
        YScrollView *imgscrollView = (YScrollView *)[scrollView viewWithTag:_preTag];
        imgscrollView.zoomScale = 1.0;
        
       
        _preTag = currentTag;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
