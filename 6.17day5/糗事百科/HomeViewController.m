//
//  HomeViewController.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "HomeViewController.h"
#import "Interface.h"
#import "AFNetworking.h"
#import "UIViewController+showAlertView.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "HomeDataBase.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) int page; //!< 第几页;

@property (nonatomic, strong) NSMutableArray *dataSource; //!< 数据源;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"糗事百科";
    
    [self initRefresh]; // 上下拉刷新的初始化;
    
    // 让cell自适应:
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 280;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self fetchDataFromLocal]; // 先加载本地数据;
    [self.tableView.header beginRefreshing];// 开始下拉刷新;
}

- (void)initRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self fetchDataFromServer];
    }];
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self fetchDataFromServer];
    }];
}

// 从本地获取数据:
- (void)fetchDataFromLocal
{
    [self.dataSource addObjectsFromArray:[[HomeDataBase shareDataBase] searchAllData]];
}

- (void)fetchDataFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:kMain, self.page]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 如果是下拉刷新,清空数据源;
        if ([self.tableView.header isRefreshing]) {
            [self.dataSource removeAllObjects];
            [[HomeDataBase shareDataBase] delectAllData]; // 清空数据库;
        }
        
        for (NSDictionary *dict in responseObject[@"items"]) {
            
            HomeModel *model = [[HomeModel alloc] initWithDictionary:dict error:nil];
//            NSLog(@"%@", model);
            [self.dataSource addObject:model];
            [[HomeDataBase shareDataBase] insertModel:model];// 插入模型数据;
        }
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showMessage:@"网络错误" andButtonMessage:@"确定"];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell refreshUI:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc] init];
    
    dvc.homeModel = self.dataSource[indexPath.row];
    
    [self.navigationController pushViewController:dvc animated:YES];
}


- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end











