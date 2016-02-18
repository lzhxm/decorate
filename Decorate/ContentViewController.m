//
//  ContentViewController.m
//  Decorate
//
//  Created by king on 16/1/19.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "HeadView.h"
#import "Masonry.h"

@interface ContentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic) CGFloat headViewHeight;

@end

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
static NSString *identifier = @"cell";

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headViewHeight = ScreenH/10;
    CGFloat tableViewHeight = ScreenH-_headViewHeight;
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headViewHeight, ScreenW, tableViewHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.rowHeight = ScreenH/3;
    _tableView.sectionHeaderHeight = 30;
    [_tableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    HeadView *headView = [[HeadView alloc] initWithHeadView:@"套图详情" backgroundImg:[UIImage imageNamed:@"head"]];
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

    
}



- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArray.count;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.filename sd_setImageWithURL:_detailArray[indexPath.row] placeholderImage:[UIImage imageNamed:@"defaut"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _titleString;
        return label;
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
