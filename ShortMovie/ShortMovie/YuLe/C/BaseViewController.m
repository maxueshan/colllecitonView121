 //
//  BaseViewController.m
//  ShortMovie
//
//  Created by MS on 16-5-31.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "BaseViewController.h"

#import "JingPinModel.h"
#import "JingPinTableViewCell.h"
#import "DetailViewController.h"
@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self setMyUrl];
    [self loadData];
    [self createTabelView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_tableView.header beginRefreshing];
}
- (void)initData{
    
    self.page = 1;
    _dataArr = [NSMutableArray array];
}
- (void)setMyUrl{
    
    self.url = JX_DH;

    self.url = [NSString stringWithFormat:self.url,self.page];
}

#pragma mark --createTableView
- (void)createTabelView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 44)];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"JingPinTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self.page = 1;
        [_dataArr removeAllObjects];
        [self setMyUrl];
        [self loadData];
        
    }];
    
    [header setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"上拉刷新" forState:MJRefreshStateRefreshing];
    _tableView.header = header;
    
    //上拉
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        self.page += 1;
        [self setMyUrl];
        [self loadData];
        
    }];
    [footer setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"上拉刷新" forState:MJRefreshStateRefreshing];
    _tableView.footer = footer;
}
#pragma mark -- loadData
- (void)loadData{
    
    [BaseHttpClient requestWithHttpType:GET andParameters:nil andURL:self.url andSucBlock:^(id data, NSURL *url) {
        
        NSDictionary *dic = (NSDictionary *)data;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dict in arr) {
            
            JingPinModel *model = [[JingPinModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataArr addObject:model];
        }
//        NSLog(@"%@",_dataArr);
        
        [_tableView reloadData];
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        NSLog(@"数据加载失败");
    }];
    
    
    
}


#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JingPinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_dataArr.count <= 0 ) {
        return cell;
    }
    JingPinModel *model = _dataArr[indexPath.row];
    [cell loadDataFromJPModel:model];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    JingPinModel *model = _dataArr[indexPath.row];
    detailVC.MyID = [model.postid intValue];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
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
