//
//  ViewController.m
//  6-下拉刷新第三方库
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "MovieCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger page;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"下拉刷新");
        
        self.page = 1;
        
        [self fetchDataFromServer];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSLog(@"上拉刷新");
        
        self.page++;
        
        [self fetchDataFromServer];
    }];
    
    //手动请求网络数据
//    [self fetchDataFromServer];
    
    //手动调用下拉刷新：会调用下拉刷新的block内容
    [self.tableView.header beginRefreshing];
}

-(NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(void)fetchDataFromServer{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://iappfree.candou.com:8080/free/applications/free" parameters:@{@"currency":@"rmb",@"page":[NSString stringWithFormat:@"%ld",self.page]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //下拉刷新，先清空数据源
        if ([self.tableView.header isRefreshing]) {
            
            [self.dataSource removeAllObjects];
        }
        
        for (NSDictionary *dic in responseObject[@"applications"]) {
            
            MovieModel *mod = [[MovieModel alloc] initWithDictionary:dic error:nil];
            
            [self.dataSource addObject:mod];
        }
        
        [self.tableView reloadData];
        
        //停止刷新
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark --- UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MovieModel *mod = self.dataSource[indexPath.row];
    
    [cell refreshUI:mod];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
