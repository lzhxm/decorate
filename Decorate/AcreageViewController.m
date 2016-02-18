//
//  AcreageViewController.m
//  Decorate
//
//  Created by king on 16/1/19.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "AcreageViewController.h"
#import "wocaTableViewCell.h"
#import "AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "WatchViewController.h"
#import "HeadView.h"
#import "Masonry.h"
#import "ClassifyCVC.h"

@interface AcreageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *dataDict;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) WatchViewController *watchVC;
@property (nonatomic,strong) NSMutableArray *imgArray;
@property (nonatomic,strong) NSArray *numArray;
@property (nonatomic) CGFloat headViewHeight;
@end
static NSString *identifier = @"cell";
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define RequestURL @"http://mobileapi.to8to.com/smallapp.php"

@implementation AcreageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headViewHeight = ScreenH/10;
    CGFloat collectionViewHeight = ScreenH-_headViewHeight;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(ScreenW/2.5, ScreenW/2.5);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(ScreenH/60, ScreenW/15, 0, ScreenW/15);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,_headViewHeight ,ScreenW ,collectionViewHeight ) collectionViewLayout:flowLayout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"ClassifyCVC" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:_collectionView];
    
    
    
    _numArray =@[@"60以下",@"60到80",@"80到100",@"100到120",@"120到150",@"150以上",];
    NSDictionary *dcit = @{@"action":@"list",@"appid":@"16",@"appostype":@"2",@"appversion":@"3.1.2",@"area":@"",@"channel":@"appstore",@"color":@"0",@"homeType":@"0",@"idfa":@"08F4DBAA-BE1E-42A2-BAD0-58732545CB88",@"model":@"imagessets",@"page":@"1",@"paging":@"1",@"perPage":@"20",@"style":@"0",@"systemversion":@"9.2",@"t8t_device_id":@"33B422E8-3150-45BB-9744-05C2D3F33DFC&",@"to8to_token":@"",@"uid":@"0",@"version":@"2.5"};
    _dataDict = [NSMutableDictionary dictionaryWithDictionary:dcit];    _watchVC = [[WatchViewController alloc] init];
    
    _dataArray = [NSMutableArray array];
    _imgArray = [NSMutableArray array];
    [self addScrollView];
    
    HeadView *headView = [[HeadView alloc] initWithHeadView:@"面积" backgroundImg:[UIImage imageNamed:@"head"]];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).with.offset(0);
        make.left.equalTo(headView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenW, _headViewHeight));
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, _headViewHeight/3, _headViewHeight/1.5, _headViewHeight/1.5);
    [backButton setImage:[UIImage imageNamed:@"btn_back_on@2x"] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 0;
    [self URLRequest:button];
}


- (void)addScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headViewHeight, ScreenW, ScreenH/35)];
    
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
    CGFloat buttonWidth = ScreenW/4;
    for (int i=0; i<_numArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_numArray[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, ScreenH/35);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(URLRequest:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [_scrollView addSubview:button];
        
    }
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, ScreenH/35)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_backgroundView];
    [_scrollView sendSubviewToBack:_backgroundView];
    
    _scrollView.contentSize = CGSizeMake(buttonWidth*_numArray.count, 0);
}


- (void)URLRequest:(UIButton *)button{
    
    CGFloat offSetX = button.frame.origin.x - ScreenW/2;
    offSetX = offSetX > 0 ? (offSetX + ScreenW/4):0;
    offSetX = offSetX > _scrollView.contentSize.width - ScreenW ? _scrollView.contentSize.width - ScreenW : offSetX;
    [_scrollView setContentOffset:CGPointMake(offSetX, 0)];
    _backgroundView.frame = CGRectMake(ScreenW/4*button.tag, 0, ScreenW/4, ScreenH/35);
    switch (button.tag) {
        case 0:
            _dataDict[@"area"] = @"1";
            break;
        case 1:
            _dataDict[@"area"] = @"2";
            break;
        case 2:
            _dataDict[@"area"] = @"3";
            
            break;
        case 3:
            _dataDict[@"area"] = @"4";
            
            break;
        case 4:
            _dataDict[@"area"] = @"5";
            
            break;
        case 5:
            _dataDict[@"space"] = @"6";
            
            break;
        default:
            break;
    }
    
    
    AFHTTPSessionManager *mangager = [AFHTTPSessionManager manager];
    [mangager POST:RequestURL parameters:_dataDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_dataArray removeAllObjects];
        [_imgArray removeAllObjects];
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dict in array) {
            wocaModels *models = [[wocaModels alloc] initWithwocaModels:dict];
            [_dataArray addObject:models];
            NSArray *inArray =dict[@"info"];
            for (NSDictionary *inDict in inArray) {
                wocaModels *inModels = [[wocaModels alloc] initWithwocaModels:inDict];
                [_imgArray addObject:inModels];
                
            }
        }
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    wocaModels *models = self.dataArray[indexPath.row];
    cell.models = models;
    wocaModels *imgModels = self.imgArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:imgModels.filename];
    
    [cell.filename sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaut"]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *urlArray = [NSMutableArray array];
    for (wocaModels *model in _imgArray) {
        NSURL *url = [NSURL URLWithString:model.filename];
        [urlArray addObject:url];
    }
    
    [_watchVC setValue:urlArray forKeyPath:@"imgArray"];
    [_watchVC setValue:@(indexPath.row) forKeyPath:@"num"];
    [self.navigationController pushViewController:_watchVC animated:YES];

    
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
