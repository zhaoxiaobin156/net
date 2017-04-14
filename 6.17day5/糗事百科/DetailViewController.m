//
//  DetailViewController.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "DetailViewController.h"
#import "DetailModel.h"
#import "AFNetworking.h"
#import "Interface.h"
#import "UIViewController+showAlertView.h"
#import "DetailModel.h"
#import "DetailCell.h"
#import "HomeCell.h"
#import "MJRefresh.h"
#import "DetailDataBase.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) int page; //!< 第几页

@property (nonatomic, strong) NSMutableArray *dataSource; //!< 数据源;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initRefresh]; // 初始化上下拉刷新;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 77;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"Hcell"];
    
    
    [self fetchDataFromLocal]; 
    [self.tableView.header beginRefreshing]; // 开始刷新
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
// 从本获取数据:
- (void)fetchDataFromLocal
{
    [self.dataSource addObjectsFromArray:[[DetailDataBase shareDataBase] searchAllDataWithId:self.homeModel.myId]];
}

- (void)fetchDataFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:kComment, self.homeModel.myId, self.page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([self.tableView.header isRefreshing]) {
            [self.dataSource removeAllObjects];
            [[DetailDataBase shareDataBase] delectAllDataWithId:self.homeModel.myId];
        }
        
        for (NSDictionary *dict in responseObject[@"items"]) {
            
            DetailModel *model = [[DetailModel alloc] initWithDictionary:dict error:nil];
            [self.dataSource addObject:model];
            
//            NSLog(@"%@", model);
            [[DetailDataBase shareDataBase] insertModel:model andId:self.homeModel.myId];
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

#pragma mark - tableView的代理方法
// 返回段数(组数)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// 返回每一组的行数:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hcell" forIndexPath:indexPath];
        
        [cell refreshUI:self.homeModel];
        
        return cell;
    }else{
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        [cell refreshUI:self.dataSource[indexPath.row]];
        
        return cell;
    }
}


- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end








