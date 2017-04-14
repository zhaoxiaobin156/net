//
//  ViewController.m
//  5-检测tableView的偏移量
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HeadRefreshView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)HeadRefreshView *refreshView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    
    //加载xib文件，创建HeadRefreshView对象
    self.refreshView = [[NSBundle mainBundle] loadNibNamed:@"HeadRefreshView" owner:self options:nil][0];
    
    self.refreshView.frame = CGRectMake(0, -60, 375, 60);
    
    [self.tableView addSubview:self.refreshView];
}

//KVO响应方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if (object == self.tableView && [keyPath isEqualToString:@"contentOffset"]) {
        
        NSLog(@"%@",change[@"new"]);
    }
}

-(void)dealloc{
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

//停止拖动，松手一瞬间时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    if (scrollView.contentOffset.y < -60) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.tableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
        }];
        
        [self.refreshView.act startAnimating];
        
        self.refreshView.label.text = @"拼命加载中...";
        
        [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3.0];
    }
}

-(void)endRefresh{

    [UIView animateWithDuration:0.25 animations:^{
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
    
    [self.refreshView.act stopAnimating];
    
    self.refreshView.label.text = @"下拉有惊喜";
}

#pragma mark --- UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
