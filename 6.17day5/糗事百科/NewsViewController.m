//
//  NewsViewController.m
//  
//
//  Created by lgh on 16/4/6.
//
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "AFNetworking.h"
#import "Interface.h"
#import "UIViewController+showAlertView.h"
#import "OneCell.h"
#import "TwoCell.h"

@interface NewsViewController () <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@", NSHomeDirectory());
    self.title = @"时事新闻";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OneCell" bundle:nil] forCellReuseIdentifier:@"OneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TwoCell" bundle:nil] forCellReuseIdentifier:@"TwoCell"];
    [self fetchDataFromServer];
}


- (void)fetchDataFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:kNews parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dict in responseObject[0][@"item"]) {
            
            NewsModel *model = [[NewsModel alloc] initWithDictionary:dict error:nil];
            [self.dataSource addObject:model];
            
            NSLog(@"%@", model);
            
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showMessage:@"网络错误" andButtonMessage:@"确定"];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.dataSource[indexPath.row];
    // 三张图片的cell:
    if ([model.type isEqualToString:@"slides"]) {
        TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
        [cell refreshUI:model];
        
        return cell;
    }else{
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell" forIndexPath:indexPath];
        [cell refreshUI:model];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.dataSource[indexPath.row];
    if ([model.type isEqualToString:@"slides"]) {
        return 120;
    }
    return 80;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


@end












