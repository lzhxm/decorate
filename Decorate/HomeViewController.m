//
//  HomeViewController.m
//  Decorate
//
//  Created by king on 16/1/15.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "OutModels.h"
#import "HomeTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "InModels.h"
#import "DWBubbleMenuButton.h"
#import "FirstViewController.h"
#import "LayoutViewController.h"
#import "StyleViewController.h"
#import "TypeViewController.h"
#import "AcreageViewController.h"
#import "ContentViewController.h"
#import "HeadView.h"
#import "MJRefresh.h"
#import "Masonry.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
//存放请求下来的数据
@property (nonatomic,strong) NSMutableArray *dataArray;
//外层模型数组
@property (nonatomic,strong) NSMutableArray *inModelsArray;
//内层模型数组
@property (nonatomic,strong) NSMutableArray *outModelsArray;
//展示图片数组
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) FirstViewController *firstVC;
@property (nonatomic,strong) LayoutViewController *layoutVC;
@property (nonatomic,strong) StyleViewController *styleVC;
@property (nonatomic,strong) TypeViewController *typeVC;
@property (nonatomic,strong) AcreageViewController *acreageVC;
@property (nonatomic,strong) ContentViewController *contentVC;
@property (nonatomic,strong) NSMutableArray *urlArray;
@end

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define URL @"http://mobileapi.to8to.com/smallapp.php"
#define content @"model=imagesSets&page=1&imei=867323023427543&action=list&appid=16&perPage=30&paging=1&version=2.5&"
static NSString *identifier = @"cell";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat headViewHeight = ScreenH/10;
    CGFloat tableViewHeight = ScreenH-headViewHeight;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,headViewHeight-15 , ScreenW, tableViewHeight+15) style:UITableViewStylePlain];
    
    [self.view addSubview:_tableView];

    _tableView.rowHeight = ScreenH/2.3;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    [self addClickView];
    //添加头视图
    HeadView *headView = [[HeadView alloc] initWithHeadView:@"首页" backgroundImg:[UIImage imageNamed:@"head"]];
        [self.view addSubview:headView];
   
   
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView).with.offset(0);
        make.left.equalTo(headView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenW, headViewHeight));
    }];
    
    NSDictionary *dict = @{@"model":@"imagesSets",@"page":@"1",@"imei":@"867323023427543",@"action":@"list",@"appid":@"16",@"perPage":@"30",@"paging":@"1",@"version":@"2.5"};
    _dataArray = [[NSMutableArray alloc] init];
    _outModelsArray = [[NSMutableArray alloc] init];
    _inModelsArray = [[NSMutableArray alloc] init];
    _imageArray = [[NSMutableArray alloc] init];
    _urlArray = [[NSMutableArray alloc] init];
     [self request:dict];
    
    __weak HomeViewController *weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [weakSelf request:dict];
       
        [_tableView.mj_header endRefreshing];
    }];
//    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [_tableView reloadData];
//        [_tableView.mj_footer endRefreshing];
//    }];
    
}


- (void)addClickView{
    UILabel *homeLabel = [self createHomeButtonView];
    
    DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,
                                                                                          self.view.frame.size.height - homeLabel.frame.size.height - 20.f,
                                                                                          homeLabel.frame.size.width,
                                                                                          homeLabel.frame.size.height)
                                                            expansionDirection:DirectionUp];
    upMenuView.homeButtonView = homeLabel;
    [upMenuView addButtons:[self createDemoButtonArray]];
    
    [self.view addSubview:upMenuView];

}
- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
    
    label.text = @"分类";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"空间", @"局部", @"风格", @"户型", @"面积"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 40.f, 40.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}
- (void)test:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        _firstVC = [[FirstViewController alloc] init];

        [self.navigationController pushViewController:_firstVC animated:YES];
            break;
        case 1:
            _layoutVC = [[LayoutViewController alloc] init];
            [self.navigationController pushViewController:_layoutVC animated:YES];
            break;
        case 2:
            _styleVC = [[StyleViewController alloc] init];
            [self.navigationController pushViewController:_styleVC animated:YES];
            break;
        case 3:
            _typeVC = [[TypeViewController alloc] init];
            [self.navigationController pushViewController:_typeVC animated:YES];
            break;
        case 4:
            _acreageVC = [[AcreageViewController alloc] init];
            [self.navigationController pushViewController:_acreageVC  animated:YES];
            break;
        default:
            break;
    }
}
- (void)request:(NSDictionary *)dict{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:URL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        _dataArray = responseObject[@"data"];
        for (NSDictionary *dcit in _dataArray) {
            OutModels *outModels = [[OutModels alloc] initWithOutModels:dcit];
            [_outModelsArray addObject:outModels];
            NSMutableArray *imgArray = outModels.inModelsArray;
                InModels *models = imgArray[0];
                NSString *imgString = models.filename;
                [_imageArray addObject:imgString];
           
        }
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.outModelsArray.count;
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSURL *imageURL = [NSURL URLWithString:_imageArray[indexPath.row]];
    
    [cell.filename sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"defaut"]];
    cell.outModels = self.outModelsArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_urlArray removeAllObjects];
    OutModels *outModel = self.outModelsArray[indexPath.row];
    NSArray *array = [NSArray arrayWithArray:outModel.inModelsArray];
    for (InModels *iModel in array) {
        
        [_urlArray addObject:iModel.filename];
    }
    
    _contentVC = [[ContentViewController alloc] init];
    [_contentVC setValue:outModel.title forKeyPath:@"titleString"];
    [_contentVC setValue:_urlArray forKeyPath:@"detailArray"];
    [self.navigationController pushViewController:_contentVC animated:YES];
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
