//
//  BaseViewController.m
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "LimitCell.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int _currentPage;//当前页码，用于上拉刷新
    NSMutableArray *_dataSource;//数据源
}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation BaseViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _currentPage = 1;
        _dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //不要在viewDidLoad里写任何的实现代码，把实现代码写在子方法里
    [self initNavigationBar];
    [self createTableView];
}

-(void)initNavigationBar{

    //左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 44, 30);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"分类" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    //右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 44, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(void)createTableView{

    //如果一个导航控制器中有一个scrollview，那么这个scrollview会自动向下偏移64
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(0);
        
        make.left.equalTo(self.view.mas_left).offset(0);
        
        make.right.equalTo(self.view.mas_right).offset(0);
        
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        
    }];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LimitCell" bundle:nil] forCellReuseIdentifier:@"LimitCell"];
    
    //上拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _currentPage = 1;
        [self loadDataFromNet];
        
    }];
    
    //下拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        _currentPage++;
        [self loadDataFromNet];
        
    }];
    
    //手动调用上拉刷新
    [self.tableView.header beginRefreshing];
    
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    searchBar.placeholder = @"60万款应用搜索看";
    self.tableView.tableHeaderView = searchBar;
}

-(void)observeNetStatus{

    //开始监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //当网络状态发生改变
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            //没网，读数据库
            [self loadDataFromDB];
            
        }else{
        
            //有网，从网络获取数据
            [self loadDataFromNet];
            
        }
        
    }];
}

-(void)loadDataFromDB{
    
    //读取数据库内容
    NSArray *arr = [[SQLManager shareInstance] getDataWithTag:self.tag];
    
    //避免数据重复，清空
    [_dataSource removeAllObjects];
    
    [_dataSource addObjectsFromArray:arr];
    
    [self.tableView reloadData];
}

-(void)loadDataFromNet{

    [[HttpManager shareInstance] getDataByPage:_currentPage AndTag:self.tag AndSuccess:^(id object) {
        
        //每次回到第1页，就清空数据源
        if (_currentPage == 1) {
            
            [_dataSource removeAllObjects];
            
            //插入之前，清空表
            [[SQLManager shareInstance] deleteAllDataWithTag:self.tag];
        }
        
        NSArray *arr = object;
        
        for (NSDictionary *dic in arr) {
            
            LimitModel *mod = [[LimitModel alloc] initWithDictionary:dic error:nil];
            
            if (self.tag == 12) {
                
                mod.expireDatetime = @"0";
                
            }else{
                
                //在这里做时间字符串的处理
                NSMutableString *timeStr = [[NSMutableString alloc] initWithString:mod.expireDatetime];
                
                //去除字符串最后两位
                [timeStr deleteCharactersInRange:NSMakeRange(timeStr.length - 2, 2)];
                
                mod.expireDatetime = timeStr;
            }
            
            //执行插入
            [[SQLManager shareInstance] insertDataWithTag:self.tag AndModel:mod];
            
            [_dataSource addObject:mod];
        }
        
        [self.tableView reloadData];
        
        //停止刷新
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
    } AndFailure:^(NSError *error) {
        
        NSLog(@"获取数据失败，error = %@",error);
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
    }];
}

#pragma mark --- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LimitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LimitCell" forIndexPath:indexPath];
    
    LimitModel *mod = _dataSource[indexPath.row];
    
    cell.mod = mod;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 140;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    LimitModel *mod = _dataSource[indexPath.row];
    
    //self.storyboard：如果self在storyboard中，返回storyboard对象；如果不在，返回nil(和self.navigationController是一样的)
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    detailVC.applicationId = mod.applicationId;
    
    detailVC.hidesBottomBarWhenPushed = YES;
    
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
