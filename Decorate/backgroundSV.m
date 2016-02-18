//
//  backgroundSV.m
//  Decorate
//
//  Created by king on 16/1/30.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "backgroundSV.h"
#import "ClassifyCVC.h"
#import "AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "ScrollView.h"
#import "wocaModels.h"

@interface backgroundSV  ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *midCV;
@property (nonatomic,strong) UICollectionView *nextCV;
//@property (nonatomic,strong) UICollectionView *frontCV;
@property (nonatomic,strong) NSMutableArray *midArray;
@property (nonatomic,strong) NSMutableArray *nextArray;
//@property (nonatomic,strong) NSMutableArray *frontArray;

@end
static NSString *identifier = @"cell";
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define RequestURL @"http://mobileapi.to8to.com/smallapp.php"
@implementation backgroundSV

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.contentSize = CGSizeMake(frame.size.width*3, frame.size.height);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.itemSize = CGSizeMake(ScreenW/2.5, ScreenW/2.5);
        
        flowLayout.sectionInset = UIEdgeInsetsMake(ScreenH/60, ScreenW/15, 0, ScreenW/15);

        
        _midCV = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _midCV.delegate = self;
        [_midCV registerNib:[UINib nibWithNibName:@"ClassifyCVC" bundle:nil] forCellWithReuseIdentifier:identifier];
        _nextCV = [[UICollectionView alloc] initWithFrame:CGRectMake(frame.origin.x*2, frame.origin.y, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        _nextCV.delegate = self;
        [_nextCV registerNib:[UINib nibWithNibName:@"ClassifyCVC" bundle:nil] forCellWithReuseIdentifier:identifier];
//          _frontCV = [[UICollectionView alloc] initWithFrame:CGRectMake(-frame.origin.x, frame.origin.y, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
//        _frontCV.delegate = self;
//        [_frontCV registerNib:[UINib nibWithNibName:@"ClassifyCVC" bundle:nil] forCellWithReuseIdentifier:identifier];
        
        [self addSubview:_midCV];
        [self addSubview:_nextCV];
        //[self addSubview:_frontCV];
    }
    return self;
}

- (void)URLRequest:(NSDictionary *)dict:(UICollectionView *)collectionView{
    
//    CGFloat offSetX = button.frame.origin.x - ScreenW/2;
//    offSetX = offSetX > 0 ? (offSetX + ScreenW/6):0;
//    offSetX = offSetX > _scrollView.contentSize.width - ScreenW ? _scrollView.contentSize.width - ScreenW : offSetX;
//    [_scrollView setContentOffset:CGPointMake(offSetX, 0)];
//    _backgroundView.frame = CGRectMake(ScreenW/6*button.tag, 0, ScreenW/6, ScreenH/35);
    
//    switch (integer) {
//        case 0:
//            _dataDict[@"space"] = @"1";
//            break;
//        case 1:
//            _dataDict[@"space"] = @"2";
//            break;
//        case 2:
//            _dataDict[@"space"] = @"3";
//            
//            break;
//        case 3:
//            _dataDict[@"space"] = @"4";
//            
//            break;
//        case 4:
//            _dataDict[@"space"] = @"5";
//            
//            break;
//        case 5:
//            _dataDict[@"space"] = @"6";
//            
//            break;
//        case 6:
//            _dataDict[@"space"] = @"7";
//            
//            break;
//        case 7:
//            
//            _dataDict[@"space"] = @"8";
//            
//            break;
//        case 8:
//            _dataDict[@"space"] = @"9";
//            
//            break;
//        case 9:
//            _dataDict[@"space"] = @"10";
//            
//            break;
//        default:
//            break;
//    }
    
    if ([collectionView isEqual:_midCV]) {
        AFHTTPSessionManager *mangager = [AFHTTPSessionManager manager];
        [mangager POST:RequestURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_midArray removeAllObjects];
            
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dict in array) {
                wocaModels *models = [[wocaModels alloc] initWithwocaModels:dict];
                [_midArray addObject:models];
            }
            [collectionView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];

    }else if([collectionView isEqual:_nextCV]){
        
    
    AFHTTPSessionManager *mangager = [AFHTTPSessionManager manager];
    [mangager POST:RequestURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_nextArray removeAllObjects];
        
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dict in array) {
            wocaModels *models = [[wocaModels alloc] initWithwocaModels:dict];
            [_nextArray addObject:models];
        }
        [collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([collectionView isEqual:_midCV]) {
        return _midArray.count;
    }else if([collectionView isEqual:_nextCV]){
        return _nextArray.count;
    }
//    }else if ([collectionView isEqual:_frontCV]){
//        return _frontArray.count;
//    }else
        return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([collectionView isEqual:_midCV]) {
        wocaModels *models = _midArray[indexPath.row];
        cell.models = models;
        NSURL *url = [NSURL URLWithString:models.filename];
        [cell.filename sd_setImageWithURL:url placeholderImage:nil];
    }else if([collectionView isEqual:_nextCV]){
        wocaModels *models = _nextArray[indexPath.row];
        cell.models = models;
        NSURL *url = [NSURL URLWithString:models.filename];
        [cell.filename sd_setImageWithURL:url placeholderImage:nil];
    }
//    }else if ([collectionView isEqual:_frontCV]){
//        wocaModels *models = _frontArray[indexPath.row];
//        cell.models = models;
//        NSURL *url = [NSURL URLWithString:models.filename];
//        [cell.filename sd_setImageWithURL:url placeholderImage:nil];
//    }
   
    
    return cell;
}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSMutableArray *urlArray = [NSMutableArray array];
//    for (wocaModels *model in _dataArray) {
//        NSURL *url = [NSURL URLWithString:model.filename];
//        [urlArray addObject:url];
//    }
//    
//    [_watchVC setValue:urlArray forKeyPath:@"imgArray"];
//    [_watchVC setValue:@(indexPath.row) forKeyPath:@"num"];
//    [self.navigationController pushViewController:_watchVC animated:YES];
//    
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
@end
