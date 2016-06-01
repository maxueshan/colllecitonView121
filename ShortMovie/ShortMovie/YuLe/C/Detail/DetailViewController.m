//
//  DetailViewController.m
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "DetailViewController.h"
#import "JPDetailModel.h"
#import "JPDetailTableViewCell.h"
#import "PlayViewController.h"

@interface DetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)JPDetailModel *detailModel;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)UIImageView *topImageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setMyUrl];
    [self loadData];
    [self createTabelView];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [_tableView.header beginRefreshing];
}

- (void)setMyUrl{
    
    self.url = DES_DETAIL;
    
    self.url = [NSString stringWithFormat:self.url,self.MyID];
}

#pragma mark --createTableView
- (void)createTabelView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //允许行高,根据label自适应
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 300;
     
    [self.view addSubview:_tableView];
    //注册
    [_tableView registerNib:[UINib nibWithNibName:@"JPDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    
    
    //下拉
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self setMyUrl];
        [self loadData];
        
    }];
    
    [header setTitle:@"下拉刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"上拉刷新" forState:MJRefreshStateRefreshing];
    _tableView.header = header;

    

#pragma mark -- 顶部图片
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,-200, SCREEN_WIDTH, 200)];
    
    _topImageView.image = [UIImage imageNamed:@"bg"];
    
    _topImageView.userInteractionEnabled = YES;
    _tableView.tableHeaderView = _topImageView;
    //播放Btn
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    btn.center = CGPointMake(_topImageView.center.x, _topImageView.center.y);
    btn.alpha = 0.8;
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_topImageView addSubview:btn];
    
}
#pragma mark -- loadData
- (void)loadData{
    
    [BaseHttpClient requestWithHttpType:GET andParameters:nil andURL:self.url andSucBlock:^(id data, NSURL *url) {
        
        NSDictionary *dic = (NSDictionary *)data;
        NSDictionary *dict = dic[@"data"];
        _detailModel = [[JPDetailModel alloc]init];
        
        [_detailModel setValuesForKeysWithDictionary:dict];
        
        //顶部图片
        [_topImageView setImageWithURL:[NSURL URLWithString:_detailModel.image]];
        
        [_tableView reloadData];
        
        [_tableView.header endRefreshing];
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        [_tableView.header endRefreshing];
        NSLog(@"数据加载失败");
    }];
    
    
    
}


#pragma mark -- dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JPDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell loadDataFromDetailModel:_detailModel];
    
    return cell;
}

#pragma mark --点击btn 跳转至播放界面
- (void)btnClicked:(UIButton *)btn{
    PlayViewController *playVC = [[PlayViewController alloc]init];
    
    NSDictionary *dic = _detailModel.download_link;
    NSArray *mpArr = dic[@"mp4"];
    
//    NSLog(@"<><><><><><><>><%@",mpArr[0]);

    playVC.movieURL = mpArr[0];
    
//    NSLog(@"<><><><><><><>><%@",playVC.movieURL);

    
    [self.navigationController pushViewController:playVC animated:YES];
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
